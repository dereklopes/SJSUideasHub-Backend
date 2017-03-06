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