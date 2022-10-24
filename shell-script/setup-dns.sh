#!/bin/bash

#CONSTANT
SERVER_ADDR="192.168.1.10"
DOMAIN_NAME="mydomain.com"
FORWARD_FILE="forward"
REVERSE_FILE="reverse"
RESOLV_ADDR="1.168.192"


again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo "author: @danielcristho                                           ";
echo " 1. Update machine                                               ";
echo " 2. Upgrade machine                                              ";
echo " 3. Install Bind9                                                ";
echo " 4. Create new zone (forward zone&reverse zone)                  ";
echo " 5. Configure forward zone                                       ";
echo " 6. Configure reverse zone                                       ";
echo " 7. Configure resolv.conf                                        ";
echo " 8. Remove bind9                                                 ";
echo " 0. Exit                                                         ";
echo "=================================================================";

read -p " Enter Your Choice [0 - 8] : " choice;
echo "";
case $choice in

1)  read -p "You will update and install many dependencies? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt update -y
    sudo apt-get install net-tools -y
    sudo apt-get install lynx dnsutils -y
    echo "Update success"
    fi
    ;;

2)  read -p "You will upgrade this machine? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt upgrade -y
    echo "Upgrade success"
    fi
    ;;

3)  read -p "You want install bind9? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get install bind9 -y
    echo "Bind9 is ready to use"
    fi
    ;;

4)  if [ -z "$(ls -A /etc/bind/named.conf)" ]; then
    echo "Bind9 is not installed before, Please install it!"
    else
    echo "Created forward zone and reverse zone"
    # sudo su
    sudo cat >> /etc/bind/named.conf <<- EOF

zone "${DOMAIN_NAME}" {
        type master;
        file "/etc/bind/${FORWARD_FILE}";
};

zone "${RESOLV_ADDR}.in-addr.arpa" {
        type master;
        file "/etc/bind/${REVERSE_FILE}";
};
EOF

    cat /etc/bind/named.conf
    echo "Create new forward and reverse file"
    cd /etc/bind
    sudo cp db.local ${FORWARD_FILE}
    sudo cp db.127 ${REVERSE_FILE}
    echo "Done..."
    fi
    ;;

5)  if [ -z "$(ls -A /etc/bind/${FORWARD_FILE})" ]; then
    echo "File not found!!"
    else
    cd /etc/bind
    echo "Replace all localhost string with domain name..."
    sudo sed -i "s/localhost/${DOMAIN_NAME}/gI" ${FORWARD_FILE}
    echo "Replace 127.0.0.1 with server address..."
    sudo sed -i "s/127.0.0.1/${SERVER_ADDR}/gI" ${FORWARD_FILE}
    echo "Adding new record..."
    sudo cat >> /etc/bind/${FORWARD_FILE} <<- EOF
www     IN      A       $SERVER_ADDR

ftp     IN      A       $SERVER_ADDR

mail    IN      A       $SERVER_ADDR
EOF
    cat /etc/bind/${FORWARD_FILE}
    echo "Done..."
    fi
    ;;

6)  if [ -z "$(ls -A /etc/bind/${REVERSE_FILE})" ]; then
    echo "File not found!!"
    else
    cd /etc/bind
    echo "Replace all localhost string with domain name..."
    sudo sed -i "s/localhost/${DOMAIN_NAME}/gI" ${FORWARD_FILE}
    echo "Replace 127.0.0.1 with server address..."
    echo "Adding new record..."
    sudo cat >> /etc/bind/${REVERSE_FILE} <<- EOF
@        IN        NS         $DOMAIN_NAME.

10      IN       PTR         www.$DOMAIN_NAME.

10      IN       PTR         ftp.$DOMAIN_NAME.

10      IN       PTR         mail.$DOMAIN_NAME.

EOF
    cat /etc/bind/${REVERSE_FILE}
    sudo service bind9 restart
    echo "Configurations is succes..."
    fi
    ;;

7)  read -p "You want set up resolv.conf? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    echo "Edit resolv.conf"
    # sudo su
    echo "nameserver ${SERVER_ADDR}" >> /etc/resolv.conf
    echo "DONE..."
    echo "Try using nslookup..."
    fi
    ;;

8)  read -p "You want  to remove bind9 and all config files? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    sudo apt-get remove bind9 -y
    sudo apt-get remove --auto-remove bind9 -y
    echo "Bind9 is already remove"
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
