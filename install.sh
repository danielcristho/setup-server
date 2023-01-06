#!/usr/bin/env bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo " 1.  Update machine                                              ";
echo " 2.  Upgrade machine                                             ";
echo " 3.  Install Nginx                                               ";
echo " 4.  Install Apache2                                             ";
echo " 5.  Install MariaDB                                             ";
echo " 6.  Install PgSQL-Server                                        ";
echo " 7.  Install PHP8.0                                              ";
echo " 8.  Install PHP8.1                                              ";
echo " 9.  Install Yarn                                                ";
echo " 10. Install Node js using NVM                                   ";
echo " 11. Install PM2                                                 ";
echo " 12. Set fireawall permisision                                   ";
echo " 13. Setup Apache2 (edit index.html)                             ";
echo " 14. Restart machine                                             ";
echo " 0.  Exit                                                        ";
echo "=================================================================";

read -p " Enter Your Choice [0 - 14] : " choice;
echo "";
case $choice in

1)  read -p "You will update this machine? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt update -y
    sudo apt-get install net-tools lynx zip unzip -y
    echo "Update success"
    fi
    ;;

2)  read -p "You will upgrade this machine? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt upgrade -y
    echo "Upgrade success"
    fi
    ;;

3)  read -p "You want install Nginx? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install nginx -y
    rm /etc/sites-enabled/default.conf
    wget -O /etc/nginx/sites-enabled/$host.conf https://raw.githubusercontent.com/danielcristho/setup-server/main/default.conf 
    echo "Nginx is ready to use"
    fi
    ;;

4)  read -p "You want install Apache? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install apache2 -y
    sudo apt-get install lynx -y
    echo "Apache is ready to use"
    fi
    ;; 

5)  read -p "You want install MariaDB? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install debconf-utils -y
    DB_PASSWORD=$(hostname | md5sum | awk '{print $1}')
    debconf-set-selections <<< "mariadb-server-10.6 mysql-server/root_password password $DB_PASSWORD"
    debconf-set-selections <<< "mariadb-server-10.2 mysql-server/root_password_again password $DB_PASSWORD"
    curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
    sudo bash mariadb_repo_setup --mariadb-server-version=10.6
    sudo apt-get update
    sudo apt-install mariadb-server mariadb-client -y
    echo "MariaDB is ready to use"
    fi
    ;;

6)  read -p "You want install PgSQL? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "Add Repository..." 
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install postgresql-14 -y
    echo "PgSQL is ready to use"
    fi
    ;;

7)  read -p "You want install PHP8.0? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update -y
    echo "Add PHP Repository"
    sudo apt-get install php8.0-common php8.0-cli php8.0-mbstring php8.0-xml php8.0-curl php8.0-mysql php8.0-fpm -y
    echo "PHP is ready to use"
    fi
    ;;

8)  read -p "You want install PHP8.1? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    echo "Add PHP Repository"
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update -y
    sudo apt-get install php8.1-common php8.1-cli php8.1-mbstring php8.1-xml php8.1-curl php8.1-mysql php8.1-fpm -y
    echo "PHP is ready to use"
    fi
    ;;

9)  read -p "You want install Yarn? y/n : " -n 1 -r
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

10) read -p "You want install Node? y/n : " -n 1 -r
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

11) read -p "You want install pm2? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    npm install -g pm2
    echo "pm2 is ready to use"
    fi
    ;;


12) read -p "You want set UFW permission? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    echo "y" | sudo ufw enable
    sudo ufw allow ssh
    sudo ufw allow 'Nginx HTTP'
    sudo ufw allow 443
    sudo ufw allow 80
    sudo ufw allow 22
    fi
    ;;

13) read -p "You want set up Apache2? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo systemctl status apache2 | grep Active
    echo "Edit index.html"
    cd /var/www/html/
    sudo chown -R www-data:www-data .
    sudo echo '<h1>Welcome to Server 1</h1>' > index.html
    sudo service apache2 restart
    fi
    ;;

14) read -p "You want restart this machine? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo reboot
    fi
    ;;    

0)  exit
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