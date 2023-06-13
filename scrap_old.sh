#!/bin/bash
#website="https://minerachinalco.hiringroom.com/jobs"
#website="https://antapaccay.hiringroom.com/jobs?source=linkedinjobs"
#website="https://careers.mmg.com/caw/es/listing"
#website="https://www.crugroup.com/careers/opportunities?page="
#website="https://careers.bhp.com/search?q=&q2=&alertId=&title=&location=Chile&date=&facility="

#echo $website
# curl -s $website > test.txt 2>/dev/null

# get_data_1 () {
    # curl -s $1 > test.txt 2>/dev/null
    # cat test.txt \
    # | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' \
    # | awk '{ printf "%s ", $0 } END { printf "\n" }' \
    # | grep -oP '(?<=vacancy"> )(.*?)(?=<\/h4>)' >> result.txt
# }

# get_data_3 () {
    # for page in {1..5}; do
    #     url="${1}${page}"
    #     curl -s "$url" >> test.txt 2>/dev/null   
    # done 
    # cat test.txt \
    #     | grep -oP '(?<=<a href="/careers/opportunities/)(.*?)(?=<\/a>)' \
    #     | grep -oP '(?<=/">)(.*?)$' \
    #     | sort | uniq >> result.txt 
# }

# get_data_4 () {
    # curl -s $1 > test.txt 2>/dev/null
    # cat test.txt \
    #     | grep -oP '(?<=<a class="jobTitle-link" href="/job/)(.*?)(?=<\/a>)' \
    #     | grep -oP '(?<=/">)(.*?)$' >> result.txt 
# }

# cat test.txt \
#     | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' \
#     | awk '{ printf "%s ", $0 } END { printf "\n" }' \
#     | grep -oP '(?<=vacancy"> )(.*?)(?=<\/h4>)' > test3.txt

# cat test.txt \
#     | grep -oP '(?<=<h3><a class="job-link" href="/caw/es/job/)(.*?)(?=<\/a>)' \
#     | grep -oP '(?<=>).*' | sort | uniq > test4.txt

# for page in {1..5}; do
#     url="${website}${page}"
#     curl -s "$url" >> test.txt 2>/dev/null   
# done 

# cat test.txt \
#     | grep -oP '(?<=<a href="/careers/opportunities/)(.*?)(?=<\/a>)' \
#     | grep -oP '(?<=/">)(.*?)$' \
#     | sort | uniq > test5.txt 

# cat test.txt \
#     | grep -oP '(?<=<a class="jobTitle-link" href="/job/)(.*?)(?=<\/a>)' \
#     | grep -oP '(?<=/">)(.*?)$' > test6.txt 

#> Script en limpio

# Prepare the file 

rm -f -- '/mnt/c/Users/ali99/Downloads/Telegram Desktop/vacantes (2).txt'
rm -f vacantes.txt
fecha=$(date +'%d/%m/%Y @ %H:%M')
fecha2=$(date +'%d/%m @ %H:%M')
echo "EMPLEOS DISPONIBLES AL: $fecha" > vacantes.txt

# Functions prepared for scrapping

get_data_1 () {
    curl -s $1 \
    | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' \
    | awk '{ printf "%s ", $0 } END { printf "\n" }' \
    | grep -oP '(?<=vacancy"> )(.*?)(?=<\/h4>)' >> vacantes.txt
}

get_data_2 () {
    curl -s $1 \
    | grep -oP '(?<=<h3><a class="job-link" href="/caw/es/job/)(.*?)(?=<\/a>)' \
    | grep -oP '(?<=>).*' | sort | uniq >> vacantes.txt
}

get_data_3 () {
    for page in {1..5}; do
        url="${1}${page}"
        curl -s "$url" | grep -oP '(?<=<a href="/careers/opportunities/)(.*?)(?=<\/a>)' \
        | grep -oP '(?<=/">)(.*?)$' \
        | sort | uniq >> vacantes.txt 
    done 
}

get_data_4 () {
    curl -s $1 \
    | grep -oP '(?<=<a class="jobTitle-link" href="/job/)(.*?)(?=<\/a>)' \
    | grep -oP '(?<=/">)(.*?)$' >> vacantes.txt 
}

# Making the scrapping consider the inputs

while IFS='; ' read -r website curl_command; do
    case $website in
    *"chinalco"*)
        echo $website
        echo -e "\n---Chinalco---" >> vacantes.txt
        get_data_1 $website 
        ;;
    *"antapaccay"*)
        echo $website
        echo -e "\n---Antapaccay---" >> vacantes.txt
        get_data_1 $website 
        ;;
    *"mmg"*)
        echo $website
        echo -e "\n---Las Bambas---" >> vacantes.txt
        get_data_2 $website 
        ;;
    *"crugroup"*)
        echo $website
        echo -e "\n---CRU Group---" >> vacantes.txt
        get_data_3 $website 
        ;;
    *"bhp"*)
        echo $website
        echo -e "\n---BHP Chile---" >> vacantes.txt
        get_data_4 $website 
        ;;
    *)
        echo $website
        echo "arriba los compas!!"
        ;;
    esac
done < /mnt/c/Users/ali99/Documents/UnderDevelopment/JS/websites.txt

# Datos para envio a Telegram
caption="""Empleos para hoy -- $fecha2"""
token="6222012920:AAG6075letS8iTzfLVAX8p9pkdIEg6FZAmQ"
# token=`printenv API_KEY_AMVARGASBOT`
chat_id="-1001957546724"
# Envio Telegram
curl -F document=@"./vacantes.txt" "https://api.telegram.org/bot${token}/sendDocument?chat_id=${chat_id}&caption=${caption}"