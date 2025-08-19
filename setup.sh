# !/bin/bash

if command -v oh-my-posh &> /dev/null; then
    echo "Oh My Posh is already installed. Skipping installation."
else
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

dotfilesDir=$(pwd)

function linkFile {
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

linkFilesInFolder() {
  local srcPath="${dotfilesDir}/${1}"
  local destDir="${HOME}/${1}"
  local dateStr=$(date +%Y-%m-%d-%H%M)

  if [ ! -d "${srcPath}" ]; then
    echo "Error, not a dir: ${srcPath}"
    return 1
  fi

  echo "Linking files from dir: ${srcPath}"
  mkdir -p "${destDir}"

  while IFS= read -r -d $'\0' item; do
    if [ -f "${item}" ]; then
      local itemName=$(basename "${item}")
      local newDest="${destDir}/${itemName}"

      if [ -h "${newDest}" ]; then
        echo "Removing existing symlink: ${newDest}"
        rm "${newDest}"
      elif [ -e "${newDest}" ]; then
        echo "Backing up existing: ${newDest}"
        mv "${newDest}" "${newDest}.${dateStr}"
      fi

      echo "Creating symlink: ${newDest} -> ${item}"
      ln -s "${item}" "${newDest}"
    fi
  done < <(find "${srcPath}" -maxdepth 1 -type f -print0)
}

linkFolder() {
  local srcPath="${dotfilesDir}/${1}"
  local dest="${HOME}/${1}"
  local dateStr=$(date +%Y-%m-%d-%H%M)

  if [ ! -e "${srcPath}" ]; then
    echo "Error, does not exist: ${srcPath}"
    return 1
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

linkFile .bashrc
linkFilesInFolder .config
linkFolder .config/nvim
linkFolder .local/share/kwin/scripts/krohnkite

