{ config, ... }: {
  xdg.configFile."zellij/config.yaml".text = ''
    themes:
      nord:
        fg: [235, 203, 139]
        bg: 153
        gray: [46, 52, 64] 
        black: [46, 52, 64]
        red: [191, 97, 106]
        green: [163, 190, 140]
        yellow: [235, 203, 139]
        blue: [94, 129, 172]
        magenta: [180, 142, 173]
        cyan: [76, 86, 106]
        white: [216, 222, 233]
        orange: [208, 135, 112]
    theme: nord
  '';
}
