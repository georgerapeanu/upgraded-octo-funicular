from os import unlink
from pydoc import cli
import sys
from datetime import datetime
from threading import local
import paramiko
import scp
import renameat2
import datetime

def createSSHClient(server, user):
    client = paramiko.SSHClient()
    client.load_system_host_keys()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(server, user)
    return client

if __name__ == '__main__':
  if len(sys.argv) != 4:
    print(f'USAGE: {sys.argv[0]} path_to_file host destination_path')
    sys.exit(1)
  
  localpath = sys.argv[1]
  host = sys.argv[2]
  destinationpath = sys.argv[3]
  tmppath = "%s.tmp" % localpath

  ssh = createSSHClient(host, "ubuntu")
  f = open(tmppath, "w")
  f.close()
  renameat2.exchange(tmppath, localpath)
  scp.put(ssh.get_transport(), tmppath, destinationpath + datetime.datetime.now().strftime("%d-%m-%Y-%H-%M-%S"))
  ssh.close()
  unlink(tmppath)
