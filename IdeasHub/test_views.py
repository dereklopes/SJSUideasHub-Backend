from django.test import TestCase
from django.http import HttpRequest

from views import AuthorizeToken


class AuthTokenTestCase(TestCase):
    request = None

    def test_invalid_token(self):
        """Go wrong - invalid token"""
        userid = 'invalidUserId@notanemail.com'
        token = 'notarealtoken123'
        self.request = HttpRequest()
        self.request.POST = {'userid': userid, 'token': token}
        AuthorizeToken(self.request)
