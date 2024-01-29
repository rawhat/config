fish_add_path /usr/bin/vendor_perl

set -x BAT_THEME Coldark-Dark
set -x AWS_REGION us-east-1

set fish_user_paths \
  $HOME/.bin \
  $HOME/.cargo/bin \
  $HOME/.config/yarn/global/node_modules/.bin \
  $HOME/.local/bin \
  $HOME/.yarn/bin \
  $HOME/bin

mise activate fish | source

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

function fish_mode_symbol
  switch $fish_bind_mode
    case default
      echo 'η'
    case insert
      echo 'δ'
    case replace_one
      echo 'Γ'
    case visual
      echo 'ν'
    case '*'
      echo 'γ'
  end
end

function fish_right_prompt -d "Write out the right prompt"
end

function git_prompt
  set -l git_status_origin (command git status -s -b 2> /dev/null)
  printf ''

  set -l is_repo (string join0 $git_status_origin)

  if test -z $is_repo
    # git status returns error (not a git repo)
    printf ''
  else
    echo $git_status_origin | string match --regex '\[.*ahead.*\]' --quiet
    set -l ahead $status
    echo $git_status_origin | string match --regex '\[.*behind.*\]' --quiet
    set -l behind $status
    set -l branch (echo $git_status_origin | string replace -r  '## ([\S]+).*' '$1' | string replace -r '(.+)\.\.\..*' '$1')

    # simply check for modified/deleted/rename, match only 1
    echo $git_status_origin | string match --regex '[MDR ][MDR ] .*' --quiet
    set -l git_dirty $status

    # simply check for ?? in the list of files, match only 1
    echo $git_status_origin | string match --regex '\?\? .*' --quiet
    set -l git_untracked $status

    if test "$git_dirty" -eq 0
      printf ' (%s%s' (set_color red)
    else
      printf ' (%s%s' (set_color yellow)
    end

    # Use branch name if available
    if test -n "$branch"
      printf $branch
    else
      # for new branch, git branch will return nothing, use branch name from git status
      set -l git_status_no_commits_branch (echo $git_status_origin | string replace '## No commits yet on ' '')
      printf $git_status_no_commits_branch
    end

    if test "$git_untracked" -eq 0
      printf '%s*' (set_color purple)
    end

    if test -s .git/refs/stash # stash exists - check on .git/refs/stash file
      printf '%s$' (set_color green)
    end

    # if local repo is ahead, show up arrow
    if test "$ahead" -eq 0
      printf '%s↑' (set_color cyan)
    end

    # if local repo is behind, show down arrow
    if test "$behind" -eq 0
      printf '%s↓' (set_color magenta)
    end
    printf '%s)' (set_color normal)
  end
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

  printf '%s' (git_prompt)

  if test $laststatus -eq 0
    printf " %s%s " (set_color normal) (fish_mode_symbol)
  else
    printf " %s%s %s" (set_color red) (fish_mode_symbol) (set_color normal)
  end
end

function ls --wraps ls
    eza $argv
end

function la --wraps ls
    eza -la $argv
end

set NVIM_BIN (which nvim)
set -x EDITOR $NVIM_BIN
set -x SUDO_EDITOR $NVIM_BIN

function nvim --wraps nvim
  TERM=wezterm $NVIM_BIN $argv
end

fish_hybrid_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
function fish_mode_prompt; end

switch (uname)
case Darwin
  eval "$(/opt/homebrew/bin/brew shellenv)"
end
