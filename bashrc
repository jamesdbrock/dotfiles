export EDITOR="vim"
export LESS="-R --jump-target=.2"

# export PS1='$(RET=$?; if [ $RET != 0 ] ; then echo "\[\033[01;32m\]return\[\033[00m\] $RET"; fi )\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

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

export PS1='${timer_show}s $(RET=$?; if [ $RET != 0 ] ; then echo "\[\033[01;32m\]return\[\033[00m\] $RET"; fi )\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


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
