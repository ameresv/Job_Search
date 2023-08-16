#!/bin/bash

 #rm ./otros.txt 
 #key="P7GJTQJTI3W9B79TVAG6YRM9M172WGJ6FHKOPP8ZV629Y48NGIX8VHHOC3FSTVR701ZCDO54ED7L3EB5"
 #url="https://www.bumeran.com.pe/perfiles/empresa_hudbay-peru_10097690.html"
 #curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

# rm ./otros.txt 
# key="QPMGL8ZP1SHHEM900DRNVPIAF3M9XJX7GHO6UU5HAWZFFNLD26985GKDRT2F2NQ6AEEC6T2WMJG1XMJC"
# url="https://jobs.airavirtual.com/antamina"
# curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

cat otros.txt \
 | grep -oP '(?<=<h3 class="sc-jUiVId crPxbh">)(.*?)(?=<\/h3>)' \
 | sort | uniq
