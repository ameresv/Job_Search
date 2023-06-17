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

path="/mnt/c/Users/ali99/Documents/JS/"
rm -f -- "/mnt/c/Users/ali99/Downloads/Telegram Desktop/vacantes (2).txt"
rm -f -- "${path}vacantes.txt"
fecha=$(date +'%d/%m/%Y @ %H:%M')
fecha2=$(date +'%d/%m @ %H:%M')

echo "Request @ $fecha" > "${path}request.txt"
echo "EMPLEOS DISPONIBLES AL: $fecha" > "${path}vacantes.txt"

key="QPMGL8ZP1SHHEM900DRNVPIAF3M9XJX7GHO6UU5HAWZFFNLD26985GKDRT2F2NQ6AEEC6T2WMJG1XMJC"

# Functions prepared for scrapping

get_data_1 () {
    curl -s $1 \
    | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' \
    | awk '{ printf "%s ", $0 } END { printf "\n" }' \
    | grep -oP '(?<=vacancy"> )(.*?)(?=<\/h4>)' \
    | sort | uniq >> "${path}vacantes.txt"
}

get_data_2 () {
    curl -s $1 \
    | grep -oP '(?<=<h3><a class="job-link" href="/caw/es/job/)(.*?)(?=<\/a>)' \
    | grep -oP '(?<=>).*' | sort | uniq >> "${path}vacantes.txt"
}

get_data_3 () {
    for page in {1..5}; do
        url="${1}${page}"
        curl -s "$url" | grep -oP '(?<=<a href="/careers/opportunities/)(.*?)(?=<\/a>)' \
        | grep -oP '(?<=/">)(.*?)$' \
        | sort | uniq >> "${path}vacantes.txt" 
    done 
}

get_data_4 () {
    curl -s $1 \
    | grep -oP '(?<=<a class="jobTitle-link" href="/job/)(.*?)(?=<\/a>)' \
    | grep -oP '(?<=/">)(.*?)$' | sort | uniq >> "${path}vacantes.txt" 
}

get_data_5 () {
    curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=$1" \
    | grep -oP '(?<=<h2 class="sc-vBKru gONUaj">)(.*?)(?=<\/h2>)' \
    | sort | uniq >> "${path}vacantes.txt" 
}

get_data_6 () {
    curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=$1" \
    | grep -oP '(?<=<h4 class="color-company color-company-on-white">)(.*?)(?=<\/h4>)' >> "${path}vacantes.txt"
}

# Making the scrapping consider the inputs

while IFS='; ' read -r website curl_command; do
    case $website in
    *"chinalco"*)
        echo $website
        echo -e "\n---Chinalco---" >> "${path}vacantes.txt"
        get_data_1 $website 
        ;;
    *"panama"*)
        echo $website
        echo -e "\n---Cobre Panama---" >> "${path}vacantes.txt"
        get_data_1 $website 
        ;;
    *"antapaccay"*)
        echo $website
        echo -e "\n---Antapaccay---" >> "${path}vacantes.txt"
        get_data_1 $website 
        ;;
    *"mmg"*)
        echo $website
        echo -e "\n---Las Bambas---" >> "${path}vacantes.txt"
        get_data_2 $website 
        ;;
    *"crugroup"*)
        echo $website
        echo -e "\n---CRU Group---" >> "${path}vacantes.txt"
        get_data_3 $website 
        ;;
    *"bhp"*)
        echo $website
        echo -e "\n---BHP Chile---" >> "${path}vacantes.txt"
        get_data_4 $website 
        ;;
    *"hudbay"*)
        echo $website
        echo -e "\n---Hudbay---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"minsur"*)
        echo $website
        echo -e "\n---Minsur---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"volcan"*)
        echo $website
        echo -e "\n---Volcan---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"catalina"*)
        echo $website
        echo -e "\n---Catalina Huanca---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"ferreyros"*)
        echo $website
        echo -e "\n---Ferreyros---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"anglo-american"*)
        echo $website
        echo -e "\n---Anglo American---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"sociedad-minera-cerro-verde"*)
        echo $website
        echo -e "\n---Cerro Verde---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"minera-boroo-misquichilca"*)
        echo $website
        echo -e "\n---Boroo---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"shougang-hierro-peru"*)
        echo $website
        echo -e "\n---Shougang---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"consorcio-minero-horizonte"*)
        echo $website
        echo -e "\n---CMH---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"minera-aurifera-retamas"*)
        echo $website
        echo -e "\n---Marsa---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"stracon"*)
        echo $website
        echo -e "\n---Stracon---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"cementos-pacasmayo"*)
        echo $website
        echo -e "\n---Pacasmayo---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"epiroc-peru"*)
        echo $website
        echo -e "\n---Epiroc---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"compania-minera-antamina"*)
        echo $website
        echo -e "\n---Antamina Bumeran---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"alpayana"*)
        echo $website
        echo -e "\n---Alpayana---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"nexa-resources"*)
        echo $website
        echo -e "\n---Nexa---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"martin"*)
        echo $website
        echo -e "\n---San Martin---" >> "${path}vacantes.txt"
        get_data_5 $website 
        ;;
    *"antamina"*)
        echo $website
        echo -e "\n---Antamina---" >> "${path}vacantes.txt"
        get_data_6 $website 
        ;;
    *)
        echo $website
        echo "arriba los compas!!"
        ;;
    esac
done < "${path}websites.txt"

# Datos para envio a Telegram
caption="""Empleos para hoy -- $fecha2"""
token="6222012920:AAG6075letS8iTzfLVAX8p9pkdIEg6FZAmQ"
# token=`printenv API_KEY_AMVARGASBOT`
chat_id="-1001957546724"
# Envio Telegram
curl -F document=@"${path}vacantes.txt" "https://api.telegram.org/bot${token}/sendDocument?chat_id=${chat_id}&caption=${caption}"