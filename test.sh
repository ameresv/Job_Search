#!/bin/bash

 # rm ./otros.txt 
 # key="WPRAB58DS0PBCX3VN8DOBQDYDFRABHKHOFVSC46FMQKV8MENT0L4X8VUD9XWSPQWJWTLAKTCC1RIU688"
 # url="https://www.bumeran.com.pe/perfiles/empresa_hudbay-peru_10097690.html"
 # curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

# rm ./otros.txt 
# key="QPMGL8ZP1SHHEM900DRNVPIAF3M9XJX7GHO6UU5HAWZFFNLD26985GKDRT2F2NQ6AEEC6T2WMJG1XMJC"
# url="https://jobs.airavirtual.com/antamina"
# curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

cat otros.txt \
 | grep -oP '(?<=<h3 class="sc-liPmeQ dZgIwK">)(.*?)(?=<\/h3>)' \
 | sort | uniq
