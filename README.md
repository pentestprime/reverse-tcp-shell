# reverse-tcp-shell 
Kali Linux Reverse TCP Shell for remote control

These scripts must be used ONLY for the purpose of LEGAL penetration testing by qualified penetration testers.  I am not responsible for any illegal use of these scripts.  This project was inspired by the need for penetration testers to interrogate a client network from a remote location.

Reverse TCP shell requires two Kali Linux based computers, a remote and a control computer.  The remote computer could be a laptop or something such as a raspberry pi.  The device can be placed on a clients network and then accessed via the control computer located at a remote site.

The scripts:
The control.sh script should be executed before running the remote.sh script
Make sure the control computer is running before rebooting the remote computer


control.sh - execute on the control computer for initial configuration
remote.sh – execute on the remote computer for initial configuration
changecontrol_location.sh – execute on the remote computer when to location of the control computer changes
connect.sh – execute on the control computer to complete the connection


  
