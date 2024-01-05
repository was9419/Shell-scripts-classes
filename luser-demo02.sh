#!/bin/bash

# Display the UID and username of the user executing this script
# Display if the user is the root user or if they are some other user 

# Display the username
echo "Your UID is ${UID}"
# Display the username
# Older variables were written as `id -un`
USER_NAME=$(id -un)
echo "Your username is ${USER_NAME}"
# Display if the user is the root user or not
if [[ "${UID}" -eq 0 ]]
then
	echo 'You are root.'
else
	echo 'You are root.'
	fi