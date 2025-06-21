{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages = [
              (pkgs.python3.withPackages (ps: [
                ps.tree-sitter
                ps.tree-sitter-grammars.tree-sitter-nix
              ]))
              pkgs.black
              pkgs.nixpkgs-review
              pkgs.nixpkgs-vet
            ];
          };
        };
    };
}
