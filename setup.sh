#!/usr/bin/env bash
set -euo pipefail

if command -v oh-my-posh &>/dev/null; then
  echo "✅ Oh My Posh already installed."
else
  echo "⬇️ Installing Oh My Posh..."
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi

dotfilesDir="$(pwd)"
timestamp="$(date +%Y-%m-%d-%H%M)"

backup_or_remove() {
  local dest="$1"

  if [ -h "$dest" ]; then
    echo "🔁 Removing existing symlink: $dest"
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "🗄️ Backing up existing: $dest"
    mv "$dest" "${dest}.${timestamp}"
  fi
}

create_symlink() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  backup_or_remove "$dest"

  echo "🔗 Creating symlink: $dest → $src"
  ln -s "$src" "$dest"
}

link_file() {
  local relPath="$1"
  create_symlink "${dotfilesDir}/${relPath}" "${HOME}/${relPath}"
}

link_files_in_folder() {
  local relDir="$1"
  local srcDir="${dotfilesDir}/${relDir}"
  local destDir="${HOME}/${relDir}"

  if [ ! -d "$srcDir" ]; then
    echo "❌ Error: not a directory: $srcDir"
    return 1
  fi

  echo "📁 Linking files from: $srcDir"
  mkdir -p "$destDir"

  find "$srcDir" -maxdepth 1 -type f -print0 | while IFS= read -r -d $'\0' file; do
    create_symlink "$file" "${destDir}/$(basename "$file")"
  done
}

link_folder() {
  local relDir="$1"
  create_symlink "${dotfilesDir}/${relDir}" "${HOME}/${relDir}"
}

link_file ".bashrc"
link_files_in_folder ".config"
link_folder ".config/nvim"
link_folder ".local/share/kwin/scripts/krohnkite"
link_folder ".local/share/konsole"

echo "✅ All symlinks created successfully."

