import django_filters

from IdeasHub.models import Comment, Idea


class CommentFilter(django_filters.FilterSet):

    ideaId = django_filters.NumberFilter(name="ideaId", lookup_type='exact')  # name: of the filter


    class Meta:
        model = Comment
        fields = ["ideaId"]


class IdeaFilter(django_filters.FilterSet):

    startIndex = django_filters.NumberFilter(name="ideaId", lookup_type='gte')
    toIndex = django_filters.NumberFilter(name="ideaId", lookup_type='lte')
    category = django_filters.CharFilter(name="category", lookup_type="business")
    author = django_filters.CharFilter(name="author", lookup_type="exact")
    ideaId = django_filters.NumberFilter(name="ideaId", lookup_type='exact')

    class Meta:
        model = Idea
        fields = ["ideaId", "category", "author"]