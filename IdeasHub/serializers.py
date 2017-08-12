from rest_framework import serializers
from .models import Idea, Comment, Category


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