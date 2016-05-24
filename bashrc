export EDITOR="vim"
export LESS="-r --jump-target=.2"

export PS1='$(RET=$?; if [ $RET != 0 ] ; then echo "\[\033[01;32m\]return\[\033[00m\] $RET"; fi )\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# gitlogn() {
# git log --graph --color --name-status --decorate=full $1 $2 $3 $4 $5 $6 $7 $8 $9
# }

lll() {
    ls -lF --color $1 $2 $3 $4 $5 $6 $7 $8 $9 | less -F -r
}

ack() {
    ack-grep -k --color --heading --break --pager="less -F -r" $1 $2 $3 $4 $5 $6 $7 $8 $9
}

# http://www.joachim-breitner.de/blog/156-Haskell_on_the_Command_Line

# apply function to entire stream
# example: name the argument
# echo "hello" | ghce '\x -> sort x'
ghce () {
    stack ghc --package split --verbosity error -- -e "interact ( $* )"
}

# apply function to lines
# from column 4 of passwd, show entries which contain an uppercase and don't contain a comma and consist of exactly two words
# cat /etc/passwd | ghcel 'filter ((==2).length.words) . '"filter (not.any (==','))"'. filter (any isUpper) . fmap ((!!4) . splitOn ":")'
ghcel () {
    stack ghc --package split --verbosity error -- -e "interact $ unlines . ( $* ) . lines"
}

# fmap function to lines
# example: split on commas and select the 0th and 3rd columns
# echo "a,b,c,d,e,f" | ghcelf 'unwords . flip fmap [0,3] . (!!)  . splitOn ","'
ghcelf () {
    stack ghc --package split --verbosity error -- -e "interact $ unlines . fmap ( $* ) . lines"
}

