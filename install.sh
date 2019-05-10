#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LBLUE='\033[1;34m'
LPURPLE='\033[1;35m'
LCYAN='\033[1;36m'
WHITE='\033[1;37m'

NC='\033[0m' # No Color
#printf "I ${RED}love${NC} Stack Overflow\n"

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bash_profile bashrc bash_aliases i3blocks.conf zshrc xinitrc Xmodmap Xresources vimrc compton.conf conky.conf"    # list of files/folders to symlink in homedir
files_config="i3 onedrive polybar dunst"
pkg="pkglist aur_pkglist conda_pkglist"
##########

# create dotfiles_old in homedir
echo -e "Creating ${YELLOW}$olddir${NC} for backup of any existing dotfiles in ~"
if [ -d $olddir ]; then
	rm -r $olddir
fi
mkdir -p $olddir

# change to the dotfiles directory
echo -e "Changing to the ${YELLOW}$dir ${NC} directory"
cd $dir

# moving any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
	if [ -f ~/.$file ]; then
		echo -e "Moving ${LBLUE}$file${NC}  from ~ to $olddir"
	 	cp ~/.$file $olddir/$file
		rm ~/.$file
	else
		echo -e "file ${LBLUE}$file${NC} does not exist in ~"
	fi
	if [ -f $dir/$file ]; then
		echo -e "Creating symlink of ${LBLUE}$file${NC} in home directory."
	 	ln -s $dir/$file ~/.$file
	else
		echo -e "directory ${LBLUE}$file${NC} does not exist in $dir"
	fi
done

# moving any existing config files in homedir to dotfiles_old directory, then create symlink
for i in $files_config; do
	if [ -d ~/.config/$i ]; then
  	echo -e "Moving ${YELLOW}$i${NC} to $olddir"
		mkdir $olddir/$i
  	cp -a ~/.config/$i/* $olddir/$i/
  	rm -r ~/.config/$i
	else
		echo -e "directory ${LBLUE}$i${NC} does not exist in ~/.config/"
	fi

	if [ -d $dir/$i ]; then
  	echo -e "Creating symlink of ${LBLUE}$i${NC}"
  	ln -s $dir/$i ~/.config/$i
	else
		echo -e "directory ${LBLUE}$i${NC} does not exist in $dir"
	fi

done


#echo -e "Moving ${YELLOW}polybar and dunst${NC} to $olddir"
#rm -r ~/dotfiles_old/polybar
#rm -r ~/dotfiles_old/dunst
#mv ~/.config/polybar ~/dotfiles_old/
#mv ~/.config/dunst ~/dotfiles_old/
#mkdir ~/.config/polybar
#mkdir ~/.config/dunst
#echo -e "Copying ${LBLUE}polybar and dunst${NC} files to ~/.config/polybar and ~/.config/dunst"
#cp $dir/polybar/* ~/.config/polybar/
#cp $dir/dunst/* ~/.config/dunst/

for i in $pkg; do
	if [ -f $dir/$i ]; then
    echo -e "backing ${LBLUE}$i${NC} to $olddir"
    mv $dir/$i $olddir
	else
    echo -e "file ${LBLUE}$i${NC} does not exist in $dir."
	fi
done

echo -e "Creating the ${LBLUE}pkglist${NC} file"
pacman -Qqe | grep -v "$(pacman -Qmq)" > pkglist

echo -e "Creating the ${LBLUE}AUR pkglist${NC} file"
pacman -Qmq > aur_pkglist

echo -e "Creating the ${LBLUE}conda_pkglist${NC} file"
conda list --explicit omar > conda_pkglist

thunder_dir=~/OneDrive/lite_backups/thunderbird
echo -e "backing up ${LBLUE}THUNDERBIRD${NC} directory at $thunder_dir"
if [ -d "$thunder_dir" ]; then
    rm -rf $thunder_dir
    cp -r ~/.thunderbird ~/OneDrive/lite_backups
else
    cp -r ~/.thunderbird ~/OneDrive/lite_backups
fi

echo -e "backing ${LBLUE}install.sh${NC} to $olddir"
cp $dir/install.sh $olddir

printf "${LRED}-------------------------------------------\n"
printf "${YELLOW} WELL DONE! \n ${CYAN}THE TARDIS MATRIX HAS BEEN UPDATED! \n THIS LAPTOP CAN'T BE IN BETTER HANDS \n"
printf "${LRED}-------------------------------------------\n"

printf "${LRED}-------------------------------------------\n"
printf "${YELLOW} Don't forget: \n ${CYAN} git add \n  git commit \n  git push \n"
printf "${LRED}-------------------------------------------\n"
