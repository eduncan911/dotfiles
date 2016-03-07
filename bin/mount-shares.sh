# first, this script expects fstab to be edited with the following mounts:

# HITOSHI
#//172.16.1.20/movies  /media/hitoshi/movies  cifs  noauto,credentials=/home/eric/.smbmediacenter  0  0
#//172.16.1.20/tv  /media/hitoshi/tv  cifs  noauto,credentials=/home/eric/.smbmediacenter  0  0
# SPOCK
#//172.16.1.31/scratch  /media/spock/scratch  cifs  noauto,credentials=/home/eric/.smbmediacenter  0  0

# Notice the "noauto" option.  

# Also notice the .smbmediacenter file.  This is used to store the credentials, so the u/p isn't in
# this script or fstab.

# To mount the file system, use:

mount /media/hitoshi/tv
mount /media/hitoshi/movies
mount /media/spock/scratch

