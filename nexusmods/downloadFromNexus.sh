#!/bin/bash
if [ -e .attrs.sh ]; then source .attrs.sh; fi

source $stdenv/setup

get_dl_url() {
url=$(curl -s  'https://www.nexusmods.com/Core/Libs/Common/Managers/Downloads?GenerateDownloadUrl' \
  -H "$cookie" \
  -H 'authority: www.nexusmods.com' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.7' \
  -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'origin: https://www.nexusmods.com' \
  -H "referer: https://www.nexusmods.com/${game_name}/mods/${mod_id}?tab=files&file_id=${file_id}" \
  -H 'sec-ch-ua: "Chromium";v="118", "Brave";v="118", "Not=A?Brand";v="99"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-gpc: 1' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest' \
  --data-raw "fid=${file_id}&game_id=${game_id}" \
  --compressed  | jq -r '.url'
    )

    if [ $? -eq 0 ]; then
        echo "${url}"
    else
        echo "Bad response: ${url}"
        exit 1
    fi
}

# Example usage:
cookie=''
mod_id="104737"
file_id="442608"
game_name="skyrimspecialedition"
game_id="1704" #skyrim

download_url=$(get_dl_url)
cleaned_filename=$(sed "s/\?.*//g" <<< "$download_url")
filename=$(basename "$cleaned_filename") 
mkdir -p $out
curl -o "$out/$filename" "$(sed "s/ /%20/g" <<< "$download_url")"