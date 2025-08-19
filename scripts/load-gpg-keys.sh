#!/usr/bin/env bash

# Ensure public.asc and private.asc exist in the current directory
if [[ ! -f public.asc || ! -f private.asc ]]; then
  echo "Error: public.asc and private.asc must exist in the current directory."
  exit 1
fi

export GPG_PUBLIC_KEY=$(gpg --import-options show-only --with-colons --import public.asc | awk -F: '/^fpr:/ {print $10; exit}')
export GPG_PRIVATE_KEY=$(cat private.asc)
echo "GPG_PUBLIC_KEY: $GPG_PUBLIC_KEY"
echo "GPG_PRIVATE_KEY: <redacted ${#GPG_PRIVATE_KEY} bytes>"
