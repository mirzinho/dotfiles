#!/usr/bin/env bash

# Install latest static tmux
sudo curl -L https://github.com/axonasif/build-static-tmux/releases/latest/download/tmux.linux-amd64.stripped -o /usr/bin/tmux
sudo chmod +x /usr/bin/tmux

current_dir="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
dotfiles_source="${current_dir}/home_files"
# Symlink dotfiles
while read -r file; do

    relative_file_path="${file#"${dotfiles_source}"/}"
    target_file="${HOME}/${relative_file_path}"
    target_dir="${target_file%/*}"

    if test ! -d "${target_dir}"; then
        mkdir -p "${target_dir}"
    fi

    printf 'Installing dotfiles symlink %s\n' "${target_file}"
    ln -sf "${file}" "${target_file}"

done < <(find "${dotfiles_source}" -type f)

echo "📦 Installing bind (for dig)..."
brew install bind

sudo chmod +x ./hiring.sh
sudo chmod +x ./bob.sh
sudo chmod +x ./openmod.sh
sudo chmod +x ./careers.sh

export GP_EXTERNAL_BROWSER="/ide/bin/remote-cli/gitpod-code --openExternal"

git config --global push.default current
