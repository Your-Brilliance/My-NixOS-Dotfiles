{ pkgs, ... }:

let
  edex-ui-patched = (pkgs.appimageTools.wrapType2 {
    pname = "edex-ui-patched";
    version = "2.2.8-patch.1";
    src = pkgs.fetchurl {
      url = "https://github.com/theelderemo/eDEX-UI-security-patched/releases/download/security-patch/eDEX-UI-Linux-x86_64.AppImage";
      sha256 = "sha256-M3y1m/h5ERPSP92zLQaj8PiKg5luVnaGT6L5GCM+zYo=";
      curlOpts = "-k";
    };
    extraPkgs = pkgs: with pkgs; [ xorg.libxshmfence ];
  });
in
{
  home.packages = [ edex-ui-patched ];
}
