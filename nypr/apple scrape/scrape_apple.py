#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 28 16:20:56 2018

@author: tnazal
"""

##libraries
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import pandas as pd
import time
import re

#functions

##set-up webdriver
driver = webdriver.Chrome()


##website here
driver.get("https://podcastsconnect.apple.com/analytics/shows")
WebDriverWait(driver, 10).until(EC.
             frame_to_be_available_and_switch_to_it((By.ID,
                                                     'aid-auth-widget-iFrame')))
ids = driver.find_elements_by_xpath('//*[@id]')
for i in ids:
    print(i.get_attribute('id'))

WebDriverWait(driver, 10).until(EC.element_to_be_selected((By.XPATH, '//*[@id = "account_name_text_field"]')))


##get user and field, populate, click
us = driver.find_elements_by_xpath('//*[@id = "account_name_text_field"]')

bttn = driver.find_elements_by_xpath('//*[@id = "sign-in"]')

us[0].send_keys('applepodcastsadmin@nypublicradio.org')

bttn[0].click()

time.sleep(3)


#get password field, populate, go
pw = driver.find_elements_by_xpath('//*[@id = "password_text_field"]')

bttn = driver.find_elements_by_xpath('//*[@id = "sign-in"]')

pw[0].send_keys('vWS7P6Uf')

bttn[0].click()


##load page
time.sleep(7)


##parse source code
soup = BeautifulSoup(driver.page_source, 'html.parser')


#close driver
driver.quit()
##tables in page
tables =  soup.find_all('table', limit = 1)
##rows in table
table_rows = tables[0].find_all('tr')
#generate
pod_data = [[td.find('div', {'class': 'title'}).getText() if
             td.get('class')[0] == 'podcast' else
             td.getText().replace('\xa0', '').replace('\n', '')
             for td in table_rows[i].findAll('td')]
for i in range(1,len(table_rows))]
#make dataframe
colnames = ['show', 'devices', 'total_time_hrs', 'time_per_device']
pod_df = pd.DataFrame(pod_data, columns = colnames)
#clean
pod_df = pod_df.applymap(lambda x: x.strip())
pod_df[['devices', 'total_time_hrs']] = pod_df[['devices', 'total_time_hrs']].\
applymap(lambda x: pd.to_numeric(re.sub(',|-|hrs|hr|mins|min', '', x)))

pod_df['time_per_device'] = [pd.to_numeric(i[0]) if len(i) < 2 else
      (pd.to_numeric((re.sub('hrs|hr', '', i[0]))) * 60)  +
      pd.to_numeric(re.sub('hrs|hr', '', i[1]))
      for i in pod_df['time_per_device'].apply(lambda x: re.sub('mins|min|-',
                       '', str(x)).strip()).str.split(" ")]













