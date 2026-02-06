{ pkgs, config, ... }:

{
  ".config/ghostty/config" = {
    text = ''
      theme = GruvboxDark
      font-family = JetBrains Mono
      font-size = 14
      cursor-style = block
      cursor-style-blink = false
      mouse-hide-while-typing = true
      window-padding-x = 10
      window-padding-y = 10
      confirm-close-surface = false
    '';
  };
}
