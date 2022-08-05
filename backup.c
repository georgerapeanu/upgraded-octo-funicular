#define _GNU_SOURCE

#include <unistd.h>
#include <fcntl.h>    
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <time.h>

int main(int argc, char** argv){
  if(argc != 3){
    printf("USAGE: %s PATH_TO_LOG_FILE DESTINATION\n", argv[0]);
    exit(1);
  }

  char* tmp_file_name = (char*)malloc(strlen(argv[1]) + 5);
  sprintf(tmp_file_name, "%s.tmp", argv[1]);
  int fd = open(tmp_file_name, O_CREAT);
  if(fd == -1){
    printf("Failed to create empty file %s\n", tmp_file_name);
    free(tmp_file_name);
    exit(1);
  }
  close(fd);
  renameat2(AT_FDCWD, argv[1], AT_FDCWD, tmp_file_name, RENAME_EXCHANGE);
  char* cmd = (char*)malloc(100 + strlen(tmp_file_name) + strlen(argv[2]));

  time_t rawtime;
  struct tm * timeinfo;

  time ( &rawtime );
  timeinfo = localtime ( &rawtime );

  sprintf(cmd, "scp -i \"/root/.ssh/a2b_key\" %s %s-%s", tmp_file_name, argv[2], asctime (timeinfo));
  system(cmd);
  unlink(tmp_file_name);
  free(tmp_file_name);
  free(cmd);

  return 0;
}