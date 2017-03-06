from django.contrib import admin

from IdeasHub import models

#  Register your models here.
allModels = [models.Comment, models.Idea, models.User]

admin.site.register(allModels)
