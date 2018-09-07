#!/bin/bash
#Running Script to get CSV: ./listArtifacts.sh > test.csv

printf 'Bash script for linux\n\n'

printf '\n---Current time:---\n'
date "+%m/%d/%Y %H:%M:%S"

printf '\n---Time Zone---\n'
timedatectl status | grep 'Time zone'

printf '\n---PC uptime---\n'
uptime | awk -F ',' '{print $1}' | cut -d ' ' -f 3-

printf '\n---OS Version / Numerical Info---\n'
uname -a

printf '\n---Typical Name---\n'
uname

printf '\n---Kernel Version---\n'
uname -v

printf '\n---CPU Brand & Type---\n'
cat /proc/cpuinfo | grep 'model name	:'

printf '\n---Ram Ammount---\n'
cat /proc/meminfo | grep 'MemTotal'

printf '\n---Listed Harddrives & Mounted File Systems---\n'
lsblk

printf '\n---Hostname---\n'
hostname

printf '\n---Domain---\n'
domainname

printf '\n---Users---\n'
cut -d: -f1 /etc/passwd

printf '\n---Login History---\n'
last

printf '\n---Start at boot---\n'
systemctl list-unit-files | grep enabled

printf '\n---List of Scheduled Tasks---\n'
crontab -l

printf '\n---Network---\n'
ip a

printf '\n---DNS---\n'
cat /etc/resolv.conf 

printf '\n---Listening Services---\n'
netstat -tulpna

printf '\n---Established Connections---\n'
netstat -apn | grep ESTABLISH

printf '\n---List Printers---\n'
lpstat -p -d

printf '\n---Installed Software---\n'
dpkg --get-selections

printf '\n---Process List---\n'
ps -aux

printf '\n---Drivers List---\n'
lsmod

printf '\n---List of files in Downloads and Documents---\n'
ls /home/*/Downloads && ls /home/*/Documents

# 3 of my own!
printf '\n---List Recently Modified Files in Last 60 Days---\n'
find -type f -mtime -60

printf '\n---List History of Commands---\n'
cat ~/.bash_history

printf '\n---Remaining Storage Space on Machine---\n'
df -k .

printf '\n\n'
