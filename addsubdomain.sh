#!/bin/bash
read -r -p "Enter subdomain : " sub

domain=$(jq -r '.domain' config.json)
subdomain="$sub$domain"

certs_path=$(jq -r '.certs_path' config.json)


ZoneID=$(jq -r '.Zone_ID' config.json)
TK=$(jq -r '.API_TOKEN' config.json)
IP=$(jq -r '.IP' config.json)

eval export CF_Token="$TK"

export crate_dns=$(curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZoneID/dns_records" -H "Authorization: Bearer $TK" -H "Content-Type: application/json"  --data "{\"type\":\"A\",\"name\":\"$subdomain\",\"content\":\"$IP\",\"ttl\":3600,\"proxied\":false,\"comment\":\"Created by AC-AddSubDomain\"}")

sleep 3

mkdir /root/AC-AddSubDomain || echo ""
mkdir "$certs_path" || echo ""

cat > "/root/AC-AddSubDomain/${subdomain}.json" <<EOL
$crate_dns
EOL

SSL="~/.acme.sh/acme.sh --issue --dns dns_cf --standalone -d $subdomain --key-file $certs_path$sub-key.pem --fullchain-file $certs_path$sub-fullchain.pem"

eval "$SSL"
marzban_path=$(jq -r '.marzban_path' config.json)

cp "${marzban_path}xray_config.json" "${marzban_path}xray_config.json.bak"

TLS="{\"ocspStapling\":3600,\"certificateFile\":\"$certs_path$sub-fullchain.pem\",\"keyFile\":\"$certs_path$sub-key.pem\" }"
#TROJAN_FALLBACK_INBOUND
echo "$(jq ".inbounds[0].streamSettings.tlsSettings.certificates[.inbounds[0].streamSettings.tlsSettings.certificates| length] += $TLS"  "${marzban_path}xray_config.json")" > "${marzban_path}xray_config.json"
echo "$(jq ".inbounds[0].streamSettings.tlsSettings.serverName = \"$subdomain\""  "${marzban_path}xray_config.json")" > "${marzban_path}xray_config.json"
#TROJAN_GRPC
#echo "$(jq ".inbounds[6].streamSettings.tlsSettings.certificates[.inbounds[6].streamSettings.tlsSettings.certificates| length] += $TLS"  "${marzban_path}xray_config.json")" > "${marzban_path}xray_config.json"
#echo "$(jq ".inbounds[6].streamSettings.tlsSettings.serverName = \"$subdomain\""  "${marzban_path}xray_config.json")" > "${marzban_path}xray_config.json"
#VLESS_GRPC
#echo "$(jq ".inbounds[7].streamSettings.tlsSettings.certificates[.inbounds[7].streamSettings.tlsSettings.certificates| length] += $TLS"  "${marzban_path}xray_config.json")" > "${marzban_path}xray_config.json"
#echo "$(jq ".inbounds[7].streamSettings.tlsSettings.serverName = \"$subdomain\""  "${marzban_path}xray_config.json")" > "${marzban_path}xray_config.json"

cd "$marzban_path" || exit

docker compose down
sleep 3
docker compose up -d

read -n 1 -s -r -p "Press any key to continue ..."

exit 1