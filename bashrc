export EDITOR="nvim"
export LESS="-R --jump-target=.2"

# http://askubuntu.com/questions/339546/how-do-i-see-the-history-of-the-commands-i-have-run-in-tmux
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups
# append history entries..
shopt -s histappend
# After each command, save and reload history
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# http://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt
# https://github.com/jichu4n/bash-command-timer/blob/master/bash_command_timer.sh
# https://seasonofcode.com/posts/debug-trap-and-prompt_command-in-bash.html

# function timer_start {
#   if [ -n "$timer_at_prompt" ]; then
#     unset timer_at_prompt
#     return
#   fi
#   timer=${timer:-$SECONDS}
# }
# 
# function timer_stop {
#   timer_at_prompt=1
#   if [ -n "$timer" ]; then
#     time_elapsed=$(($SECONDS - $timer))
#     if [ $time_elapsed -gt 3 ]; then
#       timer_show="${time_elapsed}s\n"
#     else
#       timer_show=""
#     fi
#     unset timer
#   fi
# }

# trap 'timer_start' DEBUG
# export PROMPT_COMMAND="timer_stop; $PROMPT_COMMAND"

# http://unix.stackexchange.com/questions/14113/is-it-possible-to-set-gnome-terminals-title-to-userhost-for-whatever-host-i

# why isn't errorrender working?
terminaltitle='\[\e[48;5;234m\]\[\e]0;\u  \h  ${PWD}\a\]'
# timerrender='\[\033[38;5;240m\]${timer_show}'
errorrender='$(RET=$?; if [ $RET != 0 ] ; then echo -e "\[\033[38;5;88m\][$RET]\n"; fi )'
export PS1=\
"${terminaltitle}"\
"${errorrender}"\
'${debian_chroot:+($debian_chroot)}\[\e[38;5;142m\]\u'\
'\[\e[38;5;242m\]@'\
'\[\e[38;5;214m\]\h'\
'\[\e[38;5;242m\]:'\
'\[\e[38;5;151m\]\w '\
'\[\e[0m\]\[\e[38;5;234m\]'\
'\[\e[0m\]\n'\
'\$\[\e[0m\] '


# ls -l | less
lll() {
    ls -lF --color $1 $2 $3 $4 $5 $6 $7 $8 $9 | less -F -r
}


# # execute a command for each directory below the pwd
# ford() {
#     for i in $(find . -maxdepth 1 -mindepth 1 -type d); do cd $i; echo -e "\n\n$i"; $* ; cd ..; done
# }

# disable terminal freeze Ctrl-s
stty -ixon

# export LANG=C.UTF-8
# export LANGUAGE=C.UTF-8
# https://michael.stapelberg.de/Artikel/locales
# export LANG=en_US.utf8
# export LANGUAGE=en_US:en
# export LC_CTYPE=en_US.utf8
# export LC_NUMERIC=en_US.utf8
# export LC_TIME=ja_JP.utf8
# export LC_TIME=ja_JP.utf8
# export LC_COLLATE=en_US.utf8
# export LC_MONETARY=en_US.utf8
# export LC_MESSAGES=C.UTF-8
# export LC_PAPER=en_US.utf8
# export LC_NAME=en_US.utf8
# export LC_ADDRESS=en_US.utf8
# export LC_TELEPHONE=en_US.utf8
# export LC_MEASUREMENT=en_US.utf8
# export LC_IDENTIFICATION=en_US.utf8
# export LC_ALL=en_US.utf8

# unset LANG
# unset LC_CTYPE
# unset LC_NUMERIC
# unset LC_COLLATE
# unset LC_MONETARY
# unset LC_MESSAGES
# unset LC_PAPER
# unset LC_NAME
# unset LC_ADDRESS
# unset LC_TELEPHONE
# unset LC_MEASUREMENT
# unset LC_IDENTIFICATION
# unset LC_ALL
