#!/bin/bash

export TOKEN=""

post_proxy() {
    local domain="$1"
    local forward_host="$2"
    local forward_port="$3"

    curl -XPOST -H "Authorization: Bearer $TOKEN" \
        "http://localhost:81/api/nginx/proxy-hosts" \
        -H 'Content-Type: application/json' \
        -d "{\"domain_names\":[\"$domain\"],\"forward_scheme\":\"http\",\"forward_host\":\"$forward_host\",\"forward_port\":$forward_port,\"caching_enabled\":true,\"allow_websocket_upgrade\":true,\"access_list_id\":\"0\",\"certificate_id\":1,\"ssl_forced\":true,\"meta\":{\"letsencrypt_agree\":false,\"dns_challenge\":false},\"advanced_config\":\"\",\"locations\":[],\"block_exploits\":false,\"http2_support\":false,\"hsts_enabled\":false,\"hsts_subdomains\":false}"
}

while [ -z "$TOKEN" ]
do
    TOKEN=$(curl -XPOST http://localhost:81/api/tokens \
        -H 'Content-Type: application/json' \
        -d '{"identity":"admin@example.com", "secret":"changeme"}' | \
          python3 -m json.tool | \
          grep '"token":' | \
          sed 's/^.*"token": "\(.*\)".*$/\1/')
    sleep 5 # Optional, but recommended to avoid overwhelming the server.
done
sleep 5

curl -XPOST "http://localhost:81/api/nginx/certificates" \
    -H "Authorization: Bearer $TOKEN" \
    -H 'Content-Type: application/json' \
    -d '{"domain_names":["*.${DEV_ENDPOINT}"],"meta":{"letsencrypt_email":"${ROOT_EMAIL}","dns_challenge":true,"dns_provider":"cloudflare","dns_provider_credentials":"# Cloudflare API token\r\ndns_cloudflare_api_token = ${CLOUDFLARE_TOKEN}","letsencrypt_agree":true},"provider":"letsencrypt"}'

sleep 10

post_proxy "${VPN_ENDPOINT}" "wg-easy" 51821
post_proxy "${LDAP_ENDPOINT}" "phpldapadmin" 80
post_proxy "${JENKINS_ENDPOINT}" "jenkins" 8080
post_proxy "${GATEWAY_ENDPOINT}" "localhost" 81
post_proxy "${ARGOCD_ENDPOINT}" "localhost" 30750
post_proxy "${HARBOR_ENDPOINT}" "localhost" 30751

curl -XPOST "http://localhost:81/api/settings/default-site" \
    -H "Authorization: Bearer $TOKEN" \
    -H 'Content-Type: application/json' \
    -d '{"value":"404","meta":{"redirect":"","html":""}}'
