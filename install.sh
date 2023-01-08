#!/usr/bin/env bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
COLOR=$'\e[1;91m'

echo "$COLOR"
echo "***************************************************************"
echo "*  ___       _                 ____                           *"
echo "*/ ___|  ___| |_ _   _ _ __   / ___|  ___ _ ____   _____ _ __ *"
echo "*\___ \ / _ \ __| | | | '_ \  \___ \ / _ \ '__\ \ / / _ \ '__|*"
echo "* ___) |  __/ |_| |_| | |_) |  ___) |  __/ |   \ V /  __/ |   *"
echo "*|____/ \___|\__|\__,_| .__/  |____/ \___|_|    \_/ \___|_|   *"
echo "*                     |_|                                     *"
echo "***************************************************************"
echo "1.  Update machine                                            "
echo "2.  Upgrade machine                                           "
echo "3.  Install Nginx                                             "
echo "4.  Install Apache2                                           "
echo "5.  Install MariaDB                                           "
echo "6.  Install Postgres                                          "
echo "7.  Install PHP8.0                                            "
echo "8.  Install PHP8.1                                            "
echo "9.  Install Yarn                                              "
echo "10. Install Node js using NVM                                 "
echo "11. Install PM2                                               "
echo "12. Set fireawall permisision                                 "
echo "13. Backup LAMP/LEMP(Current Configuration)                   "
echo "14. Restart machine                                           "
echo "0.  Exit                                                      "

read -p "Enter Your Choice [0 - 14] : " choice;
echo "";
case $choice in

1)  read -p "You will update this machine? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt update -y
    sudo apt-get install lynx zip unzip figlet -y
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
    echo "Create default file for Nginx"
    wget -O /etc/nginx/sites-enabled/default https://raw.githubusercontent.com/danielcristho/setup-server/main/defaut.conf
    echo "Nginx is ready to use"
    fi
    ;;

4)  read -p "You want install Apache? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    apt-get install apache2 -y
    echo "Apache is ready to use"
    fi
    ;; 

5)  read -p "You want install MariaDB? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    apt-get install debconf-utils -y
    ROOT_PASSWORD=$(hostname | md5sum | awk '{print $1}')
    debconf-set-selections <<< "mariadb-server-10.6 mysql-server/root_password password $ROOT_PASSWORD"
    debconf-set-selections <<< "mariadb-server-10.2 mysql-server/root_password_again password $ROOT_PASSWORD"
    curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
    sudo bash mariadb_repo_setup --mariadb-server-version=10.6
    apt-get update
    apt-get install mariadb-server mariadb-client -y
    #save root credential into /etc/mysql/mycnf
    echo -e "\n[client]\nuser = root\npassword = $ROOT_PASSWORD" >> /etc/mysql/my.cnf
    # Add custom configuration for your Mysql
    # All modified variables are available at https://mariadb.com/kb/en/library/server-system-variables/
    echo -e "\n[mysqld]\nmax_connections=24\nconnect_timeout=10\nwait_timeout=10\nthread_cache_size=24\nsort_buffer_size=1M\njoin_buffer_size=1M\ntmp_table_size=8M\nmax_heap_table_size=1M\nbinlog_cache_size=8M\nbinlog_stmt_cache_size=8M\nkey_buffer_size=1M\ntable_open_cache=64\nread_buffer_size=1M\nquery_cache_limit=1M\nquery_cache_size=8M\nquery_cache_type=1\ninnodb_buffer_pool_size=8M\ninnodb_open_files=1024\ninnodb_io_capacity=1024\ninnodb_buffer_pool_instances=1" >> /etc/mysql/my.cnf
    echo "MariaDB is ready to use"
    fi
    ;;

6)  read -p "You want install Postgres? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "Add Repository..." 
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    apt-get update
    apt-get install postgresql-14 -y
    echo "PgSQL is ready to use"
    fi
    ;;

7)  read -p "You want install PHP8.0? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    add-apt-repository ppa:ondrej/php
    echo "Add PHP Repository..."
    apt-get install php8.0-common php8.0-cli php8.0-mbstring php8.0-xml php8.0-curl php8.0-mysql php8.0-fpm libapache2-mod-php8.0 -y
    echo "PHP is ready to use"
    fi
    ;;

8)  read -p "You want install PHP8.1? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    add-apt-repository ppa:ondrej/php
    echo "Add PHP Repository..."
    apt-get install php8.1-common php8.1-cli php8.1-mbstring php8.1-xml php8.1-curl php8.1-mysql php8.1-fpm libapache2-mod-php8.1 -y
    echo "PHP is ready to use"
    fi
    ;;

9) read -p "You want install Node? y/n : " -n 1 -r
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

10)  read -p "You want install Yarn? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "Add Yarn Repository"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    apt-get update
    apt-get install yarn -y
    echo "Yarn is ready to use"
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
    ufw allow ssh
    ufw allow 'Nginx HTTP'
    ufw allow 443
    ufw allow 80
    ufw allow 22
    fi
    ;;

13) read -p "You want backup current configuration? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    date=$(date +"%Y-%m-%d_%H-%M-%S")
    mkdir -p backup/$date/nginx
    mkdir -p backup/$date/php
    mkdir -p backup/$date/php
    mkdir -p backup/$date/mysql
    cp -r /etc/nginx/ backup/$date/nginx
    cp -r /etc/php/ backup/$date/php
    cp -r /etc/mysql/ backup/$date/mysql
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
#close font color session
STOP="\e[0m" 
printf "${STOP}"