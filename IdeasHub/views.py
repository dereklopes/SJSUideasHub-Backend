import json

from django.db.utils import IntegrityError
from django.http import HttpResponse
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import generics
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.parsers import JSONParser
from rest_framework.renderers import JSONRenderer

from .filters import CommentFilter
from .models import Idea, Comment, Category, IdeaLike, User
from .serializers import IdeaSerializers, CommentSerializers, CategorySerializer, UserSerializers, IdeaLikeSerializers

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
        ideaid = self.request.query_params.get('ideaid', None)
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
            queryset = queryset.filter(ideaId__lte=endindex)
        elif ideaid is not None:
            queryset = queryset.filter(ideaId__range=(ideaid, ideaid))
        if sort is not None:
            if sort == "likes":
                queryset = queryset.order_by("-likes")  # sort by likes
            if sort == "newest":
                queryset = queryset.order_by("-ideaId")  # sort by newest
            if sort == "oldest":
                queryset = queryset.order_by("ideaId")  # sort by oldest
            if author is not None:
                queryset = queryset.filter(author__exact=author)
        elif author is not None:
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


def LikeIdea(request):
    if request.method == 'POST':
        idea_id = request.GET.get('ideaid', None)
        user_id = request.GET.get('user', None)
        if idea_id is None:
            return JSONResponse('ideaid is a required parameter')
        if user_id is None:
            return JSONResponse('user is a required parameter')
        user = User.objects.filter(user_id__exact=user_id)
        idea = Idea.objects.filter(ideaId__exact=idea_id)
        if user[0] is not None and idea[0] is not None:
            try:
                like = IdeaLike(user=user[0], idea_id=idea[0])
                like.save()
                idea[0].likes.add(like)
                return JSONResponse('Added ' + str(user[0].user_id) + ' to likes on idea ' + idea_id, status=201)
            except IntegrityError:
                return JSONResponse('Idea ' + idea_id + ' is already liked by user ' + str(user[0].user_id), status=409)
        return JSONResponse('Failed to add like', status=400)

    if request.method == 'GET':
        idea_id = request.GET.get('ideaid', None)
        user_id = request.GET.get('user', None)
        # Check if a user has liked an idea
        if idea_id is not None and user_id is not None:
            idea_like = IdeaLike.objects.filter(user_id__exact=user_id, idea_id__exact=idea_id)
            serializer = IdeaLikeSerializers(idea_like, many=True)
            if len(serializer.data) == 0:
                return JSONResponse(False, status=200)
            return JSONResponse(True, status=200)
        # Get all likes for an idea
        elif idea_id is not None:
            idea_like = IdeaLike.objects.filter(idea_id__exact=idea_id)
            serializer = IdeaLikeSerializers(idea_like, many=True)
            return JSONResponse(serializer.data, status=200)
        return JSONResponse('ideaid is required', status=400)


def Users(request):
    if request.method == 'GET':
        user_id = request.GET.get('userid', None)
        name = request.GET.get('name', None)
        email = request.GET.get('email', None)
        if user_id is not None:
            users = User.objects.filter(user_id__exact=user_id)
        elif email is not None:
            users = User.objects.filter(email__exact=email)
        elif name is not None:
            users = User.objects.filter(name__exact=name)
        else:
            return JSONResponse('userid or name is required', status=400)
        if len(users) == 0:
            return JSONResponse('user not found', status=400)
        serializer = UserSerializers(users, many=True)
        return JSONResponse(serializer.data, status=200)

    if request.method == 'POST':
        name = request.GET.get('name', None)
        email = request.GET.get('email', None)
        if name is not None and email is not None:
            new_user = User(name=name, email=email)
            new_user.save()
            return JSONResponse("New user created", status=201)
