#!/bin/bash

# رنگ ها برای نمایش پیام ها
GREEN='\033[0;32m'
NC='\033[0m' # Reset color

# تابع برای چاپ لوگو
print_logo() {
    clear
    echo -e "\e[1;31m#########################################################\e[0m"
    echo -e "\e[1;31m#                                                       #\e[0m"
    echo -e "\e[1;31m#                      ███╗   ███╗                      #\e[0m"
    echo -e "\e[1;31m#                      ████╗ ████║                      #\e[0m"
    echo -e "\e[1;31m#                      ██╔████╔██║                      #\e[0m"
    echo -e "\e[1;31m#                      ██║╚██╔╝██║                      #\e[0m"
    echo -e "\e[1;31m#                      ██║ ╚═╝ ██║                      #\e[0m"
    echo -e "\e[1;31m#                      ╚═╝     ╚═╝                      #\e[0m"
    echo -e "\e[1;31m#                                                       #\e[0m"
    echo -e "\e[1;31m#                   M E Y S A M S H 1 0 9 2             #\e[0m"
    echo -e "\e[1;31m#########################################################\e[0m"
    echo ""
}

# تابع آپدیت
update_backhaul() {
    cd /root/
    rm backhaul_linux_amd64.tar.gz
    wget https://github.com/Musixal/Backhaul/releases/latest/download/backhaul_linux_amd64.tar.gz
    tar -xzvf backhaul_linux_amd64.tar.gz
    rm backhaul_linux_amd64.tar.gz
    systemctl restart backhaul.service
    echo -e "${GREEN}Backhaul updated successfully.${NC}"
}

# تابع برای نمایش پیام و پاک کردن صفحه
pause_and_clear() {
    read -p "Press Enter to return to the main menu..."
    clear
}

# تابع برای نمایش وضعیت سرویس
check_service_status() {
    local temp_file="/tmp/backhaul_status.txt"
    systemctl status backhaul.service > "$temp_file" 2>&1
    cat "$temp_file"
    rm -f "$temp_file"
    pause_and_clear
}

# منوی انتخاب
while true; do
    print_logo
    echo "Choose an option:"
    echo "1) Update Backhaul"
    echo "2) Restart Backhaul Service"
    echo "3) Check Backhaul Service Status"
    echo "4) Check Backhaul Version"
    echo "5) Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            update_backhaul
            pause_and_clear
            ;;
        2)
            systemctl restart backhaul.service
            echo -e "${GREEN}Backhaul service restarted.${NC}"
            pause_and_clear
            ;;
        3)
            check_service_status
            ;;
        4)
            ./backhaul -v
            pause_and_clear
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            pause_and_clear
            ;;
    esac
done
