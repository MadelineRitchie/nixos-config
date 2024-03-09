{ pkgs, ... }:
let
  hostCores = "0-7,16-23";
  totalCores = "0-31";
in
  {
    virtualisation = {
      libvirtd = {
        onBoot = "ignore";
        onShutdown = "shutdown";

        deviceACL = [
          "/dev/vfio/vfio"
          "/dev/kvm"
          "/dev/kvmfr0"
          "/dev/null"
        ];

        qemu.domains = {
          declarative = true;
          domains = {
            win10 = {
              config = {
                memory = {
                  memory = {
                    value = 32;
                    unit = "G";
                  };

                  disableBallooning = true;
                  useHugepages = false;
                };
                vcpu = {
                  count = 16;
                  placement = "static";
                };
                cpu = {
                  mode = "host-passthrough";
                  topology = {
                    sockets = 1;
                    dies = 1;
                    cores = 8;
                    threads = 2;
                  };
                };
                spice = {
                  spiceAudio = true;
                  spicemvcChannel = true;
                  spiceGraphics = true;
                };
                kvmfr = {
                  device = "/dev/kvmfr0";
                  size = "268435456";
                };
                cputune = {
                  vcpupins = [
                    { vcpu = 0; cpuset = [ 8 ]; }
                    { vcpu = 1; cpuset = [ 24 ]; }
                    { vcpu = 2; cpuset = [ 9 ]; }
                    { vcpu = 3; cpuset = [ 25 ]; }
                    { vcpu = 4; cpuset = [ 10 ]; }
                    { vcpu = 5; cpuset = [ 26 ]; }
                    { vcpu = 6; cpuset = [ 11 ]; }
                    { vcpu = 7; cpuset = [ 27 ]; }
                    { vcpu = 8; cpuset = [ 12 ]; }
                    { vcpu = 9; cpuset = [ 28 ]; }
                    { vcpu = 10; cpuset = [ 13 ]; }
                    { vcpu = 11; cpuset = [ 29 ]; }
                    { vcpu = 12; cpuset = [ 14 ]; }
                    { vcpu = 13; cpuset = [ 30 ]; }
                    { vcpu = 14; cpuset = [ 15 ]; }
                    { vcpu = 15; cpuset = [ 31 ]; }
                  ];
                };
                input = {
                  virtioMouse = true;
                  virtioKeyboard = true;
                };
                pciHostDevices = [
                  {
                    sourceAddress = {
                      bus = "0x02";
                      slot = "0x00";
                      function = 0;
                    };

                    bootIndex = 1;
                  }
                  {
                    sourceAddress = {
                      bus = "0x01";
                      slot = "0x00";
                      function = 0;
                    };
                  }
                  {
                    sourceAddress = {
                      bus = "0x01";
                      slot = "0x00";
                      function = 1;
                    };
                  }
                ];

              };
            };
          };
        };

        # scopedHooks.qemu = {
        #   "10-activate-core-isolation" = {
        #     enable = true;
        #     scope = {
        #       objects = [ "win10" ];
        #       operations = [ "prepare" ];
        #     };
        #     script = ''
        #       systemctl set-property --runtime -- user.slice AllowedCPUs=${hostCores}
        #       systemctl set-property --runtime -- system.slice AllowedCPUs=${hostCores}
        #       systemctl set-property --runtime -- init.scope AllowedCPUs=${hostCores}
        #     '';
        #   };

        #   "10-deactivate-core-isolation" = {
        #     enable = true;
        #     scope = {
        #       objects = [ "win10" ];
        #       operations = [ "release" ];
        #     };
        #     script = ''
        #       systemctl set-property --runtime -- user.slice AllowedCPUs=${totalCores}
        #       systemctl set-property --runtime -- system.slice AllowedCPUs=${totalCores}
        #       systemctl set-property --runtime -- init.scope AllowedCPUs=${totalCores}
        #     '';
        #   };
        # };
      };

      vfio = {
        enable = true;
        IOMMUType = "amd";
        devices = [
          "10de:2684"
          "10de:22ba"
        ];
        blacklistNvidia = true;
        disableEFIfb = true;
        ignoreMSRs = true;
      };

      kvmfr = {
        enable = true;

        devices = [
          {
            resolution = {
              width  = 7680;
              height = 2160;
              pixelFormat = "rgba32";
            };

            permissions = {
              user = "madeline";
              group = "qemu-libvirtd";
              mode = "0660";
            };
          }
        ];
      };
    };
  }

