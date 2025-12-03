#!/usr/bin/env zsh
set -euo pipefail

# Install oh-my-zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "⬇️ Installing Oh My Zsh..."

  RUNZSH=no CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "✨ Oh My Zsh installed!"
else
  echo "✅ Oh My Zsh already installed."
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
  local targetPath="$2"
  create_symlink "${dotfilesDir}/${relPath}" "${HOME}/${targetPath}"
}

link_files_in_folder() {
  local relDir="$1"
  local targetDir="$2"
  local srcDir="${dotfilesDir}/${relDir}"
  local destDir="${HOME}/${targetDir}"

  if [ ! -d "$srcDir" ]; then
    echo "❌ Error: not a directory: $srcDir"
    return 1
  fi

  echo "📁 Linking files from: $srcDir"
  mkdir -p "$destDir"

  find "$srcDir" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' file; do
    create_symlink "$file" "${destDir}/$(basename "$file")"
  done
}

link_folder() {
  local relDir="$1"
  local targetDir="$2"
  create_symlink "${dotfilesDir}/${relDir}" "${HOME}/${targetDir}"
}

link_folder "common/nvim" ".config/nvim"

link_file "mac/.zshrc" ".zshrc"

echo "✅ All symlinks created successfully."

