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
      command = /Users/jarver/.local/bin/zellij-picker
    '';
  };

  ".config/kanata/kanata.kbd" = {
    text = ''
      (defsrc
        caps a s d f g h j k l ;
      )

      (deflayer off
        (layer-switch default) a s d f g h j k l ;
      )

      (deflayer default
        (layer-switch nav)
        (tap-hold 300 450 a lmet)
        (tap-hold 300 450 s lalt)
        (tap-hold 300 450 d lctl)
        (tap-hold 300 450 f lsft)
        g
        h
        (tap-hold 300 450 j rsft)
        (tap-hold 300 450 k rctl)
        (tap-hold 300 450 l ralt)
        (tap-hold 300 450 ; rmet)
      )

      (deflayer nav
        (layer-switch nav) _ _ (layer-switch default) _ _ left down up right (layer-switch off)
      )
    '';
  };

  ".local/bin/zellij-picker" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
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
