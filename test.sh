#!/bin/bash

# rm ./otros.txt 
# key="D5NBVDLUWATIJR92ZJE3JCV3JNY1ZV3E4BBJNCCOMF2BZ695A2RFV7WM1PFT13IBKORQ86FRIYNPQAMY"
# url="https://www.bumeran.com.pe/perfiles/empresa_hudbay-peru_10097690.html"
# curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

# rm ./otros.txt 
# key="QPMGL8ZP1SHHEM900DRNVPIAF3M9XJX7GHO6UU5HAWZFFNLD26985GKDRT2F2NQ6AEEC6T2WMJG1XMJC"
# url="https://jobs.airavirtual.com/antamina"
# curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

cat otros.txt \
 | grep -oP '(?<=<h2 class="sc-jiTwWT bufYMl">)(.*?)(?=<\/h2>)' \
 | sort | uniq
