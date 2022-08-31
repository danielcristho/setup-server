#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo " 1. Install Nginx "
echo " 2. Setup VirtualHost "
read -p " Masukan Nomor Pilihan Anda [1 - 2] : " choice;
echo "";
case $choice in
1)  read -p "Apakah Anda akan menginstall Nginx? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install nginx
    echo "Nginx berhasil terinstall"
    fi
    ;; 

2)  echo -n "Masukan nama domain atau subdomain anda : "
    read domain
    if [ -z "$(ls -A  )"]