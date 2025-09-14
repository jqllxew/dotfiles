#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export GLFW_IM_MODULE=ibus

#if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
#    startx
#fi

