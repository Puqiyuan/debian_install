git clone https://github.com/Puqiyuan/debian_install.git
cd debian_install
echo =========================================================
echo = Part1, Install software and upgrade system            =
echo =========================================================
echo
echo "Please input root password:"
su
dhclient enp1s0
cp sources.list /etc/apt/sources.list
apt update
apt dist-upgrade
exit
apt intall `cat laptop`


echo ========================================================
echo = Part2, Configure                                     =
echo ========================================================
echo
read -p "your username: " username
echo "Please input root password:"
su
echo "$username  ALL = NOPASSWD: ALL" >> $username
cp $username etc/sudoers.d/$username
chmod 0440 /etc/sudoers.d/$username
exit
cd
git clone http://cs2.swfu.edu.cn/~wx672/dotfile/.git
cd
rm -f .bash*
ln -sf dotfile/dot.* .
ln -sf dotfile/help/dot.* .
rename 's/dot//' dot.*
wget -O .keys.png http://cs2.swfu.edu.cn/~wx672/tex-fun/keys/keys-1.png
cd
wget http://cs2.swfu.edu.cn/~wx672/debian-install/elpa.tgz
mv elpa.tgz ~/.emacs.d/
cd ~/.emacs.d
tar zxf elpa.tgz
sudo cp -r ~/dotfile/etc/systemd/system/getty@tty1.service.d/ /etc/systemd/system/
sudo nano /etc/systemd/system/getty@tty1.service.d/override.conf
sudo sed -i "s/wx672/$username/g" /etc/systemd/system/getty@tty1.service.d/override.conf
echo "Please select en_US.UTF-8 UTF-8, zh_CN.GB18030 GB18030, zh_CN.UTF-8 UTF-8"
sudo dpkg-reconfigure locales
sudo cp ~/dotfile/etc/default/locale /etc/default
sudo cp ~/dotfile/etc/default/keyboard /etc/default
echo "Please select shift method"
fcitx-configtool
sudo apt install dbus-x11
wget http://cs2.swfu.edu.cn/~wx672/debian-install/list.texlive
sudo apt install `cat list.texlive`
