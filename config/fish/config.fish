# Path to Oh My Fish install.
set -x OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

function ls
    exa $argv
end

function la
    exa -la $argv
end

function code
    "/c/Program Files/Microsoft VS Code/Code.exe" $argv
end

fish_add_path $HOME/.bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.config/yarn/global/node_modules/.bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/bin
fish_add_path /usr/bin/vendor_perl

source ~/.asdf/asdf.fish

set NVIM_BIN (which nvim)

function nvim
    TERM=wezterm $NVIM_BIN $argv
end

set -x BAT_THEME ansi
set -x AWS_REGION us-east-1
set -x EDITOR (which nvim)
set -x SUDO_EDITOR (which nvim)

starship init fish | source
