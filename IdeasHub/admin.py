from django.contrib import admin

from IdeasHub import models

#  Register your models here.
allModels = [models.Comment, models.Idea]

admin.site.register(allModels)
