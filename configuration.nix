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
  users.users.zr4 = {
    name = "zr4";
    home = "/Users/zr4";
    uid = 502;
  };

  # Home Manager Setup
  home-manager.users.zr4 = import ./modules/home-manager/rijan.nix;

  # Shell Configuration
  programs.fish.enable = true;
  
  # Ensure Homebrew is in the path
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];

  # System Defaults (macOS specific)
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
  };
  
  # Set the primary user of the system
  nix.settings.trusted-users = [ "root" "zr4" ];
  users.knownUsers = [ "zr4" ];
  # Required by recent nix-darwin checking
  # Use the username of the primary user
  # This avoids the "system activation must now be run as root" error conflicts
  # with user-specific preferences
  system.primaryUser = "zr4";  

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

