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
    --prefer-vk-device 10de:2520
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

export VK_DRIVER_FILES="/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json"

export WLR_LIBINPUT_NO_DEVICES=1
export "${mangoVars[@]}"
export ENABLE_GAMESCOPE_WSI=1

exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}"
# steam
