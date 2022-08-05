if gcc /app/backup.c -o /app/backup; then
  /app/backup $1 $2
  python3 /app/app.py /app/file
else
  echo 'error at startup'
fi