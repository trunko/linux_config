# Setting Up Archlinux

Referencing the official wiki setup guide [here](https://wiki.archlinux.org/index.php/installation_guide).

## Partitioning the Disks

#### Look at all the disks
```shell
$ fdisk -l
```

Find the drive to install to, probably in the form sda.

#### Once the correct drive is found:
```shell
$ cfdisk /dev/sda
# Where sda is the disk to format
```

#### From there
1. Select gpt
1. Create 1 partition with the linux filesystem
1. Leave space for linux swap, where the size should be the same as your RAM, preferably more
1. Write, then type yes and quit

## Making a filesystem
```shell
$ mkfs.ext4 /dev/sda1
$ mount /dev/sda1 /mnt
```

#### Enable swap space
```shell
$ mkswap /dev/sda2
$ swapon /dev/sda2
```

#### Make sure you are connected to the internet
```shell
$ ping -c 3 google.com
```

## Install Arch

```shell
$ pacstrap /mnt base base-devel grub xorg-server xorg-xinit xorg-apps alsa-utils vim git wireless_tools wpa_supplicant wpa_actiond dialog
# Add any other packages you may need to the list
```

#### Access mount point
```shell
$ arch-chroot /mnt
```

#### Create Root Password
```shell
$ passwd
```

#### Locale-gen
```shell
$ vim /etc/locale.gen
# Uncomment appropriate lines i.e. en_US...
$ locale-gen
```

#### Setting Time Zone
Find region using `ls /usr/share/zoneinfo/`
Then `ls` into that region and find your zone
```shell
$ ln -sf /usr/share/zoneinfo/US/Central /etc/localtime
```

#### Create a Host Name
```shell
$ echo arch > /etc/hostname
```

#### Create a New User
```shell
$ useradd -m -g users -G wheel -s /bin/bash (username)
$ passwd (username)
```

#### Give Your User `sudo` Access
```shell
$ vim /etc/sudoers
# Uncomment the wheel all line
```

## Turning on Sound
```shell
$ alsamixer
# Change the gain for everything to 0 by filling all the bars
# Use esc to exit
```

## Install Grub and Reboot
```shell
$ grub-install /dev/sda
# use the --force tag if using a vm

$ mkinitcpio -p linux
$ grub-mkconfig -o /boot/grub/grub.cfg
$ exit
$ genfstab -p /mnt >> /mnt/etc/fstab
$ umount -R /mnt
$ shutdown now
```

**At this point, remove the disk to boot into Arch normally**

## Setting Up Your System

Login as your user that you made.

#### Setup Internet Connection:
```shell
$ cd /etc/netctl/examples/
# Use ls to find which kind of connection you want
$ sudo cp /etc/netctl/examples/connection-name /etc/netctl/
$ ip link
# Don't worry about lo, remember your connection name
# Go to the created file
$ sudo vim /etc/netctl/connection-name
# Change the interface line to whatever you found from ip link
$ sudo netctl start connection-name
```

#### Update pacman
```shell
$ sudo pacman -Syu
```

#### Update Video Drivers
```shell
$ lspci -k | grep -A 2 -E "(VGA|3D)"
# this will tell you what graphics card is in use
# Use this to install the specific package
# For virtualbox:
$ sudo pacman -S virtualbox-guest-utils
```

#### Install Desktop Environment i.e. i3
```shell
$ sudo pacman -S i3 dmenu
```

#### Install terminal emulator
```shell
$ sudo pacman -S rxvt-unicode
```

#### Install Firefox
```shell
$ sudo pacman -S firefox
```

#### Install Ranger
```shell
$ sudo pacman -S ranger
```

#### Install Pacaur
```shell
$ mkdir tmp
$ cd tmp
$ sudo pacman -S expac yajl
$ curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
$ makepkg PKGBUILD --skippgpcheck --install --needed
$ curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
$ makepkg PKGBUILD --install --needed
$ cd
$ rm -r tmp
```

To Update all Official and AUR Packages:
```shell
$ pacaur -Syyu
```

## Configuring i3
```shell
$ cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

Add `exec i3` to `.xinitrc`

#### Installing Polybar
```shell
$ sudo pacman -S cairo libxcb python2 xcb-proto xcb-util-image xcb-util-wm xcb-util-xrm jsoncpp
$ pacaur -S polybar-git
```

* Copy .config files or make your own
* Copy .Xresources file or make your own

```shell
$ xrdb .Xresources
```

In the Polybar config file, change the monitor line to whatever your display is when you run `xrandr`xrdb

#### Get Fonts
```shell
$ pacaur -S noto-fonts
```

#### Setup Desktop Background
```shell
$ sudo pacman -S feh
$ feh --bg-scale (image path)
```

#### Install Vundle
```shell
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then configure the plugins in your `.vimrc`
