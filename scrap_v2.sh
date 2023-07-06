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

# path="/mnt/c/Users/ali99/Documents/UnderDevelopment/JS/"
# rm -f -- "/mnt/c/Users/ali99/Downloads/Telegram Desktop/vacantes (2).txt"
rm -f -- "tmp/vacantes.txt"
fecha=$(date +'%d/%m/%Y @ %H:%M')
fecha2=$(date -d "-5 hours" +'%d/%m @ %H:%M')

echo "Request @ $fecha" > "tmp/request.txt"
echo "EMPLEOS DISPONIBLES AL: $fecha" > "tmp/vacantes.txt"

key="D5NBVDLUWATIJR92ZJE3JCV3JNY1ZV3E4BBJNCCOMF2BZ695A2RFV7WM1PFT13IBKORQ86FRIYNPQAMY"

# Functions prepared for scrapping

get_data_1 () {
    curl -s $1 \
    | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' \
    | awk '{ printf "%s ", $0 } END { printf "\n" }' \
    | grep -oP '(?<=vacancy"> )(.*?)(?=<\/h4>)' \
    | sort | uniq >> "tmp/vacantes.txt"
}

get_data_2 () {
    curl -s $1 \
    | grep -oP '(?<=<h3><a class="job-link" href="/caw/es/job/)(.*?)(?=<\/a>)' \
    | grep -oP '(?<=>).*' | sort | uniq >> "tmp/vacantes.txt"
}

get_data_3 () {
    for page in {1..5}; do
        url="${1}${page}"
        curl -s "$url" | grep -oP '(?<=<a href="/careers/opportunities/)(.*?)(?=<\/a>)' \
        | grep -oP '(?<=/">)(.*?)$' \
        | sort | uniq >> "tmp/vacantes.txt" 
    done 
}

get_data_4 () {
    curl -s $1 \
    | grep -oP '(?<=<a class="jobTitle-link" href="/job/)(.*?)(?=<\/a>)' \
    | grep -oP '(?<=/">)(.*?)$' | sort | uniq >> "tmp/vacantes.txt" 
}

get_data_5 () {
    curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=$1" \
    | grep -oP '(?<=<h2 class="sc-jiTwWT bufYMl">)(.*?)(?=<\/h2>)' \
    | sort | uniq >> "tmp/vacantes.txt" 
}

get_data_6 () {
    curl -s "https://app.scrapingbee.com/api/v1/?api_key=${key}&url=$1" \
    | grep -oP '(?<=<h4 class="color-company color-company-on-white">)(.*?)(?=<\/h4>)' >> "tmp/vacantes.txt"
}

# Making the scrapping consider the inputs

while IFS='; ' read -r website curl_command; do
    case $website in
    *"chinalco"*)
        echo $website
        echo "\n---Chinalco---" >> "tmp/vacantes.txt"
        get_data_1 $website 
        ;;
    *"panama"*)
        echo $website
        echo "\n---Cobre Panama---" >> "tmp/vacantes.txt"
        get_data_1 $website 
        ;;
    *"antapaccay"*)
        echo $website
        echo "\n---Antapaccay---" >> "tmp/vacantes.txt"
        get_data_1 $website 
        ;;
    *"mmg"*)
        echo $website
        echo "\n---Las Bambas---" >> "tmp/vacantes.txt"
        get_data_2 $website 
        ;;
    *"crugroup"*)
        echo $website
        echo "\n---CRU Group---" >> "tmp/vacantes.txt"
        get_data_3 $website 
        ;;
    *"bhp"*)
        echo $website
        echo "\n---BHP Chile---" >> "tmp/vacantes.txt"
        get_data_4 $website 
        ;;
    *"hudbay"*)
        echo $website
        echo "\n---Hudbay---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"minsur"*)
        echo $website
        echo "\n---Minsur---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"volcan"*)
        echo $website
        echo "\n---Volcan---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"catalina"*)
        echo $website
        echo "\n---Catalina Huanca---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"ferreyros"*)
        echo $website
        echo "\n---Ferreyros---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"anglo-american"*)
        echo $website
        echo "\n---Anglo American---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"sociedad-minera-cerro-verde"*)
        echo $website
        echo "\n---Cerro Verde---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"minera-boroo-misquichilca"*)
        echo $website
        echo "\n---Boroo---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"shougang-hierro-peru"*)
        echo $website
        echo "\n---Shougang---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"consorcio-minero-horizonte"*)
        echo $website
        echo "\n---CMH---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"minera-aurifera-retamas"*)
        echo $website
        echo "\n---Marsa---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"stracon"*)
        echo $website
        echo "\n---Stracon---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"cementos-pacasmayo"*)
        echo $website
        echo "\n---Pacasmayo---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"epiroc-peru"*)
        echo $website
        echo "\n---Epiroc---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"compania-minera-antamina"*)
        echo $website
        echo "\n---Antamina Bumeran---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"alpayana"*)
        echo $website
        echo "\n---Alpayana---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"nexa-resources"*)
        echo $website
        echo "\n---Nexa---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"martin"*)
        echo $website
        echo "\n---San Martin---" >> "tmp/vacantes.txt"
        get_data_5 $website 
        ;;
    *"antamina"*)
        echo $website
        echo "\n---Antamina---" >> "tmp/vacantes.txt"
        get_data_6 $website 
        ;;
    *)
        echo $website
        echo "arriba los compas!!"
        ;;
    esac
done < "./websites.txt"

# Datos para envio a Telegram
caption="Empleos para hoy -- ${fecha2}"
token="6222012920:AAG6075letS8iTzfLVAX8p9pkdIEg6FZAmQ"
# token=`printenv API_KEY_AMVARGASBOT`
chat_id="-1001957546724"
# Envio Telegram
curl -s -F chat_id=$chat_id \
    -F document=@"tmp/vacantes.txt" \
    -F caption="Empleos para hoy -- ${fecha2}"\
    https://api.telegram.org/bot${token}/sendDocument
