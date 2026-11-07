{
  description = "Mi configuración NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/1073dad219cb";
    lanzaboote.url = "github:nix-community/lanzaboote";
    opencode.url = "github:GutMutCode/opencode-nix";
  };

  outputs = { self, nixpkgs, lanzaboote, opencode, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.vnix = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix
        lanzaboote.nixosModules.lanzaboote
	# Agregar OpenCode al sistema
          {
            nixpkgs.overlays = [
              opencode.overlays.default
            ];

            environment.systemPackages = [
              opencode.packages.${system}.default
            ];
          }
      ];
    };
  };
}