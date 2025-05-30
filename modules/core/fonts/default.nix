{ pkgs, ... }: {
  fonts = {
    packages = with pkgs;
      [
        (callPackage (import ./MplusCodeNerdFont) { })
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        roboto
      ] ++ builtins.filter lib.attrsets.isDerivation
      (builtins.attrValues pkgs.nerd-fonts);
    fontconfig.defaultFonts = {
      serif = [ "Roboto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Roboto" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
