{ pkgs }:

with pkgs;
[
  # General packages for development and system management
  bash-completion
  bat
  btop
  coreutils
  killall
  openssh
  sqlite
  wget
  zip

  # Notes
  obsidian

  # Encryption and security tools
  age
  gnupg
  bitwarden-cli
  bitwarden-desktop

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Fonts
  fira-code
  meslo-lgs-nf
  noto-fonts-color-emoji

  # File utilities
  fd

  # Text and terminal utilities
  jetbrains-mono
  ripgrep
  tree

  unzip

  # Development tools
  curl
  gh
  fzf
  zed-editor
  kanata
  opencode
  alacritty
  neovim

  # Programming languages and runtimes
  nixd
  nil
  nixfmt
  cargo-leptos
  wasm-bindgen-cli
  leptosfmt
  rustup
  tailwindcss_4

  bun
  supabase-cli
]
