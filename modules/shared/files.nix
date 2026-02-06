{ pkgs, config, ... }:

{
  ".config/ghostty/config" = {
    text = ''
      theme = Gruvbox Dark
      font-family = JetBrains Mono
      font-size = 14
      cursor-style = block
      cursor-style-blink = false
      mouse-hide-while-typing = true
      window-padding-x = 10
      window-padding-y = 10
      confirm-close-surface = false
      command = direct:~/.local/bin/zellij-picker
    '';
  };

  ".local/bin/zellij-picker" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      sessions=$(zellij list-sessions -s 2>/dev/null)

      if [ -z "$sessions" ]; then
        exec zellij
      fi

      choice=$(printf "%s\nnew session" "$sessions" | fzf --height=40% --reverse --prompt="Zellij session: ")

      if [ -z "$choice" ]; then
        exec zsh
      elif [ "$choice" = "new session" ]; then
        exec zellij
      else
        exec zellij attach "$choice"
      fi
    '';
  };
}
