let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/phaer/nixpkgs/archive/de966bde7c29589db944d71c94e1ecf5b3f64ee2.tar.gz";
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
        # Enable TLS support in Webkit, via GIO module.
        export GIO_EXTRA_MODULES="${pkgs.glib-networking}/lib/gio/modules/:$GIO_EXTRA_MODULES}"
        # Webkit misses libgles2 and gstreamer-libav.
        export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
        export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
    '';

}
