#!/bin/bash
. utilities/colors.sh


echo -e "     ████████ ████████ ██████████ ██     ██ ███████  ███████   "
echo -e "    ██░░░░░░ ░██░░░░░ ░░░░░██░░░ ░██    ░██░██░░░░██░██░░░░██  "
echo -e "   ░██       ░██          ░██    ░██    ░██░██   ░██░██    ░██ "
echo -e "   ░█████████░███████     ░██    ░██    ░██░███████ ░██    ░██ "
echo -e "   ░░░░░░░░██░██░░░░      ░██    ░██    ░██░██░░░░  ░██    ░██ "
echo -e "          ░██░██          ░██    ░██    ░██░██      ░██    ██  "
echo -e "    ████████ ░████████    ░██    ░░███████ ░██      ░███████   "
echo -e "    ░░░░░░░░  ░░░░░░░░     ░░      ░░░░░░░  ░░       ░░░░░░░   "
echo -e "by: $GREEN@danielcristho$RESET_COLOR                           "

echo "" $GREEN
echo "" $GREEN
echo "${LIGHTCYAN}${BOLD}Read the following and Accept if you agree.${NOSTYLE}" $GREEN
echo "" $GREEN
echo "I created this script for my own preferences. It may or may not suitable for you. And i haven't added Error Checks. So it might go wrong at anytime. And it was created to facilitate the setup of Fresh Server! I am in no way responsible, if anything happens to your Server. ${ITALICS}You are responsible for any problems. ${YELLOW}If You agree this script will detect what Linux Distirbution You use.${NOSTYLE}" $GREEN
echo "" $GREEN
echo "${LIGHTCYAN}Do you agree? [Y/n] ${NOSTYLE}"
read yn

if [ "$yn" = "y" -o "$yn" = "Y" -o "$yn" = "" ]; then
	echo "You Agreed...✅" $INITIAL_SCREEN
    clear

    if [ -f /etc/os-release ]; then
        source /etc/os-release

        DISTRIBUTION=$NAME
    else
        DISTRIBUTION="Unknown"
    fi
    # Ubuntu
    case "$DISTRIBUTION" in
        "Ubuntu")
            if [[ "$VERSION_ID" == "18.04" ]]; then
                echo "Your distribution is : ${RED}Ubuntu 18.04.${RESET_COLOR} Proceeding with setup...✅"

            elif [[ "$VERSION_ID" == "20.04" ]]; then
                echo "Your distribution is : ${RED}Ubuntu 20.04.${RESET_COLOR} Proceeding with setup...✅"

            elif [[ "$VERSION_ID" == "22.04" ]]; then
                echo "Your distribution is : ${RED}Ubuntu 22.04.${RESET_COLOR} Proceeding with setup...✅"
    else
        echo "Unsupported Ubuntu version. Please perform manual setup."
    fi

echo -e "\033[1;91m"
echo -e "  ████████ ████████ ██████████ ██     ██ ███████  ██     ██ ██████     "
echo -e " ██░░░░░░ ░██░░░░░ ░░░░░██░░░ ░██    ░██░██░░░░██░██    ░██░█░░░░██    "
echo -e "░██       ░██          ░██    ░██    ░██░██   ░██░██    ░██░█   ░██    "
echo -e "░█████████░███████     ░██    ░██    ░██░███████ ░██    ░██░██████     "
echo -e "░░░░░░░░██░██░░░░      ░██    ░██    ░██░██░░░░  ░██    ░██░█░░░░ ██   "
echo -e "       ░██░██          ░██    ░██    ░██░██      ░██    ░██░█    ░██   "
echo -e " ████████ ░████████    ░██    ░░███████ ░██      ░░███████ ░███████    "
echo -e "░░░░░░░░  ░░░░░░░░     ░░      ░░░░░░░  ░░        ░░░░░░░  ░░░░░░░     "
            ;;
        *)
            echo "Unsupported distribution. Manual setup is recommended."
            # Manual Setup
            read -p "Do you want to perform manual setup? [Y/n] " manual_setup
            if [ "$manual_setup" != "n" ] && [ "$manual_setup" != "N" ]; then
                echo "You chose manual setup."
            else
                echo "Exiting script. Please perform manual setup."
            fi
            ;;
    esac
else
	echo "You Disagreed.❌" $INITIAL_SCREEN
fi

echo "${NOSTYLE}"
