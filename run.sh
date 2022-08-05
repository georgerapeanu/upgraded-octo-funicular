if [ $# -gt 1 ] && gcc /home/ubuntu/app/backup.c -o /home/ubuntu/app/backup; then
  echo "*/5 * * * * /home/ubuntu/app/backup $1 $2" >> mycron
  crontab mycron
  rm mycron
  python3 /home/ubuntu/app/app.py /home/ubuntu/app/file
else
  echo 'error at startup'
fi