# Nix Home Manager Dotfiles

This is my [Nix](https://nixos.org/) [home-manager](https://github.com/nix-community/home-manager) [dotfiles](https://dotfiles.github.io/) repository using a [flake](https://nixos.wiki/wiki/Flakes).
I run this over a [Fedora Atomic Desktop](https://fedoraproject.org/atomic-desktops/), providing an immutable base for my system.
I build [custom images](https://github.com/marc0der/atomic-sway) of the Sway variant using [Blue Build](https://blue-build.org/) to add and remove packages from the base image.

## Bootstrapping a new system

* Install an atomic desktop on your system. In my case, I prefer the [sway edition](https://fedoraproject.org/atomic-desktops/sway/).
* Install the Nix package manager on the system:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
    sh -s -- install ostree --no-confirm --persistence=/var/lib/nix
echo "Defaults  secure_path = /nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:$(sudo printenv PATH)" | sudo tee /etc/sudoers.d/nix-sudo-env
```

* Add `nixpkgs` and `home-manager` channels:

```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

* Install `home-manager`:

```bash
nix-shell '<home-manager>' -A install
```

* Clone this repository, then run the following command from within the `dotfiles` directory:

```bash
home-manager switch --flake .
```

This will publish all the dotfiles to the `/nix` store and place symlinks to these files in your home directory.
If the files already exist, you will be asked to remove them, as home-manager will not overwrite them.
