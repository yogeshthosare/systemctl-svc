echo "Running cleanup - removing service"
systemctl stop myAmazingService.service
systemctl disable myAmazingService.service
systemctl stop myAmazingService.service
rm /etc/systemd/system/myAmazingService.service
rm /etc/systemd/system/multi-user.target.wants/myAmazingService.service # and symlink if present
systemctl daemon-reload
systemctl reset-failed

echo "Removing binary"
rm -rf /sbin/amazingsvc

echo "Running cleanup - removing user and group"
sudo gpasswd -d daemon yogesht
sudo deluser --remove-home yogesht
sudo delgroup yogesht
