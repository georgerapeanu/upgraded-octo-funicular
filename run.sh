#!/bin/bash
echo $#
if [ $# -gt 1 ] ; then
  crontab -l > mycron
  echo "*4 * * * * python3 /home/ubuntu/app/backup.py $1 $2 $3" >> mycron
  crontab mycron
  rm mycron
  python3 /home/ubuntu/app/app.py $1&
else
  echo 'error at startup'
fi