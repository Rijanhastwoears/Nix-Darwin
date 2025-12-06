# configuration.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # --- Home Manager ---
    # ./modules/home-manager/rijan.nix
  ];

  # Nix Configuration
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false; # Auto-installed by Determinate Systems

  # Creating a system user for the user
  users.users.rijan = {
    name = "rijan";
    home = "/Users/rijan";
  };

  # Home Manager Setup
  home-manager.users.rijan = import ./modules/home-manager/rijan.nix;

  # Shell Configuration
  programs.fish.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    # vim
    # wget
  ];

  # System Defaults (macOS specific)
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
