#!/bin/bash

ARCHIVE_DIR="/path/to/archive/directory"

usage() {
  echo "Usage: ${0} [-dD] username [username2 ...]"
  echo "Disable or delete users based on the provided options."
  echo "Options:"
  echo " -d Disable		(User will be disabled)"
  echo " -D Delete		(User will be deleted)"
  echo " -a Archive		(Create an archive of the user's home directory)"
  exit 1
}

# Check for superuser privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run with superuser privileges."
  exit 1
fi

# Parse options
while getopts ":dDa" opt; do
  case ${opt} in
    d)
      action="disable"
      ;;
    D)
      action="delete"
      ;;
    a)
      create_archive=true
      ;;
    ?)
      echo "Invalid option: -$OPTARG"
      usage
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      usage
      ;;
  esac
done

# Remove the options, leaving the remaining arguments
shift $((OPTIND - 1))

# If no usernames provided, give help
if [ "$#" -eq 0 ]; then
  echo "At least one username must be provided."
  usage
fi

# Loop through usernames
for username in "$@"; do
  # Check if the user exists
  if id "$username" >/dev/null 2>&1; then
    # Get UID of the user
    user_uid=$(id -u "$username")

    # Check if UID is at least 1000
    if [ "$user_uid" -ge 1000 ]; then
      echo "Processing $username..."

      # Create an archive if requested
      if [ "$create_archive" = true ]; then
        # Check if ARCHIVE_DIR exists
        if [ ! -d "$ARCHIVE_DIR" ]; then
          echo "Error: $ARCHIVE_DIR directory does not exist."
          exit 1
        fi

        # Create an archive of the user's home directory
        archive_filename="${ARCHIVE_DIR}/${username}_archive_$(date '+%Y%m%d_%H%M%S').tar.gz"
        tar -czvf "$archive_filename" -C /home "$username"
        echo "Archive $archive_filename created successfully."
      fi

      # Delete or disable the user based on the action
      if [ "$action" = "delete" ]; then
        userdel -r "$username"
        # Check if userdel command succeeded
        if [ "$?" -eq 0 ]; then
          echo "User $username deleted successfully."
        else
          echo "Error: User $username deletion failed."
        fi
      elif [ "$action" = "disable" ]; then
        chage -E 0 "$username"
        # Check if chage command succeeded
        if [ "$?" -eq 0 ]; then
          echo "User $username disabled successfully."
        else
          echo "Error: User $username disable failed."
        fi
      fi
    else
      echo "Error: UID of $username is less than 1000. Skipping."
    fi
  else
    echo "Error: User $username does not exist. Skipping."
  fi
done

echo "Script completed successfully."
