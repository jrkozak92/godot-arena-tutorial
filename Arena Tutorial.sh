#!/bin/sh
echo -ne '\033c\033]0;Arena Tutorial\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Arena Tutorial.arm64" "$@"
