#!/bin/bash

OLD_USER=""
NEW_USER=""
NEW_HOSTNAME=""
NEW_PASSWORD=""

read -p "Enter old username: " OLD_USER
read -p "Enter new username: " NEW_USER
read -sp "Enter new password: " NEW_PASSWORD  # -s versteckt Eingabe
echo
read -p "Enter new hostname: " NEW_HOSTNAME


if ! id "$OLD_USER" &>/dev/null; then
    echo "User $OLD_USER existiert nicht!"
    exit 1
fi

pkill -u "$OLD_USER"
sleep 1  

usermod -l "$NEW_USER" "$OLD_USER"
groupmod -n "$NEW_USER" "$OLD_USER"
usermod -d "/home/$NEW_USER" -m "$NEW_USER"
chown -R "$NEW_USER:$NEW_USER" "/home/$NEW_USER"

hostnamectl hostname "$NEW_HOSTNAME"

echo "$NEW_USER:$NEW_PASSWORD" | chpasswd

nano /etc/ssh/sshd_config

echo "Everything Complete"
sleep 1
echo "Quick look in /etc/group and /etc/passwd"
grep "$NEW_USER" /etc/passwd /etc/group
read -p "Press any key to continue..."

exit 0