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
akamud.vscode-theme-onedark \
anseki.vscode-color \
be5invis.vscode-custom-css \
bierner.markdown-checkbox \
bierner.markdown-emoji \
bierner.markdown-preview-github-styles \
christian-kohler.npm-intellisense \
christian-kohler.path-intellisense \
CoenraadS.bracket-pair-colorizer \
DavidAnson.vscode-markdownlint \
dbaeumer.vscode-eslint \
dkundel.vscode-npm-source \
eamodio.gitlens \
ecmel.vscode-html-css \
EditorConfig.EditorConfig \
eg2.vscode-npm-script \
Equinusocio.vsc-material-theme \
esbenp.prettier-vscode \
formulahendry.auto-close-tag \
formulahendry.auto-rename-tag \
HookyQR.beautify \
jasonnutter.search-node-modules \
jpoissonnier.vscode-styled-components \
kamikillerto.vscode-colorize \
kevinkyang.auto-comment-blocks \
kisstkondoros.vscode-gutter-preview \
msjsdiag.debugger-for-chrome \
oderwat.indent-rainbow \
pawelgrzybek.gatito-theme \
PKief.material-icon-theme \
pnp.polacode \
pranaygp.vscode-css-peek \
robertohuertasm.vscode-icons \
sdras.night-owl \
Shan.code-settings-sync \
shinnn.stylelint \
spywhere.guides \
stkb.rewrap \
streetsidesoftware.code-spell-checker \
sveggiani.vscode-field-lights \
teabyii.ayu \
wayou.vscode-todo-highlight \
wesbos.theme-cobalt2 \
whizkydee.material-palenight-theme \
wix.vscode-import-cost \
xabikos.JavaScriptSnippets \
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
