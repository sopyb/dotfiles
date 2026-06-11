#!/usr/bin/env bash
# Based on EC register documentation from https://github.com/alou-S/omen-fan
set -euo pipefail

readonly FAN1_MAX=49
readonly FAN2_MAX=47
readonly INTERVAL=30

readonly EC_MEM="/sys/kernel/debug/ec/ec0/io"

readonly EC_BIOS_CTRL=0x62
readonly EC_TIMER=0x63
readonly EC_PERFORMANCE=0x95

readonly EC_FAN1_RPM=0x34
readonly EC_FAN2_RPM=0x35

ec_write() {
    printf "\\x$(printf '%02x' $2)" | dd of="$EC_MEM" bs=1 count=1 seek=$(($1)) conv=notrunc 2>/dev/null
}

restore() {
    echo
    echo "Restoring BIOS fan control..."
    ec_write "$EC_BIOS_CTRL" 0x00
    exit 0
}

trap restore SIGINT SIGTERM

while true; do
    ec_write "$EC_BIOS_CTRL" 0x06
    ec_write "$EC_PERFORMANCE" 0x01

    ec_write "$EC_FAN1_RPM" "$FAN1_MAX"
    ec_write "$EC_FAN2_RPM" "$FAN2_MAX"
    ec_write "$EC_TIMER" 0x78
    sleep "$INTERVAL"
done
