from django.http import HttpResponse
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import generics
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.parsers import JSONParser
from rest_framework.renderers import JSONRenderer

from filters import CommentFilter
from .models import Idea, Comment, Category
from .serializers import IdeaSerializers, CommentSerializers, CategorySerializer

from oauth2client import client, crypt


class JSONResponse(HttpResponse):
    """
    An HttpResponse that renders its content into JSON.
    """


    @csrf_exempt
    def __init__(self, data, **kwargs):
        content = JSONRenderer().render(data)
        kwargs['content_type'] = 'application/json'
        super(JSONResponse, self).__init__(content, **kwargs)


# list all ideas
# ideas/
@method_decorator(csrf_exempt, name='dispatch')
class IdeasList(generics.ListCreateAPIView):
    # list all ideas available

    queryset = Idea.objects.all()
    serializer_class = IdeaSerializers
    filter_class = CommentFilter(generics.ListAPIView)
    filter_backends = (DjangoFilterBackend,)
    pagination_class = LimitOffsetPagination

    # query:
    # startIndex=x -- ideaId >= x
    # endIndex=x -- ideaId <= x
    # category=string -- category
    # sort=likes -- descending
    # sort=newest -- descending
    # sort=oldest -- ascending
    # userId = x -- all ideas of user x
    def get_queryset(self):
        queryset = Idea.objects.all()
        startindex = self.request.query_params.get('startIndex', None)
        endindex = self.request.query_params.get('endIndex', None)
        category = self.request.query_params.get('category', None)
        sort = self.request.query_params.get('sort', None)
        author = self.request.query_params.get('author', None)

        if category is not None:
            queryset = queryset.filter(category__icontains=category)  # case-insensitive
        if startindex and endindex is not None:
            queryset = queryset.filter(ideaId__range=(startindex, endindex))
        elif startindex is not None:
            queryset = queryset.filter(ideaId__gte=startindex)
        elif endindex is not None:
            queryset = queryset.filter(ideaId__lte=startindex)
        if sort is not None:
            if sort == "likes":
                queryset = queryset.order_by("-likes")  # sort by likes
            if sort == "newest":
                queryset = queryset.order_by("-ideaId")  # sort by newest
            if sort == "oldest":
                queryset = queryset.order_by("ideaId")  # sort by oldest
            if author is not None:
                queryset = queryset.filter(author__exact=author)

        return queryset

    def get(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = IdeaSerializers(queryset, many=True)
        return JSONResponse(serializer.data)

    @csrf_exempt
    def post(self, request, *args, **kwargs):
        data = JSONParser().parse(request)
        serializer = IdeaSerializers(data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data, status=201)
        return JSONResponse(serializer.errors, status=400)


# comment/
# comment/?idea_id=..
class CommnentList(generics.ListCreateAPIView):
    # list all ideas available

    queryset = Comment.objects.all()
    serializer_class = CommentSerializers
    filter_class = CommentFilter(generics.ListAPIView)
    filter_backends = (DjangoFilterBackend,)

    def get_queryset(self):
        queryset = Comment.objects.all()

        ideaid = self.request.query_params.get('ideaid', None)  # ?idea_id=...

        if ideaid is not None:
            queryset = queryset.filter(ideaId__exact=ideaid)

        return queryset

    def get(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = CommentSerializers(queryset, many=True)
        return JSONResponse(serializer.data)

    @csrf_exempt
    def post(self, request, *args, **kwargs):
        data = JSONParser().parse(request)
        serializer = CommentSerializers(data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data, status=201)
        return JSONResponse(serializer.errors, status=400)


# authorize/?userId=&token=
def AuthorizeToken(request):
    if request.method == 'POST':
        token = request.POST['token']
        userid = request.POST['userId']
        if token and userid:
            try:
                # idinfo = {'userId': userid, 'token': token}
                idinfo = client.verify_id_token(token, userid)
                return JSONResponse(idinfo, status=200)
            except crypt.AppIdentityError:
                # Invalid token
                return JSONResponse("Invalid token", status=400)
    elif request.method == 'GET':
        return JSONResponse("Invalid request", status=400)


# categories/
def CategoriesList(request):
    if request.method == 'GET':
        categories = Category.objects.all()
        serializer = CategorySerializer(categories, many=True)
        return JSONResponse(serializer.data)

    if request.method == 'POST':
        category = Category()
        category.title = request.GET.get('title', None)
        if category.title:
            category.save()
            return JSONResponse('Created category ' + category.title, status=201)
        return JSONResponse('Unable to create category', status=400)
