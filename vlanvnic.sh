#!/bin/bash
#Creator: David Parra-Sandoval
#Date: 04/22/2024
#Last Modified: 04/22/2024
clear

echo "[Create the VLAN/VNIC device]"
echo -e "Add the VLAN/VNIC with the following command:\n"
echo -e "ip link add link eth0 name eth0.100 type vlan id 100\n"
echo -e "Change eth0 to the NIC that your going to tangent of from/to!"
echo -e "Thats the master interface; all traffic IS routed to it, with a VLAN tag."
echo -e "'Only VLAN-aware devices can accept them if configured correctly, else"
echo -e "the traffic is dropped.'\n"
read -p "PRESS Enter to set That Shit up!; H for Hell-NO-Continue: " VLANSET

case $VLANSET in
""|" " )
#ADAPTER
echo "Select the ADAPTER/NIC to Tangent from/to!"
select NIC in $(ls /sys/class/net); do
ADAPTER=$NIC #If you smart; experience, you know what to do.
echo "ADAPTER=$NIC"
break
done

until [[ $CREATEVLAN = "ip link add link $ADAPTER name eth0.100 type vlan id 100" ]]; do
read -p  "command: " CREATEVLAN
if [[ $CREATEVLAN != "ip link add link $ADAPTER name eth0.100 type vlan id 100" ]]; then
echo nope
echo re-try!
fi
done
$CREATEVLAN

echo -e "Using the name of eth0.100 is just for bullshit its NOT enforced;"
echo -e "you can name the created VLAN/VNIC with something descriptive like IPTV"
read -p "PRESS Enter to Continue: "
;;

h|H|[hH]* )
echo "Lame!" && sleep 3
;;
esac

clear
echo -e "Run ip link to confirm that it has been created\n"
echo -e "Also ip -d link show eth0.100 for full details of an interface/ADAPTER!"
echo -e The -d flag/switch IS for full details.

until [[ $SHOWCREATEDVLAN = "ip link" ]]; do
read -p  "command: " SHOWCREATEDVLAN
if [[ $SHOWCREATEDVLAN != "ip link" ]]; then
echo nope
echo re-try!
fi
if [[ $SHOWCREATEDVLAN = "ip -d link show eth0.100" ]]; then
break
fi
done
$SHOWCREATEDVLAN

read -p "PRESS Enter to Continue: "
clear
echo -e "[Adding an IP to the CREATED VLAN/VNIC]\n"
echo -e "The command:\n"
echo -e "ip addr add 192.168.100.1/24 brd 192.168.100.255 dev eth0.100"
echo
echo -e "Add the IPv4 address to the CREATED VLAN/VNIC\n"
until [[ $IPADDRADDVLAN = "ip addr add 192.168.100.1/24 brd 192.168.100.255 dev eth0.100" ]]; do
read -p  "command: " IPADDRADDVLAN
if [[ $IPADDRADDVLAN != "ip addr add 192.168.100.1/24 brd 192.168.100.255 dev eth0.100" ]]; then
echo nope
echo re-try!
fi
done
$IPADDRADDVLAN

echo -e "When ADDING an ip address to the VLAN/VNIC use your Network Addresses"
echo -e "associated with YOUR network!"
echo -e "So 192.168.100.1/24 might equal 192.168.1.20/24 the 20 is for your IP the 1 is for your Gateway/Router/Route"
echo -e "So 192.168.100.255 might equal 192.168.1.255 Netmask"
read -p "PRESS Enter to Continue: "
echo
echo -e "[Bring that VLAN/VNIC fucking UP]\n"
echo -e "command:\n"
echo -e "ip link set dev eth0.100 up or ip link set eth0.100 up\n"

until [[ $BRINGVLANUP = "ip link set dev eth0.100 up" ]]; do
read -p  "command: " BRINGVLANUP
if [[ $BRINGVLANUP != "ip link set dev eth0.100 up" ]]; then
echo nope
echo re-try!
fi
if [[ $BRINGVLANUP = "ip link set eth0.100 up" ]]; then
break
fi
done
ip -c address

echo
echo -e "Turning down the interface/ADAPTER/VLAN/VNIC"
echo -e "Same fucking command just put down instead of up"
read -p "PRESS Enter to Continue: "
echo
echo -e "[Removing the CREATED VLAN/VNIC]\n"
echo -e "The command:\n"
echo -e "ip link delete eth0.100 removes that bitch\n"
echo -e "Enter the command to remove that mother-fucker HAHAHAhahahaha"

until [[ $DELETEVLAN = "ip link delete eth0.100" ]]; do
read -p "command: " DELETEVLAN
if [[ $DELETEVLAN != "ip link delete eth0.100" ]]; then
echo nope
echo re-try!
fi
done
$DELETEVLAN

clear
ip -c address
echo
echo -e "The Source reference: https://wiki.archlinux.org/title/VLAN"
