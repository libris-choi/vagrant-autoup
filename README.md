# vagrant-autoup
Vagrant will suspend/resume(up) when host computer stop/start
This script / systemd service will suspend / resume the all vagrant boxes in your user-id when system shutdown / startup

# Prerequisite
* Ubuntu 16.04 or higher
* systemd dependency

# Positioning the shell script
sudo mkdir -p /usr/lib/vagrant
sudo cp vagrant_autoup.sh /usr/lib/vagrant
sudo chmod +x /usr/lib/vagrant/vagrant_autoup.sh

# Configuration systemd
sudo cp vagrant.service /etc/systemd/system
sudo systemctl deamon-reload
sudo systemctl enable vagrant.service

# Check the service installation
ls /etc/systemd/system/multi-user.target.wants/vagrant.service

# Logging
tail -f -n100 /home/[USER]/vagrant_start.log
<code>
Fri May  1 13:36:19 UTC 2020
/home/[USER]/vagrant-folders/box-name
Bringing machine 'default' up with 'virtualbox' provider...
</code>
tail -f -n100 /home/[USER]/vagrant_stop.log
<code>
Fri May  1 13:35:55 UTC 2020
/home/[USER]/vagrant-folders/box-name
==> default: Saving VM state and suspending execution...
</code>
