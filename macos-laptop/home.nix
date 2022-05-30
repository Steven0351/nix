{ pkgs, ...}: 
let
  firaCode = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" ];
  };
in
{
  home.packages = with pkgs; [
    _1password
    ansible
    any-nix-shell
    argocd
    babelfish
    btop
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
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-github # Useful for getting sha256 hashes for github repos
    nmap
    nodePackages.neovim
    nodePackages.prettier
    nodejs
    pinentry-curses
    # podman # -- Currently doesn't work due to being unable to find gvproxy
    qemu 
    ripgrep
    stylua
    tanka
    tree-sitter
    wget
    youtube-dl
    yubikey-manager
    zathura
    zk
  ] ++ [ firaCode ];
  
  imports = [
    ../shared/home-manager/bat.nix
    ../shared/home-manager/exa.nix
    ../shared/home-manager/fish.nix
    ../shared/home-manager/gh.nix
    ../shared/home-manager/git.nix
    ../shared/home-manager/gpg.nix
    ../shared/home-manager/home-manager.nix
    ../shared/home-manager/jq.nix
    ../shared/home-manager/nvim.nix
    ../shared/home-manager/starship.nix
    ../shared/home-manager/macos/direnv.nix
    ../shared/home-manager/macos/gpg-agent.nix
  ];
}
