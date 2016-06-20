#!/bin/bash
# Program:
#     To change host`s name,by "$(hostname) ; vim /etc/sysconfig/network ; vim /etc/hosts"

cHostname(){
    read -p 'Enter your new host name:' nName
    (hostname ${nName})
    (sed -i "/^127.0.0.1/s/^127.0.0.1/&    ${nName}/g" /etc/hosts)
    (sed -i "/^::1/s/^::1/&    ${nName}/g" /etc/hosts)
    (sed -i "s/^HOSTNAME.*/HOSTNAME=${nName}/g" /etc/sysconfig/network)
}

PS3="Enter the number:"
select choose in "Change Hostname" "Quit"
do
    case ${choose} in
    "Change Hostname")
        cHostname
    ;;
    "Quit")
        break
    ;;
    *)
        echo "Input Error"
    ;;
    esac
done
