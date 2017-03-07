export EDITOR="vim"
export LESS="-R --jump-target=.2"

# http://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

# http://unix.stackexchange.com/questions/14113/is-it-possible-to-set-gnome-terminals-title-to-userhost-for-whatever-host-i

export PS1='\[\e]0;\u@\h\a\]\[\033[38;5;240m\]${timer_show}s\[\033[00m\] $(RET=$?; if [ $RET != 0 ] ; then echo " \[\033[38;5;88m\][$RET]\[\033[00m\]"; fi ) ${debian_chroot:+($debian_chroot)}\[\e[38;5;178m\]\u\[\e[39m\]\[\e[38;5;239m\]@\[\e[39m\]\[\e[38;5;106m\]\h\[\e[39m\]\[\e[38;5;239m\]:\[\e[39m\]\[\e[38;5;34m\]\w\[\e[39m\]\n\$ '

# ls -l | less
lll() {
    ls -lF --color $1 $2 $3 $4 $5 $6 $7 $8 $9 | less -F -r
}


# TODO put these options in .ackrc?
ack() {
    ack-grep -k --color --heading --break --pager="less -r" $1 $2 $3 $4 $5 $6 $7 $8 $9
}


# execute a command for each directory below the pwd
ford() {
    for i in $(find . -maxdepth 1 -mindepth 1 -type d); do cd $i; echo -e "\n\n$i"; $* ; cd ..; done
}
