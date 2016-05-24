export EDITOR="vim"
export LESS="-r --jump-target=.2"

export PS1='$(RET=$?; if [ $RET != 0 ] ; then echo "\[\033[01;32m\]return\[\033[00m\] $RET"; fi )\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

lll() {
    ls -lF --color $1 $2 $3 $4 $5 $6 $7 $8 $9 | less -F -r
}

ack() {
    ack-grep -k --color --heading --break --pager="less -F -r" $1 $2 $3 $4 $5 $6 $7 $8 $9
}

