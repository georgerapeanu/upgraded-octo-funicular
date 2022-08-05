if [ $# -gt 1 ] && gcc /app/backup.c -o /app/backup; then
  crontab -l > mycron
  echo "30 * * * * /app/backup $1 $2" >> mycron
  crontab mycron
  rm mycron
  python3 /app/app.py /app/file
else
  echo 'error at startup'
fi