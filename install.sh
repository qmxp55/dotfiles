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
files="bash_profile bashrc i3blocks.conf zshrc xinitrc Xmodmap Xresources vimrc compton.conf conky.conf"    # list of files/folders to symlink in homedir
files_config="i3 onedrive" 
##########

# create dotfiles_old in homedir
echo -e "Creating ${YELLOW}$olddir${NC} for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo -e "${RED}...done${NC} "

# change to the dotfiles directory
echo -e "Changing to the ${YELLOW}$dir ${NC} directory"
cd $dir
echo -e "${RED}...done${NC}" 

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
	 echo -e "Moving ${LBLUE}$file${NC}  from ~ to $olddir"
	 mv ~/.$file ~/dotfiles_old/
	 echo -e "Creating symlink to ${LBLUE}$file${NC}  in home directory."
	 ln -s $dir/$file ~/.$file
done

for file_config in $files_config; do
  echo -e "Moving ${YELLOW}$file_config${NC} to $olddir"
  mv ~/.config/$file_config/config ~/dotfiles_old/$file_config
  rm -r ~/.config/$file_config
  mkdir -p ~/.config/$file_config
  echo -e "Creating symlink of ${LBLUE}$file_config${NC}"
  ln -s $dir/$file_config ~/.config/$file_config/config
done


echo -e "Moving ${YELLOW}polybar${NC} to $olddir"
rm -r ~/dotfiles_old/polybar
#rm -r ~/dotfiles_old/ssh
mv ~/.config/polybar ~/dotfiles_old/
#mv ~/.ssh ~/dotfiles_old/ssh
#rm -r ~/.config/polybar
mkdir ~/.config/polybar 
#mkdir ~/.ssh
echo -e "Copying ${LBLUE}polybar and SSH${NC} files into ~/.config/polybar"
cp polybar/* ~/.config/polybar/
#cp ssh/* ~/.ssh/


if [ -f pkglist ]; then
    echo -e "backing ${LBLUE}pkglist${NC} to $olddir"
    mv pkglist $olddir
else
    echo -e "file ${LBLUE}pkglist${NC} does not exist."
fi

if [ -f aur_pkglist ]; then
    echo -e "backing ${LBLUE}AUR pkglist${NC} to $olddir"
    mv aur_pkglist $olddir
else
    echo -e "file ${LBLUE}aur_pkglist${NC} does not exist."
fi




echo -e "Creating the ${LBLUE}pkglist${NC} file"
pacman -Qqe | grep -v "$(pacman -Qmq)" > pkglist


echo -e "Creating the ${LBLUE}AUR pkglist${NC} file"
pacman -Qmq > aur_pkglist

thunder_dir=~/OneDrive/lite_backups/thunderbird 
echo -e "backing up ${LBLUE}THUNDERBIRD${NC} directory at $thunder_dir"
if [ -d "$thunder_dir" ]; then
    rm -rf $thunder_dir
    cp -r ~/.thunderbird ~/OneDrive/lite_backups
else
    cp -r ~/.thunderbird ~/OneDrive/lite_backups
fi

printf "${LRED}-------------------------------------------\n"
printf "${YELLOW} WELL DONE! \n ${CYAN}THE TARDIS MATRIX HAS BEEN UPDATED! \n THIS LAPTOP CAN'T BE IN BETTER HANDS \n"
printf "${LRED}-------------------------------------------\n"

printf "${LRED}-------------------------------------------\n"
printf "${YELLOW} Don't forget: \n ${CYAN} git add \n git commit \n git push \n"
printf "${LRED}-------------------------------------------\n"
