#!/bin/bash

sudo chmod 666 /var/run/docker.sock

sudo cp /tmp/docker-compose.yaml ~/docker-compose.yaml
sudo cp /tmp/Corefile ~/Corefile
sudo cp /tmp/init-server.sh ~/init-server.sh

sudo mkdir -p ~/.nginx/servers
sudo cp /tmp/nginx.conf ~/.nginx/servers

while true; do
  IP=$(nslookup ${VPN_SERVER_ENDPOINT} | grep 'Address: ' | grep -v '#' | awk '{ print $2 }')

  if [[ "$IP" == "${PUBLIC_IP}" ]]; then
    echo "IP address matches ${PUBLIC_IP}. Exiting..."
    break
  else
    echo "IP address of ${VPN_SERVER_ENDPOINT} is $IP, not ${PUBLIC_IP}. Retrying in 5 seconds..."
    sleep 5
  fi
done

docker-compose -f ~/docker-compose.yaml up -d


# docker exec -it nginx /bin/sh -c '
# cp /etc/nginx/servers/nginx.conf /etc/nginx/conf.d/
# certbot --nginx --non-interactive --agree-tos -m ${ADMIN_EMAIL} -d ${VPN_SERVER_ENDPOINT}
# nginx -s reload
# '
