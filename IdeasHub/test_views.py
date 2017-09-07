
import json
from django.test import TestCase
from rest_framework.test import APIClient
from django.http import HttpRequest

from .views import AuthorizeToken


class AuthTokenTestCase(TestCase):
    request = None

    def test_invalid_token(self):
        """Go wrong - invalid token"""
        userid = 'invalidUserId@notanemail.com'
        token = 'notarealtoken123'
        self.request = HttpRequest()
        self.request.POST = {'userid': userid, 'token': token}
        AuthorizeToken(self.request)


class CategoriesTestCase(TestCase):
    client = APIClient()

    def test_categories_post_get(self):
        """Go right - post a test category and get it back"""
        title = 'TEST'
        response = self.client.post('/categories/?title=' + title)
        self.assertEqual(response.status_code, 201, 'Failed to post category: status code')

        response = self.client.get('/categories/')
        self.assertEqual(response.status_code, 200, 'Failed to get category')
        response_json = json.loads(response.content[1:len(response.content) - 1])
        response_title = response_json['title']
        self.assertEqual(response_title, title, 'Incorrect title: ' + response_title)
