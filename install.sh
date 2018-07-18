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
mv ~/.config/polybar ~/dotfiles_old/
#rm -r ~/.config/polybar
mkdir ~/.config/polybar 
echo -e "Copying ${LBLUE}polybar${NC} files into ~/.config/polybar"
cp polybar/* ~/.config/polybar/


printf "${LRED}-------------------------------------------\n"
printf "${YELLOW} WELL DONE! \n ${CYAN}THE TARDIS MATRIX HAS BEEN UPDATED! \n THIS LAPTOP CAN'T BE IN BETTER HANDS \n"
printf "${LRED}-------------------------------------------\n"
#echo "-------------------------------------------"
#printf "I ${RED}love${NC} Stack Overflow\n"
#echo "WELL DONE! THE TARDIS MATRIX HAS BEEN UPDATED!"
#echo "THIS LAPTOP CAN'T BE IN BETTER HANDS!"
#echo "-------------------------------------------"
