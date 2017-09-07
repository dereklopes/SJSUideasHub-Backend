
import json
from django.test import TestCase, RequestFactory

from .views import IdeasList


class IdeasTestCase(TestCase):
    test_idea = {
        'title': 'TEST-title',
        'author': 'TEST-author0',
        'category': 'TEST-category0',
        'content': 'TEST-content',
        'likes': 4,
        'date': '2017-01-01'
    }
    factory = RequestFactory()

    @classmethod
    def setUpClass(cls):
        super(IdeasTestCase, cls).setUpClass()
        # post 3 ideas as set up with different info
        idea = cls.test_idea
        for i in range(0, 3):
            idea['likes'] += 1
            idea['date'] = '2017-01-' + str(int(idea['date'][9:10]) + 1).zfill(2)
            idea['category'] = 'TEST-category' + str(int(idea['category'][13]) + 1)
            idea['author'] = 'TEST-author' + str(int(idea['author'][11]) + 1)
            request = cls.factory.post('ideas/', data=json.dumps(idea), content_type='application/json')
            IdeasList.as_view()(request)

    def test_idea_post(self):
        # go right
        request = self.factory.post('ideas/', data=json.dumps(self.test_idea), content_type='application/json')

        response = IdeasList.as_view()(request)
        self.assertEqual(response.status_code, 201, 'Failed to post idea')

        response_json = json.loads(response.content)
        for key, value in self.test_idea.items():
            self.assertEqual(response_json[key], value, 'Did not post correct information')

        # go wrong - no parameters
        self.test_idea.pop('title')
        request = self.factory.post('ideas/', data=json.dumps(self.test_idea), content_type='application/json')
        response = IdeasList.as_view()(request)
        self.assertEqual(response.status_code, 400, 'Posted idea without parameters')

    def test_idea_get_all(self):
        request = self.factory.get('ideas/')

        response = IdeasList.as_view()(request)
        self.assertEqual(response.status_code, 200, 'Failed to get all ideas')

        response_json = json.loads(response.content)
        self.assertEqual(len(response_json), 3, 'Response json was empty')

    def get_json_response(self, endpoint):
        request = self.factory.get(endpoint)

        self.assertIsNotNone(request, 'Request came back as None')

        response = IdeasList.as_view()(request)
        self.assertEqual(response.status_code, 200, 'Failed to get list of ideas')

        return json.loads(response.content)

    def check_sorted_json_response(self, sort_by, attribute, comparison):
        if comparison is None:
            comparison = self.assertLessEqual

        response_json = self.get_json_response('ideas/?sort=' + sort_by)

        prev_attribute = None
        for idea in response_json:
            if prev_attribute is not None:
                comparison(
                    idea[attribute], prev_attribute, 'Ideas are not sorted by ' + sort_by + ' ' + attribute
                )
            prev_attribute = idea[attribute]

    def test_idea_get_likes(self):
        self.check_sorted_json_response('likes', 'likes', self.assertLessEqual)

    def test_idea_get_newest(self):
        self.check_sorted_json_response('newest', 'date', self.assertLessEqual)

    def test_idea_get_oldest(self):
        self.check_sorted_json_response('oldest', 'date', self.assertGreaterEqual)

    def test_idea_get_author(self):
        response_json = self.get_json_response('ideas/?author=' + self.test_idea['author'])
        for idea in response_json:
            self.assertEqual(idea['author'], self.test_idea['author'], 'Ideas are not sorted by author')

        response_json = self.get_json_response('ideas/?sort=newest&author=' + self.test_idea['author'])
        for idea in response_json:
            self.assertEqual(idea['author'], self.test_idea['author'], 'Ideas are not sorted by author')

    def test_idea_get_ideaid(self):
        response_json = self.get_json_response('ideas/?ideaid=1')
        for idea in response_json:
            self.assertEqual(idea['ideaId'], 1, 'Ideas are not filtered by ideaid')

    def test_idea_get_ideaid_range(self):
        response_json = self.get_json_response('ideas/?startIndex=1&endIndex=2')
        for idea in response_json:
            self.assertGreater(idea['ideaId'], 0, 'Ideas are not filtered by ideaid range')
            self.assertLess(idea['ideaId'], 3, 'Ideas are not filtered by ideaid range')

        response_json = self.get_json_response('ideas/?startIndex=2')
        for idea in response_json:
            self.assertGreaterEqual(idea['ideaId'], 2, 'Ideas are not filtered by ideaid range')

        response_json = self.get_json_response('ideas/?endIndex=2')
        for idea in response_json:
            self.assertLessEqual(idea['ideaId'], 2, 'Ideas are not filtered by ideaid range')

    def test_idea_get_category(self):
        response_json = self.get_json_response('ideas/?category=' + self.test_idea['category'])
        for idea in response_json:
            self.assertEqual(idea['category'], self.test_idea['category'], 'Ideas are not filtered by category')
