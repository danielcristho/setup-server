# Setup Server

BASH Script for LEMP installation and configure on your Ubuntu, including Node, Yarn and etc.

```bash
echo "***************************************************************"
echo "*  ___       _                 ____                           *"
echo "*/ ___|  ___| |_ _   _ _ __   / ___|  ___ _ ____   _____ _ __ *"
echo "*\___ \ / _ \ __| | | | '_ \  \___ \ / _ \ '__\ \ / / _ \ '__|*"
echo "* ___) |  __/ |_| |_| | |_) |  ___) |  __/ |   \ V /  __/ |   *"
echo "*|____/ \___|\__|\__,_| .__/  |____/ \___|_|    \_/ \___|_|   *"
echo "*                     |_|                   by: @danielcristho*"
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
echo "10. Set UFW Rules                                             "
echo "11. Backup LEMP(Current Configuration)                        "
echo "12. Restart machine                                           "
echo "0.  Exit                                                      "
```

## Requirements

- Ubuntu 18.04 or latest version
- This script utilises root user privileges. If you run it from another user you need to add this user to sudoers group and prepend sudo to all commands in the script if needed.

## Usage

To download and run this script use the single line below:

```bash
wget https://raw.githubusercontent.com/danielcristho/setup-server/main/install.sh && sudo bash install.sh
```

Or make the script executable

```bash
wget https://raw.githubusercontent.com/danielcristho/setup-server/main/install.sh
sudo chmod +x install.sh
sudo ./install.sh
```

## Features

- **Nginx**
- **PHP**
- **MariaDB**
- **Node.js**
- **PM2**
- **NetData**


NB: MariaDB credential(username&password) are generated using md5 hash of your server hostname and will be put into /etc/mysql/my.cnf after [client] directive.
