{ config, pkgs, ... }:
let
  # nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  #     export __NV_PRIME_RENDER_OFFLOAD=1
  #     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #     export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #     export __VK_LAYER_NV_optimus=NVIDIA_only
  #     exec -a "$0" "$@"
  # '';
in {

  hardware.opengl = {
    enable = true;

    extraPackages = with pkgs; [
      # linuxPackages.nvidia_x11.out
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport = true;
    driSupport32Bit = true;

    # extraPackages32 = with pkgs; [ linuxPackages.nvidia_x11.lib32 ];
  };

  services.xserver = {
    enable = true;

    autorun = false;
    exportConfiguration = true;
    layout = "us";
    videoDrivers = [ "intel" ];
    # libinput.enable = true;
    # desktopManager.default = "none"; # disable desktop manager
    # displayManager.startx.enable = true;
  };

  # nixpkgs.config.size = 150;

  environment.variables = {
    GDK_DPI_SCALE = "1.5";
    GDK_SCALE = "1.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
    XCURSOR_SIZE = "64";
  };

  #services.xserver.displayManager.startx.enable = true;

  # NVIDIA
  #hardware.bumblebee.enable = true;
  #hardware.bumblebee.connectDisplay = true;
  # environment.systemPackages = with pkgs; [
  #    	nvidia-offload
  #    ];

  # services.xserver.videoDrivers = [ "nvidia" ];

  # # services.xserver.videoDrivers = [ "nvidia" ];

  # hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.prime = {
  # 	# sync.enable = true;
  # 	offload.enable = true;
  # 	intelBusId = "PCI:0:2:0";
  # 	nvidiaBusId = "PCI:1:0:0";
  # };

  # INTEL
  #services.xserver.videoDrivers = [ "intel" ];
}
