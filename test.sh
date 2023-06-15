#!/bin/bash

# rm ./otros.txt 
# key="QPMGL8ZP1SHHEM900DRNVPIAF3M9XJX7GHO6UU5HAWZFFNLD26985GKDRT2F2NQ6AEEC6T2WMJG1XMJC"
# url="https://www.bumeran.com.pe/perfiles/empresa_hudbay-peru_10097690.html"
# curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

# cat otros.txt \
#  | grep -oP '(?<=<h2 class="sc-vBKru gONUaj">)(.*?)(?=<\/h2>)' \
#  | sort | uniq