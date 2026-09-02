#!/bin/bash

set -eu

curl_ua="Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/118.0"

self=$(readlink -f "$0")
here=${self%/*}
root_dir=$(dirname "${here}")
dist_dir="${root_dir}/dist"

app_version=$1
app_release=$2
container_name="android-studio-appimage"
work_dir="/android-studio-appimage"

# Android Studio tarballs no longer embed the version in the filename (e.g.
# `android-studio-2026.1.4.7-linux.tar.gz`). They use a code name instead
# (e.g. `android-studio-quail4-linux.tar.gz`). Resolve the actual tarball
# filename for the given release by scraping the relevant page.
resolve_tarball() {
    local page_url=$1
    local version=$2
    local filename
    filename=$(curl --fail -s -A "${curl_ua}" "${page_url}" \
        | grep -oE "ide-zips/${version}/android-studio-[a-zA-Z0-9_-]+-linux\\.tar\\.gz" \
        | head -n 1 \
        | sed -E "s#^ide-zips/${version}/##")
    if [ -z "${filename}" ]; then
        echo "error: could not resolve Android Studio tarball filename for version ${version} on ${page_url}" >&2
        exit 1
    fi
    echo "${filename}"
}

case "${app_release}" in
"stable")
    tarball=$(resolve_tarball "https://developer.android.com/studio" "${app_version}")
    ;;
"beta")
    tarball=$(resolve_tarball "https://developer.android.com/studio/preview" "${app_version}")
    ;;
*)
    echo "Unknown release type: ${app_release}"
    exit 1
    ;;
esac

echo "Resolved tarball: ${tarball}"

echo "Starting container..."
podman run --rm -dti --name "${container_name}" docker.io/library/ubuntu:22.04
podman wait --condition=running "${container_name}"

echo "Installing dependencies..."
podman exec "${container_name}" apt update
podman exec "${container_name}" apt-get install -y curl desktop-file-utils imagemagick file

# Copy files
echo "Copying necessities..."
podman exec "${container_name}" mkdir "${work_dir}"
for x in "scripts" "templates"; do
    podman cp "./${x}" "${container_name}:${work_dir}/${x}"
done
podman exec "${container_name}" find "${work_dir}/scripts" -type f -name "*.sh" -exec chmod +x {} \;

# Ensure appimagetool architecture env
podman exec "${container_name}" bash -lc "export ARCH=x86_64; ${work_dir}/scripts/build.sh ${app_version} ${app_release} ${tarball}"

echo "Copying build artifacts..."
podman cp "${container_name}:${work_dir}/dist" "${dist_dir}"

echo "Stopping container..."
podman stop "${container_name}"

echo "Done!"
