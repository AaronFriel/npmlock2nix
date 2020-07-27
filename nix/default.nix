{}:
let
  sources = import ./sources.nix;
in
import sources.nixpkgs {
  overlays = [
    (self: super: {
      npmlock2nix = self.callPackage ../default.nix { };
      inherit (self.callPackage (import sources.smoke) { }) smoke;

      mkShellNoCC = super.mkShell.override {
        stdenv = super.stdenvNoCC;
      };
    })
  ];
}
