#!/usr/bin/env bash

# ENVIRONMENT #
export PROJECT_DIR=example-project
export DOMAIN_NAME=example.com

# Login as sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

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
echo "*                     |_|                by: @danielcristho   *"
echo "***************************************************************"
echo "1.  Update machine                                            "
echo "2.  Upgrade machine                                           "
echo "3.  Install Nginx                                             "
echo "4.  Install MariaDB                                           "
echo "5.  Install PHP                                               "
echo "6.  Install Yarn                                              "
echo "7.  Install Node js using NVM                                 "
echo "8.  Install PM2                                               "
echo "9.  Install Monitoring tool(Netdata)                          "
echo "10. Set UFW Permission		                                "
echo "11. Backup LEMP(Current Configuration)                        "
echo "12. Restart machine                                           "
echo "0.  Exit                                                      "

read -p "Enter Your Choice [0 - 12] : " choice;
echo "";
case $choice in

1)  read -p "Do you want to update this machine? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    sudo apt update -y
    sudo apt-get install lynx zip unzip net-tools -y
    echo "Update success"
    fi
    ;;

2)  read -p "Do you want to upgrade this machine? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    sudo apt upgrade -y
    echo "Upgrade success"
    fi
    ;;

3)  read -p "Do you want to install Nginx? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    sudo apt-get install nginx -y
    echo "Create default file for Nginx"
    wget -O /etc/nginx/sites-enabled/default https://raw.githubusercontent.com/danielcristho/setup-server/main/defaut.conf
    sudo mkdir /var/www/$PROJECT_DIR
    echo -e "<html>\n<body>\n<h1>Hello World!<h1>\n</body>\n</html>" > /var/www/$PROJECT_DIR/index.html
    sudo chown -R www-data:www-data /var/www/$PROJECT_DIR
    sudo systemctl restart nginx
    echo "Nginx is ready to use"
    fi
    ;;

4)  read -p "Do you want to install MariaDB? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    sudo apt-get install debconf-utils -y
    ROOT_PASSWORD=$(hostname | md5sum | awk '{print $1}')
    debconf-set-selections <<< "mariadb-server-10.6 mysql-server/root_password password $ROOT_PASSWORD"
    debconf-set-selections <<< "mariadb-server-10.6 mysql-server/root_password_again password $ROOT_PASSWORD"
    curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
    sudo bash mariadb_repo_setup --mariadb-server-version=10.6
    sudo apt-get update
    sudo apt-get install mariadb-server mariadb-client -y
    #save root credential into /etc/mysql/mycnf
    echo -e "\n[client]\nuser = root\npassword = $ROOT_PASSWORD" >> /etc/mysql/my.cnf
    # Add custom configuration for your Mysql
    # All modified variables are available at https://mariadb.com/kb/en/library/server-system-variables/
    echo -e "\n[mysqld]\nmax_connections=24\nconnect_timeout=10\nwait_timeout=10\nthread_cache_size=24\nsort_buffer_size=1M\njoin_buffer_size=1M\ntmp_table_size=8M\nmax_heap_table_size=1M\nbinlog_cache_size=8M\nbinlog_stmt_cache_size=8M\nkey_buffer_size=1M\ntable_open_cache=64\nread_buffer_size=1M\nquery_cache_limit=1M\nquery_cache_size=8M\nquery_cache_type=1\ninnodb_buffer_pool_size=8M\ninnodb_open_files=1024\ninnodb_io_capacity=1024\ninnodb_buffer_pool_instances=1" >> /etc/mysql/my.cnf
    sudo systemctl restart mariadb.service
    echo "MariaDB is ready to use"
    fi
    ;;

5)  read -p "Do you want to install PHP? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
        echo "1. Install PHP8.0"
        echo "2. Install PHP8.1"
        echo "3. Install PHP8.2"
        read -p "Enter your choice [1-3]: " php_choice;
        echo "";
        case $php_choice in
            1)
                sudo add-apt-repository ppa:ondrej/php
                echo "Adding PHP repository..."
                sudo apt-get install php8.0-common php8.0-cli php8.0-mbstring php8.0-xml php8.0-curl php8.0-mysql php8.0-fpm -y
                #Create opcache file
                wget -O /var/www/$PROJECT_DIR/opcache.php https://github.com/rlerdorf/opcache-status/blob/master/opcache.php
                #Create php info file
                echo -e "<?php phpinfo();" > /var/www/$PROJECT_DIR/info.php
                echo "PHP is ready to use"
                ;;
            2)
                sudo add-apt-repository ppa:ondrej/php
                echo "Adding PHP repository..."
                sudo apt-get install php8.1-common php8.1-cli php8.1-mbstring php8.1-xml php8.1-curl php8.1-mysql php8.1-fpm -y
                #Create opcache file
                wget -O /var/www/$PROJECT_DIR/opcache.php https://github.com/rlerdorf/opcache-status/blob/master/opcache.php
                #Create php info file
                echo -e "<?php phpinfo();" > /var/www/$PROJECT_DIR/info.php
                echo "PHP is ready to use"
                ;;
            3)
                sudo add-apt-repository ppa:ondrej/php
                echo "Adding PHP repository..."
                sudo apt-get install php8.2-common php8.2-cli php8.2-mbstring php8.2-xml php8.2-curl php8.2-mysql php8.2-fpm -y
                #Create opcache file
                wget -O /var/www/$PROJECT_DIR/opcache.php https://github.com/rlerdorf/opcache-status/blob/master/opcache.php
                #Create php info file
                echo -e "<?php phpinfo();" > /var/www/$PROJECT_DIR/info.php
                echo "PHP is ready to use"
                ;;
            *)
                echo "Invalid choice. PHP installation aborted"
                ;;
        esac
    fi
    ;;

6)  read -p "Do you want to install Node? y/n : " -n 1 -r
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

7)  read -p "Do you want to install Yarn? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "Adding Yarn repository"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
    sudo apt-get install yarn -y
    echo "Yarn is ready to use"
    fi
    ;;

8)  read -p "Do you want to install PM2? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    npm install -g pm2
    echo "pm2 is ready to use"
    fi
    ;;

9)  read -p "Do you want to install Netdata monitoring? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "Install from kickstart.sh..."
    #sources: https://github.com/netdata/netdata/blob/master/packaging/installer/kickstart.sh
    bash <(curl -Ss https://my-netdata.io/kickstart.sh)
    ufw allow 19999/tcp
    echo "Netdata is ready to use"
    echo "Access from: http://host-ip:19999"
    fi
    ;;

10) read -p "Do you want set UFW permission? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "y" | sudo ufw enable
    sudo ufw allow ssh
    sudo ufw allow 'Nginx HTTP'
    sudo ufw allow 443
    sudo ufw allow 80
    sudo ufw allow 22
    sudo ufw reload
    fi
    ;;

11) read -p "Do you want create backup current configuration? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    date=$(date +"%Y-%m-%d_%H-%M-%S")
    mkdir -p backup/$date/nginx
    mkdir -p backup/$date/php
    mkdir -p backup/$date/mysql
    cp -r /etc/nginx/* backup/$date/nginx
    cp -r /etc/php/* backup/$date/php
    cp -r /etc/mysql/* backup/$date/mysql
    fi
    ;;

12) read -p "Do you want to restart this machine? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    sudo reboot
    fi
    ;;

0)  exit
    ;;
*)    echo "Sorry, menu is not found"
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
# Clear the color after that
STOP='\033[0m'
printf "${STOP}"
