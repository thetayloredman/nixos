{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:

    let
      agenix = inputs.agenix.packages.${system}.default;
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixfmt
          agenix
        ];
      };
    };
}
