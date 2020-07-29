{
  description = "Nix flake for Delphes";

  outputs = { self, nixpkgs } : let
    system = "x86_64-linux";
  in {
    overlay = final: prev: {
      delphes = with final; stdenv.mkDerivation {
        name = "delphes";
        version = "3.4.x";
        nativeBuildInputs = [ cmake tcl ];
        buildInputs = [ root lhapdf pythia ];
        src = self;
        PYTHIA8=pythia;
      };
    };

    defaultPackage.${system} = (import nixpkgs { inherit system; overlays = [self.overlay]; }).delphes;
  };
}
