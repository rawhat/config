# Path to Oh My Fish install.
set -x OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

fish_add_path /usr/bin/vendor_perl

set -x BAT_THEME ansi
set -x AWS_REGION us-east-1

set fish_user_paths \
  $HOME/.bin \
  $HOME/.cargo/bin \
  $HOME/.config/yarn/global/node_modules/.bin \
  $HOME/.local/bin \
  $HOME/.yarn/bin \
  $HOME/bin

source $HOME/.asdf/asdf.fish

set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showcolorhints yes
set __fish_git_prompt_showupstream informative

set __fish_git_prompt_color_branch magenta
set __fish_git_prompt_color magenta
set __fish_git_prompt_color_flags red

set __fish_git_prompt_char_dirtystate '!'
set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_char_untrackedfiles '?'
set __fish_git_prompt_char_upstream_ahead '⇡ '
set __fish_git_prompt_char_upstream_behind '⇣ '

function fish_right_prompt -d "Write out the right prompt"
end

function fish_prompt -d "Write out the prompt"
  set laststatus $status

  if test -n $hostname
    printf '%s%s%s ' \
      (set_color green) (echo $hostname) (set_color normal)
  else
    printf '%s%s%s ' \
      (set_color green) (echo $USER) (set_color normal)
  end

  printf '%s%s%s' \
    (set_color cyan) (echo $PWD | sed -e "s|^$HOME|~|") (set_color normal)

  set gitprompt (fish_git_prompt)
  if test -n $gitprompt
    printf '%s' \
      (fish_git_prompt)
  end

  if test $laststatus -eq 0
    printf " %sγ " (set_color normal)
  else
    printf " %sγ %s" (set_color red) (set_color normal)
  end
end

function ls
    exa $argv
end

function la
    exa -la $argv
end

function code
    "/c/Program Files/Microsoft VS Code/Code.exe" $argv
end

set NVIM_BIN (which nvim)
set -x EDITOR $NVIM_BIN
set -x SUDO_EDITOR $NVIM_BIN

function nvim
    TERM=wezterm $NVIM_BIN $argv
end
