{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/common.nix
  ];

  hardware.graphics = {
    # Enable 64-bit support
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-media-sdk
    ];

    # Enable 32-bit support (for Wine)
    enable32Bit = true;
    extraPackages32 = with pkgs.driversi686Linux; [
      intel-vaapi-driver
      intel-media-driver
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];
  # If you have screen tearing - comment a line above and uncomment these ones (note that
  # it is going to produce less performance):
  # services.xserver.videoDrivers = [ "intel" ];
  #   services.xserver.deviceSection = ''
  #   Option "DRI" "2"
  #   Option "TearFree" "true"
  # '';

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = "nixos";

  system.stateVersion = "25.05";
}
