{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "emmetdelaney@helios" = [
      ../.
      ./helios
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfiguration = {
      "emmetdelaney_helios" = homeManagerConfiguration {
        modules = homeImports."emmetdelaney@helios";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
