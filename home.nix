{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.files/config";
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    kew = "kew";
    keyd = "keyd";
    kitty = "kitty";
    niri = "niri";
    nvim = "nvim";
    rofi = "rofi";
    vicinae = "vicinae";
    yazi = "yazi";
  };
in
{
  home = {
    username = "kletus";
    homeDirectory = "/home/kletus";
    stateVersion = "26.05";

  };

  home.packages = with pkgs; [
    neovim
    nodejs
    cargo
    nil
    ripgrep
    nixpkgs-fmt
    gcc
    statix
    kew
    kitty
    vicinae
    rofi
    pithos
    mediainfo
    qdirstat
    tixati
    exiftool
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;

    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      qt6Packages.fcitx5-configtool
      # fcitx5-mozc
    ];
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    INPUT_METHOD = "fcitx";
    EDITOR = "nvim";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  programs.yazi = {
    enable = true;

    plugins = with pkgs.yaziPlugins; {
      inherit
        chmod
        mount
        office
        compress
        mediainfo
        ;
      "mime-ext" = mime-ext;
      "recycle-bin" = recycle-bin;
    };
  };

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      colorScheme = "Base";

      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        shuffle
        keyboardShortcut
      ];
    };

  programs.bash = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      name = "Kletus";
      email = "amukheni@hotmail.com";
    };
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
