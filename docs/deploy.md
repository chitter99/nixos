# Deploying a New NixOS Host

Guide for adding a new host to this flake and deploying it remotely over SSH. Covers dual-boot scenarios where the disk is shared with Windows.

## Prerequisites

- An existing NixOS machine with this repo cloned at `~/git/nixos`
- A NixOS minimal ISO on a USB stick (match the nixpkgs version in `flake.nix`)
- Network connectivity between the two machines (ethernet is simplest)

## 1. Add the Host to the Flake

### config.nix

Add a new entry under `hosts`:

```nix
myhost = {
  inherit system username;
  options = {
    nvidia = true;       # or false
    powersave = false;    # true for laptops
    theme = "aurora";
  };
};
```

For special hardware modules (e.g., nixos-hardware), use the `modules` field:

```nix
modules = [ nixos-hardware.nixosModules.some-module ];
```

### hosts/\<hostname\>/default.nix

```nix
{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];
  console.keyMap = lib.mkForce "us";
  services.openssh.enable = true;  # for remote management
}
```

### hosts/\<hostname\>/hardware-configuration.nix

Create a minimal version with by-label filesystem references. The labels are set when formatting the partitions (step 3).

```nix
{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];  # or kvm-intel

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";  # existing EFI partition
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
```

**Important:** Do not add `fileSystems` entries if using disko — disko generates them. The above is for manual partition setups (e.g., dual-boot with Windows).

## 2. Prepare the Target Disk (Dual-Boot with Windows)

### From Windows

1. Open Disk Management (`diskmgmt.msc`)
2. Right-click the Windows partition > Shrink Volume
3. Free up enough space for NixOS (100GB+ recommended)

### Boot the NixOS ISO

1. Boot from the NixOS USB
2. Connect to the network
3. Set root password and verify SSH:
   ```bash
   sudo passwd
   systemctl status sshd
   ip addr  # note the IP
   ```

### Partition and Format (from the live ISO or over SSH)

```bash
# Check current layout
lsblk -f

# Identify the free space and create a partition
# Replace <start> <end> with actual values from lsblk/parted print
parted /dev/nvme0n1 mkpart primary ext4 <start> 100%

# Format with the label matching hardware-configuration.nix
mkfs.ext4 -L nixos /dev/nvme0n1pN   # replace N with partition number

# Mount
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/BOOT /mnt/boot  # existing Windows EFI partition
```

**Note:** Check the EFI partition label with `lsblk -f`. If it doesn't have the label `BOOT`, either relabel it (`fatlabel /dev/nvme0n1p1 BOOT`) or update `hardware-configuration.nix` to use `by-uuid` instead.

## 3. Deploy

### Stage the new files (required for flake evaluation)

```bash
cd ~/git/nixos
git add hosts/<hostname>/ config.nix
```

### Option A: Use the deploy script

```bash
./scripts/deploy.sh <hostname> <target-ip>
```

This builds locally, copies the closure over SSH, and runs `nixos-install` on the target.

### Option B: Manual steps

```bash
# Build locally
nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel

# Copy to target
nix copy --to ssh://root@<ip> .#nixosConfigurations.<hostname>.config.system.build.toplevel

# Install on target
SYSTEM=$(nix path-info .#nixosConfigurations.<hostname>.config.system.build.toplevel)
ssh root@<ip> "nixos-install --system $SYSTEM --no-root-password"
```

### Reboot

The target reboots into systemd-boot, which auto-detects both NixOS and Windows.

## 4. Post-Install

1. **Log in** with user `arsch` (initial password: `123456`) and change the password immediately

2. **Clone the repo** for day-to-day rebuilds:
   ```bash
   mkdir -p ~/git && cd ~/git
   git clone git@github.com:<user>/nixos.git
   ```

3. **Refine hardware config** with actual detected modules:
   ```bash
   nixos-generate-config --show-hardware-config > /tmp/hw.nix
   ```
   Compare with `hosts/<hostname>/hardware-configuration.nix` and update as needed (kernel modules, firmware, etc.)

4. **Rebuild** to pick up any hardware config changes:
   ```bash
   nh os switch
   ```

## Troubleshooting

### Wrong EFI partition label

If `/boot` fails to mount, check the actual label:
```bash
lsblk -f
```
Either relabel the partition (`fatlabel /dev/nvme0n1p1 BOOT`) or switch to `by-uuid` in `hardware-configuration.nix`.

### NVIDIA not loading

Verify the driver is active:
```bash
nvidia-smi
```
If it fails, check that `hostOptions.nvidia = true` is set in `config.nix` and rebuild.

### SSH not available after install

Ensure `services.openssh.enable = true;` is in the host's `default.nix` and rebuild.

### Build fails with "file not found"

Nix flakes only see git-tracked files. Run `git add` on any new files before building.
