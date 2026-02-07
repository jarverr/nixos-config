{
  config,
  pkgs,
  lib,
  ...
}:

let
  name = "jarverr";
  user = "jarver";
  email = "jarne@vercruysse.dev";
in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;

    dotDir = "${config.xdg.configHome}/zsh";

    initContent = lib.mkBefore ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # XDG Base Directory
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_CACHE_HOME="$HOME/.cache"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_STATE_HOME="$HOME/.local/state"

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Set default editor
      export EDITOR="vim"
      export VISUAL="vim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    lfs = {
      enable = true;
    };
    settings = {
      user = {
        name = name;
        email = email;
      };
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-airline-themes
      vim-startify
    ];
    settings = {
      ignorecase = true;
    };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/Projects',
        \ '~/Documents',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
    '';
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux "/home/${user}/.ssh/config_external")
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "/Users/${user}/.ssh/config_external")
    ];
    matchBlocks = {
      "*" = {
        # Set the default values we want to keep
        sendEnv = [
          "LANG"
          "LC_*"
        ];
        hashKnownHosts = true;
      };
      # Example SSH configuration for GitHub
      # "github.com" = {
      #   identitiesOnly = true;
      #   identityFile = [
      #     (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
      #       "/home/${user}/.ssh/id_github"
      #     )
      #     (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
      #       "/Users/${user}/.ssh/id_github"
      #     )
      #   ];
      # };
    };
  };

  zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      theme = "gruvbox-dark";
      default_shell = "zsh";
      pane_frames = false;
      simplified_ui = true;
      default_layout = "compact";
    };
  };

  zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "markdown"
    ];
    userSettings = {
      theme = "Gruvbox Dark";

      ui_font_size = 16;
      buffer_font_size = 14;
      buffer_font_family = "JetBrains Mono";

      vim_mode = true;

      format_on_save = "on";
      autosave = "on_focus_change";

      terminal = {
        font_family = "JetBrains Mono";
        font_size = 14;
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };
    };
  };

  starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_status$rust$nix_shell$cmd_duration$line_break$character";

      directory = {
        style = "blue bold";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        style = "purple";
        format = "[$branch]($style) ";
      };

      git_status = {
        style = "red bold";
        format = "[$all_status$ahead_behind]($style) ";
      };

      rust = {
        format = "[$symbol($version)]($style) ";
        symbol = "🦀 ";
        style = "orange";
      };

      nix_shell = {
        format = "[$symbol$state]($style) ";
        symbol = "❄️ ";
        style = "cyan";
      };

      cmd_duration = {
        min_time = 2000;
        format = "[$duration]($style) ";
        style = "yellow";
      };

      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
      };
    };
  };

  obsidian = {
    enable = true;
    vaults.vault = {
      target = "vault";
    };
  };
}
