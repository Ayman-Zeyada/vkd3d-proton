#!/bin/sh

set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
subproject_dir="$repo_dir/subprojects/dxil-spirv"
patch_file="$repo_dir/patches/dxil-spirv-disable-clip-cull-distance.patch"

if git -C "$subproject_dir" apply --check "$patch_file" 2>/dev/null; then
    git -C "$subproject_dir" apply "$patch_file"
    echo "Applied dxil-spirv clip/cull distance workaround."
elif git -C "$subproject_dir" apply --reverse --check "$patch_file" 2>/dev/null; then
    echo "dxil-spirv clip/cull distance workaround is already applied."
else
    echo "Cannot apply dxil-spirv clip/cull distance workaround." >&2
    exit 1
fi
