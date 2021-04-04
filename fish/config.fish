# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

#alias getkey "aws ssm get-parameters --with-decryption --name"

function getkey
  for param in $argv
    printf (aws ssm get-parameters --with-decryption --name $param | jq ".Parameters[0].Value")
  end
end

function ls
  exa $argv
end

function fd
  fdfind $argv
end

function code
  "/c/Program Files/Microsoft VS Code/Code.exe" $argv
end

#set DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
#set DISPLAY 172.23.16.1:0
if test -e ipconfig.exe
  set DISPLAY (ipconfig.exe | grep -A 10 WSL | grep IPv4 | awk '{print $14; exit;}')
end

function monitor
  echo $DISPLAY
  set -lx DISPLAY (string join ":" $DISPLAY "1")
  echo $DISPLAY
  i3
end

#function i3
  #env DISPLAY=:0 i3
#end

#alias vim="nvim"
#set -gx GOPATH $HOME/go; set -gx GOROOT $HOME/.go; set -gx PATH $GOPATH/bin $PATH; # g-install: do NOT edit, see https://github.com/stefanmaric/g

function gitiles
  set vistar_root $HOME"/vistar/vistar"

  set is_vistar_path (string match -e $vistar_root (pwd))

  if set -q is_vistar_path
    set path (string replace $vistar_root '' (pwd))
    set file_path $argv[1]

    echo "http://gerrit.vistarmedia.com/plugins/gitiles/vistar/+/develop"$path"/"$file_path
  else
    echo "Invalid path.  Must be within vistar root"
  end
end

function gitile
  set vistar_root $HOME"/vistar/vistar"

  set is_vistar_path (string match -e $vistar_root (pwd))

  if set -q is_vistar_path
    set path (string replace $vistar_root '' (pwd))
    set file_path $argv[1]

    echo "http://gerrit.vistarmedia.com/plugins/gitiles/vistar/+/develop"$path"/"$file_path
  else
    echo "Invalid path.  Must be within vistar root"
  end
end

set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/.bin
set PATH $PATH $HOME/bin
set PATH $PATH $HOME/sbt/bin

set PATH $PATH $HOME/.yarn/bin
set PATH $PATH $HOME/.config/yarn/global/node_modules/.bin

set ANDROID_HOME $HOME/.local/share/umake/android/android-sdk
#set PATH $PATH $ANDROID_HOME/emulator
set PATH $PATH $ANDROID_HOME/tools
set PATH $PATH $ANDROID_HOME/tools/bin
#set PATH $PATH $ANDROID_HOME/platform-tools

set PATH $PATH $HOME/.bin
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/squashfs-root/usr/bin

set GOPATH $HOME/gocode
set GOPATH $GOPATH "/home/alex/.asdf/installs/go/1.15.2/packages/bin"
set GOROOT $HOME/go
set PATH $PATH $GOPATH

#set -x DOCKER_HOST tcp://0.0.0.0:2375
source ~/.asdf/asdf.fish

set JAVA_HOME "/usr/lib/jvm/java-8-openjdk-amd64"

set BAT_THEME ""base16""

set AWS_REGION "us-east-1"

function amm --description 'Scala REPL'
  sh -c 'amm "$@"' amm $argv
end

function esudo
  sudo -E env "PATH=$PATH" $argv
end

function prettify
  set outputs (git diff develop --name-only | rg '\.tsx?')
  set files (for file in $outputs; echo "$PWD/$file"; end)
  bazel run //tools/prettier -- --write $files
end

function javafy
  set outputs (git diff develop --name-only | rg '\.java')
  set files (for file in $outputs; echo "$PWD/$file"; end)
  bazel run //tools/java-format -- --write $files
end

function gofy
  set outputs (git diff develop --name-only | rg '\.go')
  set files (for file in $outputs; echo "$PWD/$file"; end)
  gofmt -w $files
end

function pyfy
  set outputs (git diff develop --name-only | rg '\.py')
  set files (for file in $outputs; echo "$PWD/$file"; end)
  bazel run //tools/pyfmt -- -i $files
end
