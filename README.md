# vagrant-autoup
This script / systemd service will suspend / resume the all vagrant boxes in your user-id when system shutdown / startup

## Prerequisite
* Ubuntu 16.04 or higher
* systemd dependency

## Positioning the shell script
```sh
sudo mkdir -p /usr/lib/vagrant
sudo cp vagrant_autoup.sh /usr/lib/vagrant
sudo chmod +x /usr/lib/vagrant/vagrant_autoup.sh
```

## Configuration systemd
```sh
sudo cp vagrant.service /etc/systemd/system
sudo systemctl deamon-reload
sudo systemctl enable vagrant.service
```

## Check the service installation
```sh
ls /etc/systemd/system/multi-user.target.wants/vagrant.service
```

## Logging
```sh
$ tail -f -n100 /home/[USER]/vagrant_start.log
Fri May  1 13:36:19 UTC 2020
/home/[USER]/vagrant-folders/box-name
Bringing machine 'default' up with 'virtualbox' provider...
```

```sh
$ tail -f -n100 /home/[USER]/vagrant_stop.log
Fri May  1 13:35:55 UTC 2020
/home/[USER]/vagrant-folders/box-name
==> default: Saving VM state and suspending execution...
```

## Sample Vagrantfile
```sh
config.vm.box = "ubuntu/xenial64"

# default: 80 (guest) => 8080 (host) (adapter 1)
# default: 22 (guest) => 2222 (host) (adapter 1)
config.vm.network "forwarded_port", guest: 80, host: 8080

# Shared folder
config.vm.synced_folder "~/[CERTAIN_DIRECTORY]", "/home/vagrant/[CERTAIN_DIRECTORY]"

vb.memory = "2048"

# vagrant user configuration
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sed -i '193i\\set nu\\' ~/.vim_runtime/vimrcs/basic.vim
sh ~/.vim_runtime/install_awesome_vimrc.sh
sed -i 's/$PATH/\\/vagrant\\/bin:$PATH/g' ~/.profile
```
