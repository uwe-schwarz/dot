# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '~/.zshrc'
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit bashcompinit
compinit -u
bashcompinit

# history
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
# history searching by up/down key, thanks to https://github.com/graysky2/configs/tree/master/dotfiles
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

setopt APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST EXTENDED_HISTORY

# options
setopt autocd extendedglob notify BRACE_CCL
bindkey -e

# stop at / with C-w
WORDCHARS="${WORDCHARS//\//}"

# add some colors
if [ "$(uname)" != "Darwin" ]; then
    alias ls='ls --group-directories-first --color'
fi
alias grep='grep --color=auto'
alias zgrep='zgrep --color=auto'
autoload -U colors && colors

# gitstatus https://github.com/olivierverdier/zsh-git-prompt
source ~/.zsh/git-prompt/zshrc.sh

PROMPT='$(git_super_status)[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m %{$fg_bold[yellow]%}%~%{$reset_color%} $'

# syntax highlighting
source ~/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh

# work
[ -f ~/.zshrc.work ] && source ~/.zshrc.work

# locale
export LC_ALL="en_US.UTF-8"

# aliases
alias takeover="tmux detach -a"
if whence pbcopy >/dev/null; then
    alias pwrandom="curl -s 'https://www.random.org/passwords/?num=1&len=15&format=plain&rnd=new' | sed 's/.../&-/g;s/-$//' | tr -d '\n' | pbcopy; pbpaste; echo"
else
    alias pwrandom="curl -s 'https://www.random.org/passwords/?num=1&len=15&format=plain&rnd=new' | sed 's/.../&-/g;s/-$//'"
fi
alias jen="gcloud compute ssh --zone "us-central1-b" jen"
alias ytdl="youtube-dl --restrict-filenames -o '%(series)s.S%(season_number)02dE%(episode_number)02d.%(title)s.%(height)dp.%(ext)s'"
