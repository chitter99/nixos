# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A NixOS flake-based system configuration managing multiple hosts with shared modules, Hyprland desktop, and home-manager integration.

## Common Commands

```bash
# Build and switch to new configuration (nh is configured with this flake path)
nh os switch

# Build without switching
nh os build

# Build a specific host directly with nix
nix build .#nixosConfigurations.hestia.config.system.build.toplevel

# Check flake evaluates correctly
nix flake check

# Update flake inputs
nix flake update

# Format nix files (configured via devenv pre-commit hook)
nix fmt
```

## Architecture

### Host Resolution Flow

`flake.nix` delegates to `outputs.nix`, which reads `config.nix` to build `nixosConfigurations`. For each host defined in `config.nix`:

1. `config.nix` defines per-host metadata: `system`, `username`, `options` (nvidia, powersave, theme), and optional extra `modules`
2. `outputs.nix` merges host options with `defaultHostOptions`, passes them as `specialArgs` (`hostname`, `username`, `hostOptions`), and builds via `nixpkgs.lib.nixosSystem`
3. The root `default.nix` imports `./assets`, `./hosts`, `./modules`, `./users` — all hosts share the same module tree

### Key specialArgs Available Everywhere

- `hostname` — used by `hosts/default.nix` to conditionally import host-specific overrides
- `username` — used throughout for user-specific config (shell, home-manager, groups)
- `hostOptions` — an attrset with `nvidia`, `powersave`, `theme` flags that conditionally toggle modules
- All flake inputs are also passed as specialArgs

### Conditional Module Loading

Several modules use `hostOptions` to toggle features:
- `modules/hardware/default.nix` — includes `nvidia.nix` only when `hostOptions.nvidia = true`
- `modules/core/default.nix` — includes `powersave.nix` only when `hostOptions.powersave = true`
- `modules/themes/default.nix` — loads theme directory matching `hostOptions.theme` (e.g., "aurora")

### Dotfiles Pattern

Hyprland and theme configs use a `dots/` convention: raw config files live in `dots/` subdirectories and are deployed to `~/.config/` via `home.file`. Themes can override module defaults using `lib.mkForce` (e.g., aurora overrides waybar config/style).

Hyprland config sources `~/.config/hypr/theme.conf` at the end, allowing themes to overlay appearance settings.

### Current Hosts

- **hestia** — Framework 13 AMD 7040, uses `nixos-hardware` module, powersave enabled
- **gaia** — powersave enabled, no extra hardware modules

### Adding a New Host

1. Add entry to `config.nix` under `hosts` with `system`, `username`, `options`, and optional `modules`
2. Create `hosts/<hostname>/default.nix` with `hardware-configuration.nix` (from `nixos-generate-config`)
3. Host-specific overrides go in that directory; shared config stays in `modules/`

## Nix Conventions in This Repo

- `devenv.nix` enables `nixfmt` as a pre-commit hook — all Nix files should be formatted with nixfmt
- The flake path is hardcoded to `/home/arsch/git/nixos` in the nh module
- `system.stateVersion` is `"23.05"` — do not change this
