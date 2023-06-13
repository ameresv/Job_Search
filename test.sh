#!/bin/bash

# rm ./otros.txt 
key="TU0SLJK06EC4FYDSW6NLKFILF0PX2XNVCSYDNSZC8JNWFN4RDKMFJFEHOS8X3127TVC6E011EFYGLFI1"
url="https://www.bumeran.com.pe/perfiles/empresa_hudbay-peru_10097690.html"
curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=${url}" > otros.txt

# cat otros.txt \
#  | grep -oP '(?<=<h2 class="sc-gbuiJB dWiCmc">)(.*?)(?=<\/h2>)' \
#  | sort | uniq