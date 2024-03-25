let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/phaer/nixpkgs/archive/7e754317e4652ca7f3196fbc149b7a19ccc088d7.tar.gz";
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
        # Webkit misses libgles2 and gstreamer-libav on ubuntu, but tests are passing
        export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
        export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
    '';

}
