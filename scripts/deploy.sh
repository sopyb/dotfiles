#!/usr/bin/env bash
set -euo pipefail

ROOT=$(git rev-parse --show-toplevel)
SYSTEM=$1
TARGET_HOST=$2

function log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "Starting deployment to $SYSTEM at $TARGET_HOST"

log "Creating temp directory on remote host..."
REMOTE_DIR=$(ssh "$TARGET_HOST" "mktemp -d")
log "Using remote directory: $REMOTE_DIR"

log "Copying configuration to remote host..."
rsync -avz --filter=':- .gitignore' --exclude '.git/' $ROOT/ $TARGET_HOST:$REMOTE_DIR/

log "Building configuration on remote host..."
ssh -t $TARGET_HOST "cd $REMOTE_DIR && sudo nixos-rebuild switch --flake '.#$SYSTEM' --show-trace --verbose"

log "Cleaning up files on remote host..."
ssh $TARGET_HOST "rm -rf $REMOTE_DIR"

log "Deployment completed successfully!"