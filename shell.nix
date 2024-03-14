let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/phaer/nixpkgs/archive/a77a0eabcac6ba334fdecc66d4143d71984c6002.tar.gz";
    # https://status.nixos.org/ -> nixos-23.11 on 2024-03-12
    #url = "https://github.com/nixos/nixpkgs/archive/ddcd7598b2184008c97e6c9c6a21c5f37590b8d2.tar.gz";
  };
  pkgs = import nixpkgs {};
in

    pkgs.mkShell {
    name = "dev-shell";
    buildInputs = with pkgs; [
        python311Packages.playwright
    ];

    shellHook = ''
        export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
    '';

}
