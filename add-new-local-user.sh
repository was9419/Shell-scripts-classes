#!/bin/bash

# Check if script is running with ROOT privileges.
if [[ "$[UID]" -ne 0 ]]
then
	echo "Please run with sudo or as root."
	exit 1 
fi 
# If no paraneters are share while running the sctipt fail and exit 1 
if [[ "${#}" -lt 2 ]]
then 
	echo "No paraneters were shared while running the script."
	exit 1 
fi
echo
# Shows parameters 
echo "Username: $1"
echo "Name: $2"
HOSTNAME=$(hostname -s)
# Creates user in the system 
adduser -c "${2}" -m "${1}" 
PASSWORD=$(date +%s%N${RANDOM})
echo "${PASSWORD}" | passwd --stdin ${1}
passwd -e ${1}
echo
# Informs if the user was sucessfully created.
if [[ adduser -eq 0 ]]
then
	echo "User ${1} was sucessfully created."
else
	echo "User creation failed, please try again"
	exit
fi
echo
# Display information (username, password and host) to share with staff 
echo "Username: ${1}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"