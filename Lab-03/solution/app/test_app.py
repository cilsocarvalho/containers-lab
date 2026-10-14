import unittest
from app import app
class AppTest(unittest.TestCase):
 def setUp(self): self.client=app.test_client()
 def test_home(self):
  r=self.client.get("/")
  self.assertEqual(r.status_code,200)
  self.assertEqual(r.get_data(as_text=True),"Container Technologies")
 def test_health(self):
  r=self.client.get("/health")
  self.assertEqual(r.status_code,200)
  self.assertEqual(r.json["status"],"ok")
