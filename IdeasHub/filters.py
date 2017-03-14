import django_filters
from models import Comment, User, Idea


class CommentFilter(django_filters.FilterSet):

    ideaid = django_filters.NumberFilter(name="ideaId", lookup_type='exact')  # name: of the filter


    class Meta:
        model = Comment
        fields = ["ideaId", ]


class UserFilter(django_filters.FilterSet):

    userid = django_filters.NumberFilter(name="userId", lookup_type='exact')  # name: of the filter


    class Meta:
        model = Comment
        fields = ["userId", ]


class IdeaFilter(django_filters.FilterSet):

    startIndex = django_filters.NumberFilter(name="ideaId", lookup_type='gte')
    toIndex = django_filters.NumberFilter(name="ideaId", lookup_type='lte')
    category = django_filters.CharFilter(name="category", lookup_type="business")


    class Meta:
        model = Idea
        fields = ["ideaId", "category"]