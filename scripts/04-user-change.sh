#!/bin/bash
OLD_USER=""
NEW_USER=""
NEW_HOSTNAME=""
NEW_PASSWORD=""

read -p "Enter old username: " OLD_USER
read -p "Enter new username: " NEW_USER
read -p "Enter new password: " NEW_PASSWORD
read -p "Enter new hostname: " NEW_HOSTNAME

pkill -u "$OLD_USER"
usermod -l "$NEW_USER" "$OLD_USER"
groupmod -n "$NEW_USER" "$OLD_USER"
usermod -d /home/$NEW_USER -m "$NEW_USER"
chown -R "$NEW_USER:$NEW_USER" /home/$NEW_USER

hostnamectl hostname "$NEW_HOSTNAME"

echo "$NEW_USER:$NEW_PASSWORD" | chpasswd
nano /etc/ssh/sshd_config

echo -e "Everything Complete"
sleep 1
echo -e "Quick look in /etc/group and /etc/passwd"
ls /etc/group
ls /etc/passwd
read -p "Press any key to continue..."

exit 0


