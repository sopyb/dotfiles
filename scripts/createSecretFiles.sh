#!/usr/bin/env bash
set -euo pipefail

# General
SECRETS_DIR=/var/lib/secrets
AUTHELIA_DIR="$SECRETS_DIR/authelia"

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

# Authelia
gen_secret  "$AUTHELIA_DIR/jwt"          authelia authelia 400
gen_secret  "$AUTHELIA_DIR/session"      authelia authelia 400
gen_secret  "$AUTHELIA_DIR/storage"      authelia authelia 400
gen_secret  "$AUTHELIA_DIR/oidc-hmac"    authelia authelia 400
gen_rsa     "$AUTHELIA_DIR/oidc-issuer"  authelia authelia 400