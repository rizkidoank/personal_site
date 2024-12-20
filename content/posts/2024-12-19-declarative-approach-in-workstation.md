---
title: "NixOS Declarative Approach for Operating System Management"
date: 2024-12-19T00:00:00+07:00
tags:
- english
- nixos
- linux
- nix
---

Arch Linux is my favourite distribution for long time. I can get the benefit of bleeding-edge and highly configurable system, yet still manageable with its lovely package management like `pacman`, `AUR` and additionally `brew`. I also use `ansible` / `chef` to manage the workstations / VMs for the sake of immutability. But, managing the playbooks takes time even for doing simple things.

In distrowatch, there are page hit ranks and I already familiar with most of them in the list and I found NixOS there, which I haven't used. I interested with the declarative configuration approach that NixOS offer to manage the system. Go straight to the documentation rightaway, and try it in VM. Aaaand.. I got overwhelmed at first with the nix language. 30 minutes learning the configurations, finally I can make the configuration usable and enjoying it more than Arch! The offered approach allows us to manage the workstations from zero just by utilizing the nix configurations, so we technically having an immutable system!

Let's jump in into the configs and take a look what we have:
- `/etc/nixos/configuration.nix` is the default main config
- `/etc/nixos/hardware-configuration.nix` is the hardware config (bootloader, kernel, filesystems, additional hardwares)
- `/etc/nixos/home.nixos` is the `home-manager` _flake_ config, this is optional but I recommend to use its easier to manage the users environment.
- `/etc/nixos/flake.nix` is the flake config, an experimental feature to simplify and also standardize the writing of nix expressions. It has version-pinned lock which allows reproducibility.

Since I used _flake_, `flake.nix` will be the entrypoint.

```nix
{
  description = "NixOS Workstation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rizki = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
```

Flake config schema contains two main attributes:
- `inputs` I defined the dependencies for this flake. In above, I used:
  - `nixpkgs`: provides the packages for nix. You can choose the tags or use `unstable` for bleeding-edge release.
  - `nixos-hardware`: provides the predefined flake config for supported hardwares.
  - `home-manager`: flake for `home-manager` [go here for more details](https://nix-community.github.io/home-manager/)

- `outputs` I defined the system configurations with some parameters including modules. There are three modules used in this config.
  - `configuration.nix`, this is the system definition specifically used by NixOS. Its also import `hardware-configuration.nix` to define hardware specific configs.
    {{<details title="configuration.nix">}}
    { config, lib, pkgs, ... }:

    {
      imports =
        [
          ./hardware-configuration.nix
        ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_zen;

      networking.hostName = "nixos";
      networking.networkmanager.enable = true;

      time.timeZone = "Asia/Jakarta";

      i18n.defaultLocale = "en_US.UTF-8";
      services.xserver.enable = true;
      services.xserver.xkb.layout = "us";
      services.displayManager.sddm.wayland.enable = true;
      services.desktopManager.plasma6.enable = true;

      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };

      services.libinput.enable = true;
      services.fstrim.enable = true;
      users.users.rizki = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
          tree
        ];
        shell = pkgs.fish;
        ignoreShellProgramCheck = true;
      };

      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      environment.systemPackages = with pkgs; [
        git
        vim
        wget
        kitty
        libimobiledevice
        ifuse
        nss
        nssTools
      ];

      programs.steam.enable = true;
      programs.steam.protontricks.enable = true;
      programs.dconf.enable = true;
      programs.firefox.enable = true;
      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      services.flatpak.enable = true;
      services.openssh.enable = true;
      services.btrfs.autoScrub.enable = true;
      services.btrfs.autoScrub.fileSystems = ["/"];
      services.usbmuxd = {
        enable = true;
        package = pkgs.usbmuxd2;
      };
      virtualisation.containers.enable = true;
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      networking.firewall.enable = false;
      system.stateVersion = "24.11";
    }
    {{</details>}}

  - `home.nix` contains the `home-manager` config. I used this to configure the user-level packages and configs in the NixOS.
    {{<details title="home.nix">}}
    { config, pkgs, ... }:

    {
      fonts.fontconfig.enable = true;
      home.username = "rizki";
      home.homeDirectory = "/home/rizki";
      home.sessionPath = [
        "$HOME/.config/composer/vendor/bin"
      ];
      home.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
        pkgs.localsend
        pkgs.vlc
        pkgs.bitwarden-desktop
        pkgs.bitwarden-cli
        pkgs.insomnia
        pkgs.code-cursor
        pkgs.yakuake
        pkgs.nodejs_22
        pkgs.php84
        pkgs.php84Packages.composer
        pkgs.frankenphp
        pkgs.qbittorrent
        pkgs.telegram-desktop
        pkgs.testdisk
        pkgs.idevicerestore
        pkgs.libideviceactivation
        pkgs.libirecovery
        pkgs.google-chrome
        pkgs.podman-desktop
        pkgs.docker-compose
        pkgs.kubectl
        pkgs.qemu_kvm
        pkgs.virtiofsd
        pkgs.dbeaver-bin
        pkgs.act
        pkgs.gh
        pkgs.glab
        pkgs.discord
      ];

      programs.git = {
        enable = true;
        userName = "Rizki";
        userEmail = "rizki@rizkidoank.com";
      };
      programs.fish.enable = true;
      programs.bun.enable = true;
      programs.java.enable = true;
      programs.starship.enable = true;
      programs.starship.enableTransience = true;
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-composite-blur
          obs-3d-effect
          looking-glass-obs
          droidcam-obs
        ];
      };
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      programs.freetube.enable = true;
      programs.poetry.enable = true;
      programs.vscode.enable = true;
      programs.vscode.extensions = [ 
        pkgs.vscode-extensions.rust-lang.rust-analyzer
        pkgs.vscode-extensions.gitlab.gitlab-workflow
        pkgs.vscode-extensions.github.vscode-pull-request-github
        pkgs.vscode-extensions.vue.volar
        pkgs.vscode-extensions.visualstudioexptteam.vscodeintellicode
        pkgs.vscode-extensions.ms-vscode.makefile-tools
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.ms-python.black-formatter
        pkgs.vscode-extensions.ms-pyright.pyright
        pkgs.vscode-extensions.ms-azuretools.vscode-docker
        pkgs.vscode-extensions.hashicorp.terraform
        pkgs.vscode-extensions.esbenp.prettier-vscode
        pkgs.vscode-extensions.dart-code.flutter
        pkgs.vscode-extensions.ms-kubernetes-tools.vscode-kubernetes-tools
        pkgs.vscode-extensions.ms-toolsai.jupyter
        pkgs.vscode-extensions.ms-toolsai.datawrangler
        pkgs.vscode-extensions.ms-python.vscode-pylance
        pkgs.vscode-extensions.github.vscode-github-actions
      ];
      services.easyeffects.enable = true;

      home.stateVersion = "24.11";

      programs.home-manager.enable = true;
    }
    {{</details>}}

When the above configs updated, ensure to rebuild the system to create new generations.
```bash
sudo nixos-rebuild switch --flake /etc/nixos/
```
Using the above configs, I can replicate the configs to multiple workstations with consistent results! With this, no more managing playbooks or cookbook. I can also rollback to any previous generations in case of misconfigurations happened.