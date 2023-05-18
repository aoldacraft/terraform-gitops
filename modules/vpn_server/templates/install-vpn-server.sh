#!/bin/bash
sudo usermod -aG docker $USER
newgrp docker

sudo mkdir -p ~/.nginx/servers
sudo cp /tmp/wg-easy.conf ~/.nginx/servers/

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

sleep 15
docker exec -it nginx /bin/sh -c '
cp /etc/nginx/servers/wg-easy.conf /etc/nginx/conf.d/
certbot --nginx --non-interactive --agree-tos -m ${ADMIN_EMAIL} -d ${VPN_SERVER_ENDPOINT}
nginx -s reload
'

cat <<EOF | sudo tee /etc/systemd/resolved.conf
[Resolve]
DNSStubListener=no
EOF
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

sudo reboot
