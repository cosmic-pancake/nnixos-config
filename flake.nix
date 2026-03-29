{
  description = "NixOS configuration with KDE, GNOME and SDDM";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # Core modules
        ./modules/system/desktops/kde
        ./modules/system/desktops/gnome
        ./modules/system/services/display-manager

        # System configuration
        ({ pkgs, ... }: {
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          networking.hostName = "nixos";
          
          # Enable networking
          networking.networkmanager.enable = true;

          # Time zone and locale
          time.timeZone = "UTC";
          i18n.defaultLocale = "en_US.UTF-8";

          # Enable experimental features
          nix.settings.experimental-features = [ "nix-command" "flakes" ];

          system.stateVersion = "24.05";
        })
      ];
    };
  };
}
