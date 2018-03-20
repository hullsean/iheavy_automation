import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

class IHeavyComSearch(unittest.TestCase):

    def setUp(self):
        self.driver = webdriver.Firefox()

    def test_search_in_iheavy_com(self):
        driver = self.driver
        driver.get("http://www.iheavy.com")
        self.assertIn("Scalable Startups", driver.title)
        #elem = driver.find_element_by_name("q")
        #elem.send_keys("Sean")
        #elem.send_keys(Keys.RETURN)
        assert "No results found." not in driver.page_source


    def tearDown(self):
        self.driver.close()

if __name__ == "__main__":
    unittest.main()
    