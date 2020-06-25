export TOKEN=58d7f89441991f8e16af2419717a9a0d33584b232bfc5be6bb1f623150cf9573
MAAND=$( date +%B )

#active droplets
curl -s GET "https://api.digitalocean.com/v2/customers/my/balance" > temp.json\
	-H "Authorization: Bearer $TOKEN"

BALANS=$(jq -r '.month_to_date_balance' temp.json)
VERBRUIK=$(jq -r '.month_to_date_usage' temp.json)
printf "\nBeschikbaar balans: ${BALANS:1}\nVerbruik deze maand: $VERBRUIK\n" 
exit