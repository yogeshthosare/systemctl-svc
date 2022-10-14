#!/bin/sh
#

set -e
svc_user="yogesht"

# Create service user and group with the same name
useradd -rmU -s /usr/sbin/nologin -c "My amazing service" ${svc_user}
case "$?" in
	0) echo "Service user '${svc_user}' and group created successfully";;
	9) echo "Service user '${svc_user}' existed prior to install";;
	*) echo "Pre-install script failed to create service user '${svc_user}'" >&2
       exit 1;;
esac

# Add 'daemon' user to service group
usermod -a -G ${svc_user} daemon
case "$?" in
	0) echo "User 'daemon' added to service group '${svc_user}' successfully";;
	*) echo "Failed to add 'daemon' user to service group '${svc_user}" >$2
	   exit 1;;
esac


echo "Move the binary at /sbin"
sudo cp amazingsvc /sbin/

echo "Move service definition at /etc/systemd/system/"
sudo cp myAmazingService.service /etc/systemd/system/myAmazingService.service

echo "Enable the service"
systemctl enable myAmazingService.service
sleep 2

echo "Start the service the service"
systemctl start myAmazingService.service

exit 0
