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
#========== Configure Remote System=====
#========================================
while true; do
    clear
    echo "               Configure Remote System"
    echo " ____________________________________________________________________"
    echo " "
        read -p '  Enter the IP address of the Control comptuer.......' controlvar
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
    echo "               Sending ssh key to Control system"
    echo " ____________________________________________________________________"
    echo " "
    echo "   I need to send the ssh key to the control computer system"
    echo "   You will be asked to enter the control computer password" 
    echo ""
ssh-copy-id $controlvar
echo "   Creating connection script in /root/scripts/ssh_connect.sh"
mkdir /root/scripts
cat << EOF > /root/scripts/ssh_connect.sh
#!/bin/bash
#MALP Auto-Reconnection Script
#Modify this script with your parameters for establishing a reverse shell.

sleep 20

while true; do
	echo "Checking for SSH connections..."
	check=$(netstat -tnpa | awk '{print $7}' | grep ssh | tail -c 5 | grep -ic "/ssh")

	if [ $check -ge 1 ] 
	then
		echo "SSH connection active.  Checking again in 10 minutes..."
		sleep 10m
		continue
	else
		echo "No SSH connections active.  Attempting SSH connection..."
		ssh -N -R 2222:localhost:22 root@RRRR -p 22 &
		sleep 10m
		continue
	fi
done
EOF
chmod +x /root/scripts/ssh_connect.sh
sed -i "s|RRRR|$controlvar|g" /root/scripts/ssh_connect.sh
echo "   Creating connect service"
cat << EOF > /lib/systemd/system/ssh_connect.service
[Unit]
Description=Open SSH Connection to control
After=network.target

[Service]
Type=simple
WorkingDirectory=/usr/bin/
ExecStart=/bin/bash /root/scripts/ssh_connect.sh
SyslogIdentifier=ssh_control

[Install]
WantedBy=multi-user.target
EOF
echo "   Starting ssh_connect service..."
systemctl enable ssh_connect.service
echo ""
echo ""
echo "   The configuration of the Remote computer is complete."
echo "   A system reboot is required. "
puase









