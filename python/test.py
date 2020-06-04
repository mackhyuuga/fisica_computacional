from selenium import webdriver

driver = webdriver.Chrome(executable_path=r'./chromedriver')
driver.get('https://www.youtube.com')