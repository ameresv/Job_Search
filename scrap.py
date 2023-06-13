import requests
from bs4 import BeautifulSoup
from selenium import webdriver

# URL="https://antapaccay.hiringroom.com/jobs?source=linkedinjobs"
# dr = webdriver.Chrome()
# dr.get(URL)

# soup = BeautifulSoup(dr.page_source,"html.parser")
# results = soup.find(id="section-vacantes")
# job_elements = results.find_all("div", class_="card-body p-0 d-flex flex-column")


# for job_element in job_elements:
#     title_element = job_element.find("h4", class_="font-black m-0 mb-2 fs-20 name__vacancy")
#     print(title_element.text.strip())


URL="https://phyllismottaphotography.shootproof.com/gallery/21530886/home"
dr = webdriver.Chrome()
dr.get(URL)

soup = BeautifulSoup(dr.page_source,"html.parser")

with open("output.txt", "a") as f:
    print(soup, file=f)
# results = soup.find(id="section-vacantes")
# job_elements = results.find_all("div", class_="card-body p-0 d-flex flex-column")


# for job_element in job_elements:
#     title_element = job_element.find("h4", class_="font-black m-0 mb-2 fs-20 name__vacancy")
#     print(title_element.text.strip())