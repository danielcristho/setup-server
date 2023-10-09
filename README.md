# Setup Server

BASH Script for LEMP installation and configure on your Ubuntu, including Node, Yarn and etc.

## Requirements

- Ubuntu 18.04 or latest version
- This script utilises root user privileges. If you run it from another user you need to add this user to sudoers group and prepend sudo to all commands in the script if needed.

## Usage

To download and run this script use the single line below:

```bash
wget https://raw.githubusercontent.com/danielcristho/setup-server/main/install.sh && bash install.sh
```

Or make the script executable

```bash
wget https://raw.githubusercontent.com/danielcristho/setup-server/main/install.sh
chmod +x install.sh
./install.sh
```

## Features

- **Nginx**
- **PHP**
- **MariaDB**
- **Node.js**
- **PM2**
- **NetData**


NB: MariaDB credential(username&password) are generated using md5 hash of your server hostname and will be put into /etc/mysql/my.cnf after [client] directive.
