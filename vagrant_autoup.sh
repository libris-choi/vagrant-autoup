#!/bin/sh -e
### BEGIN INIT INFO
# Provides:          something warm and fuzzy 
# Required-Start:    vboxdrv
# Required-Stop:     vboxdrv
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts suspended vagrant boxes and suspends running vagrant boxes
# Description:       
### END INIT INFO

# references : https://www.ollegustafsson.com/en/vagrant-suspend-resume/
# presumably only users with valid login shells are running vagrant boxes
#validShells=$(cat /etc/shells | grep -v "#" | sed ':a;N;$!ba;s/\n/|/g')
#userList=$(grep -E "$validShells" /etc/passwd | awk -F ':' ' { print $1 } ' | tr "\\n" " ")
user=[USER]

case $1 in
  start)
    # loop thru users suspended boxes
    for vm in $(su -c "vagrant global-status" $user 2>/dev/null | grep "saved\|poweroff" | awk ' { print $5} '); do
      cd $vm > /dev/null
      su -c "date >> /home/$user/vagrant_start.log" $user
      su -c "echo $vm >> /home/$user/vagrant_start.log" $user
      su -c "vagrant up >> /home/$user/vagrant_start.log" $user
    done
  ;;
  stop)
    for vm in $(su -c "vagrant global-status" $user 2>/dev/null | grep running | awk ' { print $5} '); do
      cd $vm > /dev/null
      su -c "date >> /home/$user/vagrant_stop.log" $user
      su -c "echo $vm >> /home/$user/vagrant_stop.log" $user
      su -c "vagrant suspend >> /home/$user/vagrant_stop.log" $user
    done
  ;;
  status)
    echo "$user's vagrant box status"
    echo "------------------------------------------------------------------------"
    #su -c "vagrant global-status 2> /dev/null" $user
    echo
    echo
  ;;
  *)
    echo "Usage: $0 {start|stop|status}" >&2
    exit 1
  ;;
esac

exit 0

