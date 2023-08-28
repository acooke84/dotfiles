case $- in
   *i*) ;;
     *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

export CLICOLOR=1

blk='\[\e[0;30m\]' # Black
red='\[\e[0;31m\]' # Red
grn='\[\e[0;32m\]' # Green
ylw='\[\e[0;33m\]' # Yellow
blu='\[\e[0;34m\]' # Blue
pur='\[\e[0;35m\]' # Purple
cyn='\[\e[0;36m\]' # Cyan
wht='\[\e[0;37m\]' # White

Bblk='\[\e[1;30m\]' # Black
Bred='\[\e[1;31m\]' # Red
Bgrn='\[\e[1;32m\]' # Green
Bylw='\[\e[1;33m\]' # Yellow
Bblu='\[\e[1;34m\]' # Blue
Bpur='\[\e[1;35m\]' # Purple
Bcyn='\[\e[1;36m\]' # Cyan
Bwht='\[\e[1;37m\]' # White

clr='\[\e[0;00m\]' # Reset

git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function prompt_defaults ()
{
   SSH_TTY=${SSH_TTY:-`tty 2>/dev/null||readlink /proc/$$/fd/0 2>/dev/null`}

   PS1=${ylw}'\w'${pur}'$(git_branch)'${clr}' \\$ ';

   export PS1 SSH_TTY
}

prompt_defaults


if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
