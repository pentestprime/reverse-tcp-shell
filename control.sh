#!/bin/bash
#===========================
# Start init
#===========================
function pause(){
    echo 'Press any key to continue...';   read -p "$*"
}
#  End INIT

#=================================================
#===========  Start Main script ==================
#========= Version 1.0.1  7-18-2018 ==============
#=================================================
clear

#========================================
#========== Configure Control System=====
#========================================
while true; do
    clear
    echo "               Configure Control System"
    echo " ____________________________________________________________________"
    echo " "
        read -p '  Enter the IP address of the Remote comptuer.......' remotevar
    echo " "
        read -p "Is the information you entered correct?(y/n) " yn
        case $yn in
            [Yy]* ) break;;
            * ) echo " ";;
        esac
done
echo "    We need to create new SSH keys"
echo "    The keys must be RSA keys"
echo "    If you have already created these keys"
echo "    you will have the option to keey your current keys"
echo "    Other than that please choose the defaults by pressing ENTER"
pause
ssh-keygen -t rsa
echo " "
echo "   Backing up and modifying system files"
cp /etc/ssh/sshd_config /ect/ssh/sshd_config.bak
echo "GatewayPorts yes" >> /etc/ssh/sshd_config
systemctl restart ssh
systemctl enable ssh.socket
    clear
    echo "               Sending ssh key to Remote system"
    echo " ____________________________________________________________________"
    echo " "
    echo "   I need to send the ssh key to the remote system"
    echo "   You will be asked to enter the remote computer password" 
ssh-copy-id –p 22 $remotevar
echo ""
echo ""
echo "   The configuration of the Control computer is complete."
echo "   After the Remote computer is configured and waiting for"
echo "   all you need to to is run the connect.sh script to"
echo "   complete the connect to the remote computer"









