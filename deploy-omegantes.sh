#!/usr/bin/env bash
set -e

TARGET_HOST=$1

function log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "Starting deployment to omegantes at $TARGET_HOST"

log "Copying configuration to remote host..."
rsync -avz --exclude '.git/' --exclude 'result/' ./ $TARGET_HOST:/tmp/nixos-config/

log "Building configuration on remote host..."
ssh $TARGET_HOST "cd /tmp/nixos-config && sudo nixos-rebuild switch --flake '.#omegantes' --show-trace"

log "Deployment completed successfully!"