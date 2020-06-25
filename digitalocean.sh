export TOKEN="censored"
MAAND=$( date +%B )

#active droplets
curl -s GET "https://api.digitalocean.com/v2/customers/my/balance" > temp.json\
	-H "Authorization: Bearer $TOKEN"

BALANS=$(jq -r '.month_to_date_balance' temp.json)
VERBRUIK=$(jq -r '.month_to_date_usage' temp.json)
printf "\nBeschikbaar balans: ${BALANS:1}\nVerbruik deze maand: $VERBRUIK\n" 
exit
