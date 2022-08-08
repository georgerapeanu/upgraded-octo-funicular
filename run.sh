echo $#
if [ $# -gt 1 ] && gcc /home/ubuntu/app/backup.c -o /home/ubuntu/app/backup; then
  python3 /home/ubuntu/app/app.py /home/ubuntu/app/file
  crontab -l > mycron
  echo "*4 * * * * /home/ubuntu/app/backup $1 $2" >> mycron
  crontab mycron
  rm mycron
else
  echo 'error at startup'
fi