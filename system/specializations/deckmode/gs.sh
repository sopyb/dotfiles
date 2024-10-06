#!/usr/bin/env bash
set -xeuo pipefail

gamescopeArgs=(
    --adaptive-sync # VRR support
    --hdr-enabled
    # -m # performance overlay
    --rt
    --steam
    --generate-drm-mode fixed
)
steamArgs=(
    -pipewire-dmabuf
    -tenfoot
    # -steamos
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

export "${mangoVars[@]}"
export ENABLE_GAMESCOPE_WSI=1
exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}" && echo "fuck fuck fuck fuck fuck fuck \n\n\n\n\n" > log.txt
