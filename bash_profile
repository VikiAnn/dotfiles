# export NVM_DIR="/Users/viki/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


export PATH=~/bin:$PATH

export EDITOR=vim
export IQ_DEV_DIR=~/work/
export IQAPP_VOLUME="rails-app-sync"
#export DOCKER_HOST=tcp://192.168.15.15:2375

# add to bash history after each command, clear history from memory, read from file
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Take you to the dir of a file in a gem. e.g. `2gem rspec`
2gem () {
  cd "$(dirname $(gem which $1))"
}

# set bash history memory size
HISTSIZE=5000
# set bash history file size
HISTFILESIZE=10000
# append history instead of overwriting the file every time
shopt -s histappend

# Git aliases
alias gs="git status"
alias gd="git diff --patience --ignore-space-change"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias ga="git add -A"
alias gh="git hist"
alias gp="git push"
alias gcm="git commit -m"
alias gpl="git pull"
alias gap="git add -p"
alias gr="git rebase"
alias oops="git commit --amend"
alias getonstaging="ssh iqapp@199.47.222.78"
alias railsc="script/dockercmd rails c"

# other aliases
alias prof="vim ~/.profile"
alias rr="rake routes"
alias rs="rails s"
alias rc="rails c"
alias vps="ssh vps"
alias w="tmux attach -t work"
alias tmx="tmux attach -t"
alias ntmx="tmux new -s"
alias restart="iqdev restart iqapp"
alias dcr="docker-compose run --rm $@"
alias dcrr="docker-compose run --rm rails $@"

# fancy ls command
# -l  long format
# -F  / after dirs, * after exe, @ after symlink
# -G  colorize
# -g suppress owner
# -o suppress group
# -h humanize sizes
# -q print nongraphic chars as question marks
alias l="ls -lFGgohq"

# configure exercism.io
if [ -f ~/.config/exercism/exercism_completion.bash ]; then
  . ~/.config/exercism/exercism_completion.bash
fi

# give the fullpaths of files passed in argv or piped through stdin
function fullpath {
  ruby -e '
    $stdin.each_line { |path| puts File.expand_path path }  if ARGV.empty?
    ARGV.each { |path| puts File.expand_path path }         unless ARGV.empty?
  ' "$@"
}

# shortcut for bundle exec
alias be="bundle exec"

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#Git tab completion
if [ -f ~/bin/git-completion.bash  ]; then
  source ~/bin/git-completion.bash
fi

# Prompt
function parse_git_branch {
  branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
  if [ "HEAD" = "$branch" ]; then
    echo "(no branch)"
  else
    echo "$branch"
  fi
}

function prompt_segment {
  # for colours: http://en.wikipedia.org/wiki/ANSI_escape_code#Colors
  # (it's still largely a mystery to me which numbers here do which things)
  # 111 seems to both impact the background color and the branch text color somehow
  # currently it makes there be no background color for the prompt text, which is what I want
  # so I'm calling it good enough ¯\_(ツ)_/¯
  if [[ ! -z "$1" ]]; then
    echo "\[\033[${2:-30};111m\]${1}\[\033[0m\]"
  fi
}

function build_mah_prompt {
  # time
  ps1="$(prompt_segment " \@ ")"

  # cwd
  ps1="${ps1} $(prompt_segment " \w ")"

  # git branch
  git_branch=`parse_git_branch`
  if [[ ! -z "$git_branch" ]]
  then
    # change the 36 to change the branch text color
    ps1="${ps1} $(prompt_segment " $git_branch " 36)"
  fi

  # next line
  ps1="${ps1} \$ "

  # set prompt output
  PS1="$ps1"
}

PROMPT_COMMAND='build_mah_prompt'
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
source ~/.bin/tmuxinator.bash

eval "$(direnv hook bash)"
eval "$(chef shell-init bash)"
eval "$(chef shell-init bash)"
export PATH="/usr/local/sbin:$PATH"

