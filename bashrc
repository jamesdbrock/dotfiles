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

# http://www.joachim-breitner.de/blog/156-Haskell_on_the_Command_Line

# example: split on commas and select the 0th and 3rd columns
# echo "a,b,c,d,e,f" | ghcel 'unwords . flip fmap [0,3] . (!!)  . splitOn ","'
#
# example: name the argument
# echo "hello" | ghce '\x -> sort x'
ghcel () {
    stack ghc --package split --verbosity error -- -e "interact $ unlines . fmap ( $* ) . lines"
}

ghce () {
    stack ghc --package split --verbosity error -- -e "interact $ $*"
}
