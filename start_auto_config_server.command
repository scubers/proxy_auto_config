#!/bin/bash


home_path=$(pwd|sed "s/\/Desktop.*//g")

echo $home_path

yml_path="$home_path/Library/Application Support/Lantern/settings.yaml"

my_ip=$(ifconfig|grep "inet .*broadcast"|sed "s/ netmask.*$//g"|sed "s/.* //g")

sed -i ".bak" "s/.*addr:.*$/addr: ${my_ip}:50015/g" "$yml_path"
if [ $? == 0 ];then
    rm "$yml_path.bak"
else
    mv "$yml_path.bak" "$yml_path" 
fi

echo "自动代理地址为: http://$my_ip:5656"
echo "手动代理地址为: http://$my_ip:50015"


$(dirname $0)/server.js



# echo $(cat "$yml_path")