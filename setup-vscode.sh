#!/usr/bin/env bash
set -e

doing () {
  printf "\\033[33m ➜ \\033[0m $1"
}

success () {
  printf "\\033[32m ✔ \\033[0m\\n"
}

fail () {
  printf "\\n\\033[31m ✖ \\033[0m $1\\n"
  exit 1
}

# exit if macos is not found
doing "Checking system..."
if [[ $(uname) != 'Darwin' ]]; then
  fail "You are not on a mac."
else
  success
fi

doing "Looking for VSCode..."
if [[ -d "/Applications/Visual Studio Code.app" ]]; then
  fail "VSCode is already installed"
else
  success
  doing "Installing latest VSCode..."
  echo
  # get the latest VSCode
  wget -q --show-progress "https://update.code.visualstudio.com/latest/darwin/stable"
  # move cursor to end of previous line
  printf "\\033[2A\\033[31C\\033[J"
  # unzip it
  unzip stable >/dev/null
  # copy to Applications
  mv "Visual Studio Code.app" "/Applications/Visual Studio Code.app"
  # remove downloaded file
  rm stable
  success
fi

if [[ ! -h "/usr/local/bin/code" ]]; then
  doing "Linking \\033[36m code \\033[0m binary..."
  # Equivalent of VS [gui] Command Palette  "Shell command: Install 'code' command in PATH"
  ln -sf /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code
  success
fi

# Install vscode extensions
doing "Installing VSCode extensions..."
plugins=( \
aaron-bond.better-comments \
christian-kohler.npm-intellisense \
christian-kohler.path-intellisense \
CoenraadS.bracket-pair-colorizer \
dbaeumer.vscode-eslint \
EditorConfig.EditorConfig \
esbenp.prettier-vscode \
jasonnutter.search-node-modules \
jpoissonnier.vscode-styled-components \
kamikillerto.vscode-colorize \
kisstkondoros.vscode-gutter-preview \
oderwat.indent-rainbow \
pawelgrzybek.gatito-theme \
PKief.material-icon-theme \
pnp.polacode \
robertohuertasm.vscode-icons \
spywhere.guides \
yzhang.markdown-all-in-one \
)
echo
for plugin in ${plugins[*]};
do
  printf "\\033[2m      Installing %s\\033[0m" "$plugin"
  code --install-extension "$plugin" >/dev/null
  # clear current line
  printf "\\r\\033[K"
done
# move cursor to end of previous line
printf "\\033[1A\\033[35C"
success
