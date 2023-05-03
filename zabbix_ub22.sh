#!/bin/bash

read -e -p "Введите IP или домен Zabbix: " ZABBIX
read -e -p "Введите имя этого узла в Zabbix: " SERVERNAME
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest%2Bubuntu22.04_all.deb
dpkg -i zabbix-release_latest+ubuntu22.04_all.deb
apt update
apt install zabbix-agent2
systemctl enable zabbix-agent2 --now
sed -i "s/Server=127.0.0.1/Server=$ZABBIX/g" /etc/zabbix/zabbix_agent2.conf
sed -i "s/ServerActive=127.0.0.1/ServerActive=$ZABBIX/g" /etc/zabbix/zabbix_agent2.conf
sed -i "s/# Timeout=3/Timeout=30/g" /etc/zabbix/zabbix_agent2.conf
sed -i "s/Hostname=Zabbix server/Hostname=$SERVERNAME/g" /etc/zabbix/zabbix_agent2.conf
systemctl restart zabbix-agent2.service
rm zabbix*deb
