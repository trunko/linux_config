# Setting Up Archlinux

Referencing the official wiki setup guide [here](https://wiki.archlinux.org/index.php/installation_guide).

## Partitioning the Disks

#### Look at all the disks
```shell
$ fdisk -l
```

Find the drive to install to, probably in the form `sda`.

#### Once the correct drive is found:
```shell
$ cfdisk /dev/sda
# Where sda is the disk to format
```

#### From there:
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

#### Update Mirrors if Necessary
```shell
$ mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
$ rankmirrors /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
```

#### Install Base Packages
```shell
$ pacstrap -i /mnt base base-devel
```

#### Generate Filesystem Tab
```shell
$ genfstab -U -p /mnt >> /mnt/etc/fstab
```

#### Access mount point
```shell
$ arch-chroot /mnt
```

#### Install Packages
```shell
$ pacman -S openssh sudo neovim grub-bios linux-headers linux-lts linux-lts-headers git
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
$ echo arch > /etc/hostname
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
$ mkinitcpio -p linux
$ grub-mkconfig -o /boot/grub/grub.cfg
$ exit
$ umount /mnt/home
$ umount /mnt
```

**At this point, remove the disk to boot into Arch normally**

## Setting Up Your System

Login as your user that you made.

#### Update Locale if Necessary
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
# or you can use swapon /dev/sda2
```

#### Finish Setting up Internet
```shell
$ pacman -S networkmanager network-manager-applet wireless_tools wpa_supplicant wpa_actiond dialog
$ systemctl enable NetworkManager.service
# Network Manager Command Line Interface
$ nmcli
# Network Manager Terminal User Interface
$ nmtui
```

#### Update pacman
```shell
$ sudo pacman -Syu
```

#### Install X Window
```shell
$ pacman -S xf86-input-libinput xorg xorg-server xorg-xinit xorg-apps alsa-utils mesa

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
$ sudo pacman -S bspwm sxhkd
```

#### Install Display Manager
```shell
$ sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
```

#### Install terminal emulator
```shell
$ sudo pacman -S termite
```

#### Install Other Stuff Necessary
```shell
$ sudo pacman -S firefox ranger vlc 
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
$ pacaur -S ttf-hack ttf-font-awesome-4
```

#### Get And Install Mouse Pointer
```shell
$ pacaur -S breeze-default-cursor-theme
$ sudo cp .icons/default/index.theme /usr/share/icons/default/index.theme
```

#### Get Dmenu 2
```shell
$ pacaur -S dmenu2
```

#### Setup Desktop Background
```shell
$ sudo pacman -S feh
# Scale Background
$ feh --bg-scale (image path)
# Tile Background
$ feh --bg-tile (image path)
```

#### Install Vundle
```shell
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then configure the plugins for vim or nvim with `:PluginInstall` or `PluginUpdate`

#### In case of key unavailable for AUR
```shell
$ gpg --recv-key key
```

#### Pacman / Pacaur Commands
```shell
# Install
$ pacman -S package-name
$ pacaur -S package-name
# Update Official
$ pacman -Syu
# Update Official and AUR
$ pacaur -Syyu
# Remove Package With Unused Dependencies
$ pacman -Rns package-name
$ pacaur -Rns package-name
# List Orphan Packages
$ pacman -Qtd
# Recursively Remove Orphan Packages
$ pacman -Rns $(pacman -Qtdq)
# List Foreign Packages
$ pacman -Qm
```

#### Maintinence
```shell
$ sudo pacman -S rmlint
```
A script that scans the current directory or some path with `rmlint`.
Generates a file `rmlint.sh` that you can run to remove suspicious files.
Edit if necessary to keep some stuff.
