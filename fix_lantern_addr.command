#!/bin/bash


home_path=$(dirname $0|sed "s/\/Desktop.*//g")

yml_path="$home_path/Library/Application Support/Lantern/settings.yaml"

# addr: 127.0.0.1:50015

my_ip=$(ifconfig|grep "inet .*broadcast"|sed "s/ netmask.*$//g"|sed "s/.* //g")

echo "输入端口"
# ="192.168.1.103:50015"
# read current_port

sed -i ".bak" "s/.*addr:.*$/addr: ${my_ip}:50015/g" "$yml_path"
if [ $? == 0 ];then
    rm "$yml_path.bak"
else
    mv "$yml_path.bak" "$yml_path" 
fi

echo "自动代理地址为http://$my_ip:5656"
echo "手动代理地址为http://$my_ip:50015"

# echo $(cat "$yml_path")