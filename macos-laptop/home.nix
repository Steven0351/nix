{ pkgs, ...}: {
  home.packages = with pkgs; [
    _1password
    ansible
    any-nix-shell
    argocd
    babelfish
    (callPackage ../shared/btop {})
    drone-cli
    exercism
    ffmpeg
    fzf
    glow
    go-task
    imagemagick
    kubernetes-helm
    kubectl
    lynx
    minikube
    neofetch
    neovim
    nerdfonts
    # Useful for getting sha256 hashes for github repos
    nix-prefetch-github
    nmap
    nodePackages.neovim
    nodePackages.prettier
    nodejs
    # podman # -- Currently doesn't work due to being unable to find gvproxy
    # quickemu
    qemu 
    ripgrep
    stylua
    tanka
    wget
    youtube-dl
  ];
  
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  imports = [
    ../shared/home-manager/bat.nix
    ../shared/home-manager/direnv.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/git.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/jq.nix
    ../shared/home-manager/starship.nix
  ];

  xdg.configFile.nvim = {
    source = ../shared/nvim;
    recursive = true;
  };
}
