{ config, pkgs, ... }:

{

  home.username = "kletus";
  home.homeDirectory = "/home/kletus";
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nix btw";
    };
  };
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/kletus/.files/config/nvim";
    recursive = true;
  };
  home.packages = with pkgs; [
    neovim
    nodejs
    cargo
    nil
    ripgrep
    nixpkgs-fmt
    gcc
  ];
}
