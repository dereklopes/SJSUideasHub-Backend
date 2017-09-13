from rest_framework import serializers
from .models import Idea, Comment, Category, User, IdeaLike


class IdeaSerializers(serializers.ModelSerializer):
    class Meta:
        model = Idea
        # or return all attributes
        fields = '__all__'


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class CommentSerializers(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'


class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class IdeaLikeSerializers(serializers.ModelSerializer):
    class Meta:
        model = IdeaLike
        fields = '__all__'
