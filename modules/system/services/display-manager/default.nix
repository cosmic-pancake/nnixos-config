{ pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = false;
}
