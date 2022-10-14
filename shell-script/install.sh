#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo "author: @danielcristho                                           ";
echo " 1.  Update machine                                              ";
echo " 2.  Install Nginx                                               ";
echo " 3.  Install Apache2                                             ";
echo " 4.  Install MySQL-Server                                        ";
echo " 5.  Install PHP8.0                                              ";
echo " 6.  Install PHP8.1                                              ";
echo " 7.  Install Yarn                                                ";
echo " 8.  Install Node js using NVM                                   ";
echo " 9.  Install PM2                                                 ";
echo " 10. Install DNS-Server                                          ";
echo " 11. Install DHCP-Server                                         ";
echo " 12. Restart Machine                                             ";
echo " 13. Set fireawall permisision                                   ";
echo " 14. Setup Apache2                                               ";
echo " 0.  Exit                                                        ";
echo "=================================================================";

read -p " Enter Your Choice Number [0 - 13] : " choice;
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
    sudo apt-get install debconf-utils -y
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
    echo "MySQL is ready to use"
    fi
    ;;

5)  read -p "You want install PHP8.0? y/n :" -n 1 -r
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

6)  read -p "You want install PHP8.1? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    echo "Add PHP Repository"
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update
    sudo apt-get install php8.1-common php8.1-cli php8.1-mbstring php8.1-xml php8.1-curl php8.1-mysql php8.1-fpm -y
    echo "PHP is ready to use"
    fi
    ;;

7)  read -p "You want install Yarn? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "Add Yarn Repository"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
    sudo apt-get install yarn -y
    echo "Yarn is ready to use"
    fi
    ;;

8)  read -p "You want install Node? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    source ~/.nvm/nvm.sh
    source ~/.bashrc
    nvm install 16.15.1
    nvm use 16.15.1
    nvm alias default 16.15.1
    node -v
    echo "Node is ready to use"
    fi
    ;;

9)  read -p "You want install pm2? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    npm install -g pm2
    echo "pm2 is ready to use"
    fi
    ;;

10)  read -p "You want install bind9? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install bind9 -y
    echo "Bind9 is ready to use"
    fi
    ;;

11)  read -p "You want install isc-dhcp-server? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install isc-dhcp-server -y
    sudo mv /etc/dhcp/dhcp.conf /tmp
    sudo cp support/dhcp.conf /etc/dhcp
    sudo nan /etc/dhcp/dhcpd.conf
    service isc-dhcp-server restart
    echo "DHCP-Ssrver is ready to use"
    fi
    ;;

12)  read -p "You want restart this machine? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo reboot
    fi
    ;;

13)  read -p "You want set UFW permission? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo ufw enable
    sudo ufw allow ssh
    sudo ufw allow 'Nginx HTTP'
    sudo ufw allow 443
    sudo ufw allow 80
    sudo ufw allow 22
    fi
    ;;

14) read -p "You want set up Apache2? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo systemctl status apache2 | grep Active
    echo " Edit file permission in /var/www"
    sudo chown -R www-data:www-data /var/www
    echo "Edit index.html "
    cd /var/www/html/
    echo '<h1>Welcome to Server 1</h1>' > index.html
    sudo service restart apache2
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