# Setup Server

BASH Script for stack installation and configure your Ubuntu, including Node, Yarn and etc.

## Requirements

- Ubuntu 18.04 or latest version
- This script utilises root user privileges. If you run it from another user you need to add this user to sudoers group and prepend sudo to all commands in the script.

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

MariaDB credential(username&password) are generated using md5 hash of your server hostname and will be put into /etc/mysql/my.cnf after [client] directive.
