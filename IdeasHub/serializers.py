from rest_framework import serializers
from .models import User, Idea, Comment


class IdeaSerializers(serializers.ModelSerializer):
    class Meta:
        model = Idea
        # or return all attributes
        fields = '__all__'


class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class CommnentSerializers(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'