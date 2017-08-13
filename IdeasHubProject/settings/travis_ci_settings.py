"""
Settings used for TravisCI testings.
"""
from base_settings import *

DEBUG = True

# Database
# https://docs.djangoproject.com/en/dev/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'derkle$ideashub',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': '127.0.0.1'
    }
}
