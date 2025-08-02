{ pkgs, config, ... }:

{
  # Enable OpenGL
  hardware.graphics.enable = true;

  # Loads Nvidia dedicated driver and Inter integrated driver
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = { 
    open = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;

    modesetting.enable = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };

    powerManagement = {
      enable = true;
      finegrained = true;
    };
  };
}
