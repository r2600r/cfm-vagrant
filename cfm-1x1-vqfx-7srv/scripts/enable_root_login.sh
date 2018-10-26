#!/bin/bash -eux

#login as root
sudo su -

sudo sed -e '/PermitRootLogin/ s/^#*/#/' -i /etc/ssh/sshd_config
sudo sed '/^#PermitRootLogin/a PermitRootLogin yes' -i /etc/ssh/sshd_config
sudo sed -i '/^#ListenAddress 0.0.0.0/s/^#//' -i /etc/ssh/sshd_config
sudo sed '/^#PasswordAuthentication/a PasswordAuthentication yes' -i /etc/ssh/sshd_config
sudo systemctl reload sshd

echo "root:c0ntrail123" | sudo chpasswd

sudo iptables -F

cat << EOFF > .bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
HISTSIZE=1000
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;101m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
EOFF