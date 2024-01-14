#!/bin/bash

# Make sure the script is being executed with superuser or root privileges.
if [[ "${UID}" -ne 0 ]]
then 
	echo "Please run with sudo or as root" >&2
	exit 1 
fi
# If the user doesn't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
	echo "Create an account on the local system with the name of USER_NAME and comments field of COMMENT" >&2
	exit 1
fi
# The first parameter is the username
USER_NAME="${1}"

# The rest of the parameters are for the account comments (Real Name)
shift
COMMENT="${@}"
# Generate a password.
PASSWORD=$(date +s%N%${RANDOM})
# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null
# Check to see if the useradd command succeeded 
if [[ "${?}" -ne 0 ]]
then 
	echo "The account could not be created." >&2 
	exit 1 
fi
# Set the password 
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null 
# Check to see if the passwd command succeeded
if [[ "${?}" -ne 0 ]]
then
	echo "Password for the account could not be set." >&2
	exit 1
fi
# Force Password change on first login
passwd -e ${USER_NAME} &> /dev/null
# Display the Username, Password and the hoest where the user was created 
echo "Username:"
echo "${USER_NAME}"
echo
echo "Password:"
echo "${PASSWORD}"
echo
echo "host:"
echo "${HOSTNAME}"
exit 0 