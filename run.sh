#!/bin/bash
echo $#
if [ $# -gt 1 ] ; then
  touch /home/ubuntu/app/logs
  ln -s /home/ubuntu/app/logs_link
  crontab -l > mycron
  echo "*4 * * * * python3 /home/ubuntu/app/backup.py $1 $2 $3" >> mycron
  crontab mycron
  rm mycron
  python3 /home/ubuntu/app/app.py /home/ubuntu/app/logs_link&
else
  echo 'error at startup'
fi