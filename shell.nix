let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/phaer/nixpkgs/archive/0784691d66852c4ca35b8d5cf39aa9b327ad28e1.tar.gz";
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
        export DEBUG="pw:api,pw:install"
        export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
        export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
    '';

}
