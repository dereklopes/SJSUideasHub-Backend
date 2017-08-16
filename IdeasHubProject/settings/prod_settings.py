"""
Setting for prod.

Used in deployment to PythonAnywhere.
"""

from .base_settings import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

# Database
# https://docs.djangoproject.com/en/dev/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'derkle$ideashub',
        'USER': 'derkle',
        'PASSWORD': 'sjsu100w',
        'HOST': 'derkle.mysql.pythonanywhere-services.com'
    }
}

