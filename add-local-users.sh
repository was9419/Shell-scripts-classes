#!/bin/bash

# Enforce script to run with root privileges if not return exit status 1 and not create user
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi
# Prompt user executing the script to enter username, real name and initial password
read -p "Enter the username: " USER_NAME
read -p "Enter the user real name: " NAME
read -p "Enter the initial password: " PASSWORD
# Create new user in local system with the input above 
adduser -c "${NAME}" -m ${USER_NAME} 
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
passwd -e ${USER_NAME} 
# Inform if account was succesfully created otherwise exit 1 status as return 
if [[ adduser -eq 0 ]]
then
	echo "User ${USER_NAME} was succesfully created"
else
	echo "User creatiion failed, please try again" 
	exit 
fi
# Display username, password and host where account was created, staff can copy the output to deliver information to account holder 
echo "${USER_NAME}"
echo "${PASSWORD}"
hostname -s