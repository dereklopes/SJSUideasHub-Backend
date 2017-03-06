import django_filters
from models import Comment, User, Idea


class CommentFilter(django_filters.FilterSet):

    ideaid = django_filters.NumberFilter(name="ideaid", lookup_type='exact')


    class Meta:
        model = Comment
        fields = "__all__"