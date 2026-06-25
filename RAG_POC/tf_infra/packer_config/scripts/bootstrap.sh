#!/usr/bin/env bash
set -e

REQUIRED_PACKAGES=(
  git
  vim
  curl
  wget
  unzip
  jq
  tree
  python3
  python3-pip
  python3-venv
  postgresql
  postgresql-contrib
  build-essential
  libpq-dev
)

sudo apt-get update


for package in "${REQUIRED_PACKAGES[@]}"; do
  if dpkg -s "$package" >/dev/null 2>&1; then
    echo "[OK] $package is already installed"
  else
    echo "[INSTALL] $package"
    sudo apt-get install -y "$package"
  fi
done

mkdir ~/rag_poc
cd ~/rag_poc
python3 -m venv .venv
source .venv/bin/activate 
pip install -r /tmp/requirements.txt