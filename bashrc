#!/bin/bash
echo $(clear)
#echo -e '\n\e[01;30m ▚ \e[0;30m ▞ \e[01;31m ▚ \e[0;31m ▞ \e[01;32m ▚ \e[0;32m ▞ \e[01;33m ▚ \e[0;33m ▞ \e[01;34m ▚ \e[0;34m ▞ \e[01;35m ▚ \e[0;35m ▞ \e[01;36m ▚ \e[0;36m ▞ \e[01;37m ▚ \e[0;37m ▞'

reset=$(tput sgr0)
bold=$(tput bold)

#PS1="\n\[\e[0;37m\]┌─[\[\e[0;32m\u\e[0;37m\]]──[\e[1;37m\w\e[0;37m]──[\[\e[0;32m\]${HOSTNAME%%.*}\[\e[0;37m\]]\[\e[1;35m\]: \$\[\e[0;37m\]\n\[\e[0;37m\]└────╼ \[\e[1;37m\]>> \[\e[00;00m\]"


# Visualiza los ficheros y directorios 
function cdls { cd "$1"; ls --color;}
alias cd='cdls'

export LS_OPTIONS='--color=auto'

eval "`dircolors`"
alias ls='ls $LS_OPTIONS'

# Transparencia Xterm
#[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" >/dev/null
[ -n "$XTERM_VERSION" ] && sleep .1 && transset-df -a >/dev/null

#ALIAS:
alias musica='ncmpcpp -S visualizer'
alias terminal='xrdb ~/.Xresources'
alias gestor='arch-tools.sh'
alias actualizar='pacaur -Syyu --noconfirm'
alias limpiar='sudo limpiar'
alias red='sudo systemctl restart NetworkManager'
alias sincronizar='ping -c 6 8.8.8.8'
alias swap='sudo swapon -p 32767 /dev/sdc1'
alias t=tmux
alias inter='slurm -zsi wlan0'
alias llave='~/.scripts/./llave.sh'

# MONITORS
alias monitor1='glances -1'
alias monitor2='slurm -i wlan0'
alias monitor3='vnstat -l -u -i wlan0'
alias monitor4='watch -n 1 -d free'
alias monitor5='cmatrix -bC magenta'
alias hora='tty-clock -cstDC red'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias shit='history | grep '

#export LC_ALL=es_VE.UTF-8

#	Colors:

#  BLACK=	'\e[0;30m'
#  RED=		'\e[0;31m'
#  GREEN=	'\e[0;32m'
#  YELLOW=	'\e[0;33m'
#  BLUE=	'\e[0;34m'
#  MAGENT=	'\e[0;35m'
#  CYAN=	'\e[0;36m'
#  WHITE=	'\e[0;37m'

#  LIGHTBLACK=	'\e[1;30m'
#  LIGHTRED=	'\e[1;31m'
#  LIGHTGREEN=	'\e[1;32m'
#  LIGHTYELLOW=	'\e[1;33m'
#  LIGHTBLUE=	'\e[1;34m'
#  LIGHTMAGENT= '\e[1;35m'
#  LIGHTCYAN=	'\e[1;36m'
#  LIGHTWHITE=	'\e[1;37m'

# added by Anaconda3 installer
export PATH="/home/omar/anaconda3/bin:$PATH"
export PATH="/usr/lib/python3.6/site-packages/xcbgen:$PATH"
