{
  description = "Development environment based on Ubuntu 20.04 toolchain";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pythonEnv = pkgs.python39.withPackages (python-pkgs: with python-pkgs; [
        pexpect
        pyyaml
      ]);

      # Create nixvars.conf for Yocto configuration
      nixconf = pkgs.writeText "nixvars.conf" ''
        export LOCALE_ARCHIVE
        export NIX_DONT_SET_RPATH="1"
        
        BB_HASHBASE_WHITELIST += " LOCALE_ARCHIVE \
                                  NIX_DONT_SET_RPATH "
      '';
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell.override
          {
            stdenv = pkgs.gcc9Stdenv;
          }
          {
            buildInputs = with pkgs; [
              # Python environment
              pythonEnv

              # Development tools
              gawk
              wget
              git
              unzip
              texinfo

              # Build essentials
              binutils
              chrpath
              socat
              cpio
              gnumake
              which
              perl

              # Compression tools
              xz
              zstd
              lz4
              p7zip

              # Additional development tools
              openssl
              bc
              bison
              flex
              cmake
              ninja
              sudo

              # # Cross compilation tools
              # gcc-arm-embedded
              # pkgsCross.arm-embedded.buildPackages.gcc

              # SDL and terminal
              SDL
              xterm

              # System tools
              inetutils # for ping
              # whiptail


              diffstat
              rpcsvc-proto

              libyaml

              # Additional tools from FHS example
              expect
              hostname
              kconfig-frontends
              patch
              util-linux
              gdb
            ];

            shellHook = ''
              # Ensure Python 3.9 is first in PATH
              export PATH="${pythonEnv}/bin:$PATH"
            
              # Set Python-related environment variables
              export PYTHONPATH="${pythonEnv}/${pkgs.python39.sitePackages}:$PYTHONPATH"
            
              export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
              export LANG="en_US.UTF-8"
              export LC_ALL="en_US.UTF-8"

              # Set specific GCC environment variables
              export CC="${pkgs.gcc9}/bin/gcc"
              export CXX="${pkgs.gcc9}/bin/g++"
            
              # Print GCC version for verification
              echo "GCC version: $(gcc --version | head -n1)"
            
              # Print toolchain versions
              echo "=== Toolchain Versions ==="
              echo "Host GCC: $(gcc --version | head -n1)"
              echo "ARM GCC: $(arm-none-eabi-gcc --version | head -n1)"
            
              # Source the Yocto environment
              source poky/oe-init-build-env

              # BitBake environment configuration
              export BB_ENV_EXTRAWHITE="LOCALE_ARCHIVE NIX_DONT_SET_RPATH $BB_ENV_EXTRAWHITE"
              export BBPOSTCONF="${nixconf}"
              export NIX_DONT_SET_RPATH="1"
            '';
          };
      };
    };
}
