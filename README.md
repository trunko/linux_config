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
1. Leave space for linux swap, where the size should be the same as your RAM, preferably double
1. Write, then type yes and quit

## Making a filesystem
```shell
$ mkfs.ext4 /dev/sda1
# do this for all main filesystems
$ mount /dev/sda1 /mnt
# if you have a seperate partition for home:
$ mkdir /mnt/home
$ mount /dev/sda3 /mnt/home
```

#### Make sure you are connected to the internet
```shell
$ ping -c 3 google.com
```

For wireless connections:
```shell
$ cp /etc/netctl/examples/your-connection-type /etc/netctl/wireless-name
# open your connection and change the information for your connection
# use `ip link` to find your interface name
$ netctl start wireless-name
```

## Install Arch

```shell
$ pacstrap -i /mnt base
```

```shell
$ genfstab -U -p /mnt >> /mnt/etc/fstab
```

#### Access mount point
```shell
$ arch-chroot /mnt
```

#### Install Packages
```shell
$ pacman -S openssh grub-bios linux-headers linux-lts linux-lts-headers neovim sudo git
# for wireless connections
$ pacman -S wpa_supplicant wireless_tools
```

#### Create Root Password
```shell
$ passwd
```

#### Locale-gen
```shell
$ vim /etc/locale.gen
# Uncomment appropriate line i.e. en_US...
$ locale-gen
```

#### Setting Time Zone
Find region using `ls /usr/share/zoneinfo/`
Then `ls` into that region and find your zone
```shell
$ ln -s /usr/share/zoneinfo/US/Central /etc/localtime
$ hwclock --systohc --utc
```

#### Enable SSH
```shell
$ systemctl enable sshd.service
```

#### Create a Host Name
```shell
$ hostnamectl set-hostname arch
```

#### Create a New User
```shell
$ useradd -m -G wheel -s /bin/bash (username)
$ passwd (username)
```

#### Give Your User `sudo` Access
```shell
$ visudo
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
$ grub-install --target=i386-pc --recheck /dev/sda
# use the --force tag if using a vm
$ cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
$ grub-mkconfig -o /boot/grub/grub.cfg
$ exit
$ umount /mnt/home
$ umount /mnt
```

**At this point, remove the disk to boot into Arch normally**

## Setting Up Your System

Login as your user that you made.

#### Update Locale
```shell
$ localectl set-locale LANG="en_US.UTF-8"
```

#### Enable swap space
```shell
$ mkswap /dev/sda2
# Remember the UUID
$ vim /etc/fstab
# add at the bottom:
# UUID=YOUR_UUID    none    swap    defaults    0 0
# On the / and /home directories, add "discard," after rw if you have an SSD
```

#### If using ethernet
```shell
$ dhcpcd
```

**Redo the wireless setup if not connected if using wifi**

#### Update pacman
```shell
$ sudo pacman -Syu
```

#### Finish Setting up Internet
```shell
$ pacman -S networkmanager network-manager-applet wireless_tools wpa_supplicant wpa_actiond dialog
```

#### Install XWindow
```shell
$ pacman -S xf86-input-libinput xorg-server xorg-xinit xorg-server-utils mesa

#### Update Video Drivers
```shell
$ lspci
# this will tell you what graphics card is in use
# Use this to install the specific package
# For virtualbox:
$ sudo pacman -S virtualbox-guest-utils
# For Nvidia:
$ pacman -S xf86-video-nouveau
# For Nvidia with better performance:
$ pacman -S nvidia
# For Intel:
$ pacman -S xf86-video-intel
```

#### Install Desktop Environment i.e. BSPWM
```shell
$ sudo pacman -S bspwm sxhkd dmenu
```

#### Install terminal emulator
```shell
$ sudo pacman -S termite
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

In the Polybar config file, change the monitor line to whatever your display is when you run `xrandr`

#### Get Fonts
```shell
$ pacaur -S ttf-hack
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

Then configure the plugins for vim or nvim.

#### In case of key unavailable for AUR
```shell
$ gpg --recv-key key
```
