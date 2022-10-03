#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "================================================================";
echo " 1. Update machine ";
echo " 2. Install Nginx ";
echo " 3. Install MySQL-Server ";
echo " 4. Install PHP8.0";
echo " 0. Exit";
echo "================================================================";
read -p " Masukan Nomor Pilihan Anda [0 - 4] : " choice;
echo "";
case $choice in
1)  read -p "Anda akan mengupdate machine ini? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt update
    echo "Update berhasil"
    fi
    ;;

2)  read -p "Apakah Anda akan menginstall Nginx? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install nginx -y
    echo "Nginx berhasil terinstall"
    fi
    ;; 

3)  read -p "Apakah Anda akan menginstall MySQL? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install mysql-server -y
    echo "MySQL berhasil terinstall"
    fi
    ;;

4)  read -p "Apakah Anda akan menginstall PHP? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update
    echo "Add PHP Repository"
    sudo apt install php8.0-common php8.0-cli php8.0-mbstring php8.0-xml php8.0-curl php8.0-mysql php8.0-fpm -y
    echo "PHP berhasil terinstall"
    fi
    ;;
0) exit
    ;;
*)    echo "Maaf, menu tidak ada"
esac
echo -n "Kembali ke menu? [y/n]: ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo "Masukkan yang anda pilih tidak ada di menu";
echo -n "Kembali ke menu? [y/n]: ";
read again;
done
done