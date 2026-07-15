{ pkgs, ... }:

let
  dotnet8 = pkgs.dotnetCorePackages.dotnet_8;
in
pkgs.writeScriptBin "rider" ''
  #!${pkgs.stdenv.shell}
  
  # Set .NET environment variables
  export DOTNET_ROOT="${dotnet8.sdk}/share/dotnet"
  export PATH=$DOTNET_ROOT:$PATH
  
  # Launch the original Rider
  exec ${pkgs.jetbrains.rider}/bin/rider "$@"
''
