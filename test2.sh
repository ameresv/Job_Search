#!/bin/bash

 # rm ./otros.txt 
 # key="WPRAB58DS0PBCX3VN8DOBQDYDFRABHKHOFVSC46FMQKV8MENT0L4X8VUD9XWSPQWJWTLAKTCC1RIU688"
 # url="https://www.glencore.com/careers/career-opportunities/south-america"
 # curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros2.txt

# rm ./otros.txt 
# key="QPMGL8ZP1SHHEM900DRNVPIAF3M9XJX7GHO6UU5HAWZFFNLD26985GKDRT2F2NQ6AEEC6T2WMJG1XMJC"
# url="https://jobs.airavirtual.com/antamina"
# curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

cat otros2.txt \
  | grep -oP '(?<="block align-middle py-2 px-1 md:py-2 md:px-3 xl:px-4"><div><span class=")(.*?)(?=<\/span>)' \
  | grep -oP '(?<=\">).*' \
  | sort | uniq

