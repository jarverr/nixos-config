{ pkgs }:

with pkgs;
[
  # General
  thunderbird
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
  obsidian

  # Encryption and security tools
  age
  gnupg
  bitwarden-cli
  bitwarden-desktop

  # Cloud-related tools and SDKs

  # Fonts
  fira-code
  meslo-lgs-nf
  noto-fonts-color-emoji
  fd

  # Text and terminal utilities
  jetbrains-mono
  ripgrep
  tree
  curl
  gh
  fzf
  unzip

  # Development tools
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
