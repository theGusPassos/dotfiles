# !/bin/bash

# installing ohmyposh
curl -s https://ohmyposh.dev/install.sh | bash -s

dotfilesDir=$(pwd)

function linkDotfile {
  srcPath="${dotfilesDir}/${1}"
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  mkdir -p "$(dirname "${dest}")"

  if [ -h "${dest}" ]; then
    echo "Removing existing symlink: ${dest}"
    rm "${dest}"
  elif [ -e "${dest}" ]; then
    echo "Backing up existing: ${dest}"
    mv "${dest}" "${dest}.${dateStr}"
  fi

  echo "Creating symlink: ${dest} -> ${srcPath}"
  ln -s "${srcPath}" "${dest}"
}


linkDotfile .bashrc
linkDotfile .config/nvim
linkDotfile .config/konsolerc
linkDotfile .config/kdeglobals
linkDotfile .config/kglobalshortcutsrc
linkDotfile .config/kplasmarc
linkDotfile .config/kwinrc
linkDotfile .local/share/kwin/scripts
