import sys
from datetime import datetime
from time import sleep

if __name__ == '__main__':
  if len(sys.argv) != 2:
    print(f'USAGE: {sys.argv[0]} path_to_file')
    sys.exit(1)
  
  path = sys.argv[1]
  
  try:
    with open(path, 'a') as f:
      while True:
        ts = datetime.now()
        content = f'[{ts}] Writing to {path}.\n'
  
        try:
          f.write(content)
          print(content, end='')
        except:
          print(f'Error: Could not write to {path}.')
          sys.exit(1)
        sleep(60.0)
  except IOError:
    print(f'Error: Could not open the file {path}.')
    sys.exit(1)
