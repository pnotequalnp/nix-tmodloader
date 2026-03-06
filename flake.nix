{
  description = "";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      overlay = final: prev: { tmodloader-server = final.callPackage ./pkgs/default.nix { }; };
      overlays.default = self.overlay;
      nixosModules.tmodloader = import ./module;
      packages.x86_64-linux.default = (
        import nixpkgs {
          system = "x86_64-linux";
          overlays = [ self.overlays.default ];
        }
      ).tmodloader-server;
    };
}
