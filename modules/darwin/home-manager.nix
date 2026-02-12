{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:

let
  user = "jarver";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    masApps = {
      # "wireguard" = 1451685025;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          packages = pkgs.callPackage ./packages.nix { };
          file = lib.mkMerge [
            sharedFiles
            additionalFiles
          ];
          stateVersion = "23.11";
        };

        xdg.enable = true;

        programs = {
          aerospace = {
            enable = true;
            launchd.enable = true;
            settings = {
              config-version = 2;
              after-startup-command = [ ];
              start-at-login = true;
              enable-normalization-flatten-containers = true;
              enable-normalization-opposite-orientation-for-nested-containers = true;
              accordion-padding = 30;
              default-root-container-layout = "tiles";
              default-root-container-orientation = "auto";
              on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
              automatically-unhide-macos-hidden-apps = false;
              persistent-workspaces = [
                "1" "2" "3" "4" "5" "6" "7" "8" "9"
                "A" "B" "C" "D" "E" "F" "G" "I" "M"
                "N" "O" "P" "Q" "R" "S" "T" "U" "V"
                "W" "X" "Y" "Z"
              ];
              on-mode-changed = [ ];
              key-mapping.preset = "qwerty";
              gaps = {
                inner.horizontal = 0;
                inner.vertical = 0;
                outer.left = 0;
                outer.bottom = 0;
                outer.top = 0;
                outer.right = 0;
              };
              mode.main.binding = {
                alt-slash = "layout tiles horizontal vertical";
                alt-comma = "layout accordion horizontal vertical";
                alt-h = "focus left";
                alt-j = "focus down";
                alt-k = "focus up";
                alt-l = "focus right";
                alt-shift-h = "move left";
                alt-shift-j = "move down";
                alt-shift-k = "move up";
                alt-shift-l = "move right";
                alt-minus = "resize smart -50";
                alt-equal = "resize smart +50";
                alt-1 = "workspace 1";
                alt-2 = "workspace 2";
                alt-3 = "workspace 3";
                alt-4 = "workspace 4";
                alt-5 = "workspace 5";
                alt-6 = "workspace 6";
                alt-7 = "workspace 7";
                alt-8 = "workspace 8";
                alt-9 = "workspace 9";
                alt-a = "workspace A";
                alt-b = "workspace B";
                alt-c = "workspace C";
                alt-d = "workspace D";
                alt-e = "workspace E";
                alt-f = "workspace F";
                alt-g = "workspace G";
                alt-i = "workspace I";
                alt-m = "workspace M";
                alt-n = "workspace N";
                alt-o = "workspace O";
                alt-p = "workspace P";
                alt-q = "workspace Q";
                alt-r = "workspace R";
                alt-s = "workspace S";
                alt-t = "workspace T";
                alt-u = "workspace U";
                alt-v = "workspace V";
                alt-w = "workspace W";
                alt-x = "workspace X";
                alt-y = "workspace Y";
                alt-z = "workspace Z";
                alt-shift-1 = "move-node-to-workspace 1";
                alt-shift-2 = "move-node-to-workspace 2";
                alt-shift-3 = "move-node-to-workspace 3";
                alt-shift-4 = "move-node-to-workspace 4";
                alt-shift-5 = "move-node-to-workspace 5";
                alt-shift-6 = "move-node-to-workspace 6";
                alt-shift-7 = "move-node-to-workspace 7";
                alt-shift-8 = "move-node-to-workspace 8";
                alt-shift-9 = "move-node-to-workspace 9";
                alt-shift-a = "move-node-to-workspace A";
                alt-shift-b = "move-node-to-workspace B";
                alt-shift-c = "move-node-to-workspace C";
                alt-shift-d = "move-node-to-workspace D";
                alt-shift-e = "move-node-to-workspace E";
                alt-shift-f = "move-node-to-workspace F";
                alt-shift-g = "move-node-to-workspace G";
                alt-shift-i = "move-node-to-workspace I";
                alt-shift-m = "move-node-to-workspace M";
                alt-shift-n = "move-node-to-workspace N";
                alt-shift-o = "move-node-to-workspace O";
                alt-shift-p = "move-node-to-workspace P";
                alt-shift-q = "move-node-to-workspace Q";
                alt-shift-r = "move-node-to-workspace R";
                alt-shift-s = "move-node-to-workspace S";
                alt-shift-t = "move-node-to-workspace T";
                alt-shift-u = "move-node-to-workspace U";
                alt-shift-v = "move-node-to-workspace V";
                alt-shift-w = "move-node-to-workspace W";
                alt-shift-x = "move-node-to-workspace X";
                alt-shift-y = "move-node-to-workspace Y";
                alt-shift-z = "move-node-to-workspace Z";
                alt-tab = "workspace-back-and-forth";
                alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
                alt-shift-semicolon = "mode service";
              };
              mode.service.binding = {
                esc = [ "reload-config" "mode main" ];
                r = [ "flatten-workspace-tree" "mode main" ];
                f = [ "layout floating tiling" "mode main" ];
                backspace = [ "close-all-windows-but-current" "mode main" ];
                alt-shift-h = [ "join-with left" "mode main" ];
                alt-shift-j = [ "join-with down" "mode main" ];
                alt-shift-k = [ "join-with up" "mode main" ];
                alt-shift-l = [ "join-with right" "mode main" ];
              };
            };
          };

          #sketchybar = {
          #  enable = true;
          #};
        }
        // import ../shared/home-manager.nix { inherit config pkgs lib; };

        # Marked broken Oct 20, 2022 check later to remove this
        # https://github.com/nix-community/home-manager/issues/3344
        manual.manpages.enable = false;
      };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock = {
    enable = true;
    username = user;
    entries = [
      { path = "/Applications/Zen.app/"; }
      { path = "/System/Applications/Messages.app/"; }
      { path = "${pkgs.obsidian}/Applications/Obsidian.app/"; }
      { path = "${pkgs.zed-editor}/Applications/Zed.app/"; }
      { path = "/Applications/Ghostty.app/"; }
      { path = "/System/Applications/Music.app/"; }
      { path = "/System/Applications/Photos.app/"; }
      { path = "/System/Applications/Photo Booth.app/"; }
      { path = "/System/Applications/System Settings.app/"; }
      {
        path = "${config.users.users.${user}.home}/Downloads";
        section = "others";
        options = "--sort name --view grid --display stack";
      }
    ];
  };

}
