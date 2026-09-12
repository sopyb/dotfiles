#!/usr/bin/env nix-shell
#!nix-shell -i bash -p openssl coreutils
set -euo pipefail

# General
SECRETS_DIR=/var/lib/secrets
sudo install -d -m 770 -o root -g users $SECRETS_DIR

create_with_content() {
  local file="$1"
  local owner="$2"
  local group="$3"
  local mode="$4"
  local content="$5"
  if [ -f "$file" ]; then
    echo "skip($file): already exists"
    return
  fi
  sudo sh -c "umask 077; printf '%s\n' '$content' > '$file'"
  sudo chown "$owner:$group" "$file"
  sudo chmod "$mode" "$file"
  echo "created($file): don't be a dummy dum dum fill in your token :3"
}

gen_secret() {
  local file="$1"
  local owner="$2"
  local group="$3"
  local mode="$4"
  if [ -f "$file" ]; then
    echo "skip($file): already exists"
    return
  fi
  sudo sh -c "umask 077; openssl rand -hex 64 > '$file'"
  sudo chown "$owner:$group" "$file"
  sudo chmod "$mode" "$file"
  echo "created($file)"
}

gen_rsa() {
  local file="$1"
  local owner="$2"
  local group="$3"
  local mode="$4"
  if [ -f "$file" ]; then
    echo "skip($file): already exists"
    return
  fi
  sudo openssl genrsa -out "$file" 4096
  sudo chown "$owner:$group" "$file"
  sudo chmod "$mode" "$file"
  echo "created($file)"
}

# ACME
create_with_content "$SECRETS_DIR/cloudflare" acme acme 600 \
  "CLOUDFLARE_DNS_API_TOKEN="

# Authentik
create_with_content "$SECRETS_DIR/authentik" authentik authentik 600 \
"$(cat <<_EOF_
AUTHENTIK_SECRET_KEY=$(openssl rand -base64 60)
AUTHENTIK_EMAIL__PASSWORD=
_EOF_
)"