#!/bin/bash

log () {
	# This function sends a mesasge to syslog and to standar output if VERBOSE is true.
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
	logger -t luser-demo10.sh "${MESSAGE}"
}
backup_file() {
	# This function creates a backlup of a file. Returnos non-zero statuys on error.

	local FILE="${1}"

	#Make sure the file exist.
	if [[ -f "${FILE}" ]]
	then
		local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
		log "Backing up ${FILE} to ${BACKUP_FILE}."

		# The exit status of the function will be the exit status of the cp command.
		cp -p ${FILE} ${BACKUP_FILE}
	else 
		# The file does not exist, so return a non-zero exit status.
		return 1
	fi
}


log "Hello!"
VERBOSE='true'
log "This is fun!"
backup_file '/etc/passwd'

# Make a decision based on the exit status of the function.
if [[ "S{?}" -eq '0' ]]
then
	log 'File backup succeeded!'
else
	log 'File backup failed!'
	exit 1
fi
