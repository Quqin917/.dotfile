{ pkgs, lib, ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";

    powertop.enable = true;
  };

  services = { 
    thermald.enable = true;

    system76-scheduler = {
      enable = true;
      settings.cfsProfiles.enable = true;
    };

    udev.extraRules = lib.mkAfter ''
      ACTION=="add", SUBSYSTEM=="platform", KERNEL=="VPC2004:00", \
      RUN+="${pkgs.runtimeShell} -c 'echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'"
    '';
  };

  programs.auto-cpufreq = {
    enable = true;

    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };

      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
