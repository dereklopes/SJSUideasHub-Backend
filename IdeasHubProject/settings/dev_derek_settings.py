"""
Local dev settings for Derek Lopes
"""

from .base_settings import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# Database
# https://docs.djangoproject.com/en/dev/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'derkle$ideashub',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': 'localhost'
    }
}
