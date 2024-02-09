#!/bin/bash
# Author: Wilfredo Santamaria 
# Creation date 02/08/2024
# This script will run basic admin task
echo
echo "This script will run basic administrative commands" 
echo
top | head -10
echo
df -h
echo
free -m
echo
uptime
echo
iostat
echo
echo "End of Script" 
