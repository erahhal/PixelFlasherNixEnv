with import <nixpkgs> {};
mkShell {
    name = "pixelflasher";

    buildInputs = [
      android-tools
      gtk3
      pkg-config
    ];

    propagatedBuildInputs = [
      (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
        android-tools
        gtk3
        pkg-config
      ]))
    ];

    shellHook = ''
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./venv/lib/python3.11/site-packages/wx
      if [ ! -d PixelFlasher ]; then
        git clone https://github.com/badabing2005/PixelFlasher.git
      fi
      cd PixelFlasher
      git pull
      python -m venv venv
      source ./venv/bin/activate
      pip install -r requirements.txt
      python PixelFlasher.py
    '';
}
