export LESS="-r --jump-target=.2"

gitlogn() {
git log --graph --color --name-status --decorate=full $1 $2 $3 $4 $5 $6 $7 $8 $9
}

lll() {
    ls -lF --color $1 $2 $3 $4 $5 $6 $7 $8 $9 | less -F -r
}

ack() {
    ack-grep -k --color --heading --break --pager="less -F -r" $1 $2 $3 $4 $5 $6 $7 $8 $9
}

ghcel () {
    stack ghc --package split --verbosity error -- -e "interact $ unlines . $1 . lines"
}

ghce () {
    stack ghc --package split --verbosity error -- -e "interact $ $1"
}
