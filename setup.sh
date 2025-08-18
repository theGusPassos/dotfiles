# !/bin/bash


if command -v oh-my-posh &> /dev/null; then
    echo "Oh My Posh is already installed. Skipping installation."
else
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

dotfilesDir=$(pwd)

function linkDotfile {
  srcPath="${dotfilesDir}/${1}"
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -d "${srcPath}" ]; then
    echo "Processing directory: ${srcPath}"
    mkdir -p "${dest}"
    
    find "${srcPath}" -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d $'\0' item; do
      itemName=$(basename "${item}")
      newSrcPath="${srcPath}/${itemName}"
      newDest="${dest}/${itemName}"
      relativeSrcPath="${1}/${itemName}"
      
      # Recursively process each item
      linkDotfile "${relativeSrcPath}"
    done
    return
  fi

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
linkDotfile .config
linkDotfile .local/share/kwin/scripts/krohnkite

