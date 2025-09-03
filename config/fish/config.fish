fish_add_path /usr/bin/vendor_perl

set -x BAT_THEME kanagawa

fish_add_path \
  $HOME/.cargo/bin \
  $HOME/bin

mise activate fish | source

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

function nvim --wraps nvim
  set NVIM_BIN (which nvim)
  switch (uname)
  case Darwin
    TERM=xterm-ghostty $NVIM_BIN $argv
  case '*'
    TERM=wezterm $NVIM_BIN $argv
  end
end

function grep
  ggrep $argv
end

set -x EDITOR nvim
set -x SUDO_EDITOR nvim

function fish_user_key_bindings
  fish_hybrid_key_bindings
end
set fish_vi_force_cursor
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
function fish_mode_prompt; end

switch (uname)
case Darwin
  fish_add_path /opt/homebrew/bin
  eval "$(brew shellenv)"

  set -x AWS_SDK_LOAD_CONFIG 1

  # NOTE:  Currently need these to get bazel working
  set -gx LDFLAGS "-L/opt/homebrew/opt/openssl@1.1/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/openssl@1.1/include"

  set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"

  # for `gnu-sed`
  fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
  # for scala support
  fish_add_path "/Users/amanning/Library/Application Support/Coursier/bin"
end

# opam configuration
source /home/alex/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
