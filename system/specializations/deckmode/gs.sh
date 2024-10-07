a#!/usr/bin/env bash
set -xeuo pipefail

gamescopeArgs=(
    --adaptive-sync # VRR support
    --hdr-enabled
    -m # performance overlay
    --disable-idle
    --rt
    --steam
    --force-composition
    --generate-drm-mode fixed
)
steamArgs=(
    -pipewire-dmabuf
    -tenfoot
    -steamos
)
mangoConfig=(
    cpu_temp
    gpu_temp
    ram
    vram
)
mangoVars=(
    MANGOHUD=1
    MANGOHUD_CONFIG="$(IFS=,; echo "${mangoConfig[*]}")"
)

export PrefersNonDefaultGPU=true
export WLR_LIBINPUT_NO_DEVICES=1
export "${mangoVars[@]}"
export ENABLE_GAMESCOPE_WSI=1

exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}"
