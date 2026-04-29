#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <hostname> <target-ip>"
  echo ""
  echo "Deploy a NixOS configuration to a target machine over SSH."
  echo "The target must be booted into a NixOS live ISO with SSH enabled"
  echo "and filesystems mounted at /mnt."
  echo ""
  echo "Example: $0 titan 192.168.1.42"
  exit 1
}

[[ $# -ne 2 ]] && usage

HOST="$1"
TARGET="$2"

FLAKE=".#nixosConfigurations.${HOST}.config.system.build.toplevel"

echo "==> Checking target is reachable..."
ssh -o ConnectTimeout=5 "root@${TARGET}" "mountpoint -q /mnt" \
  || { echo "ERROR: /mnt is not mounted on target. Partition and mount first."; exit 1; }

echo "==> Building ${HOST} locally..."
nix build "${FLAKE}"

SYSTEM_PATH=$(nix path-info "${FLAKE}")
echo "==> Closure: ${SYSTEM_PATH}"

echo "==> Copying closure to target..."
nix copy --to "ssh://root@${TARGET}" "${FLAKE}"

echo "==> Installing on target..."
ssh "root@${TARGET}" "nixos-install --system ${SYSTEM_PATH} --no-root-password"

echo "==> Done! Reboot the target machine."
