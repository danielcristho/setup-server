#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "================================================================";
echo "author: @danielcristho                                          ";
echo " 1. Update machine                                              ";
echo " 2. Install Nginx                                               ";
echo " 3. Install Apache2                                             ";
echo " 4. Install MySQL-Server                                        ";
echo " 5. Install PHP8.0                                              ";
echo " 6. Install DNS-Server                                          ";
echo " 0. Exit                                                        ";
echo "================================================================";

read -p " Enter Your Choice Number [0 - 6] : " choice;
echo "";
case $choice in

1)  read -p "You will update this machine? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt update
    sudo apt-get install net-tools -y
    echo "Update success"
    fi
    ;;

2)  read -p "You want install Nginx? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install nginx -y
    echo "Nginx is ready to use"
    fi
    ;; 

3)  read -p "You want install Apache? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install apache2 -y
    echo "Apache is ready to use"
    fi
    ;; 

4)  read -p "You want install MySQL? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install mysql-server -y
    echo "MySQL is ready to use"
    fi
    ;;

5)  read -p "You want install PHP? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update
    echo "Add PHP Repository"
    sudo apt-get install php8.0-common php8.0-cli php8.0-mbstring php8.0-xml php8.0-curl php8.0-mysql php8.0-fpm -y
    echo "PHP is ready to use"
    fi
    ;;

6)  read -p "You want install bind9? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install bind9 -y
    fi
    ;;

0) exit
    ;;
*)    echo "sorry, menu is not found"
esac
echo -n "Back again? [y/n]: ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo "Your input is not correct";
echo -n "back again? [y/n]: ";
read again;
done
done