# Android Studio AppImages

[![Latest](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fzyrouge%2Fandroid-studio-appimages%2Fdist-badges%2Fbadge-latest.json)](https://github.com/zyrouge/android-studio-appimages)
[![Latest (Pre-release)](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fzyrouge%2Fandroid-studio-appimages%2Fdist-badges%2Fbadge-prerelease.json)](https://github.com/zyrouge/android-studio-appimages)
[![Release](https://github.com/zyrouge/android-studio-appimages/actions/workflows/release.yml/badge.svg)](https://github.com/zyrouge/android-studio-appimages/actions/workflows/release.yml)
[![Badges](https://github.com/zyrouge/android-studio-appimages/actions/workflows/badges.yml/badge.svg)](https://github.com/zyrouge/android-studio-appimages/actions/workflows/badges.yml)

Packages [Android Studio](https://developer.android.com/studio) and [Android Studio Preview](https://developer.android.com/studio/preview) as AppImages.

AppImages are directly created from `.tar.gz` builds and are not decompiled or modified. AppImages are compiled in Ubuntu 22.04 (minimum). Latest releases contain stable version and pre-releases contain beta builds.

## Supported Builds

-   AMD64

## Installation

### Pho

This command requires [Pho](https://github.com/zyrouge/pho) to be installed.

```bash
# stable
pho install github --id android-studio zyrouge/android-studio-appimages

# beta
pho install github --release prerelease --id android-studio zyrouge/android-studio-appimages
```

### Manual

Can be directly downloaded from Github Releases and integrated using tools like AppImageLauncher.

## Minimum distribution support

This project builds AppImages using an Ubuntu 22.04 (jammy) chroot/container as the minimum supported build environment. The CI matrix includes Ubuntu 22.04 and newer (24.04, 26.04) to ensure the produced AppImages remain compatible with modern distributions. Support for older distributions (Ubuntu 20.04 and earlier) has been removed.

## Arch Linux

Two options are provided for Arch users:

- Run the distributed AppImage directly on Arch. AppImages produced by this project bundle required libraries so they should run on Arch Linux; use AppImageLauncher or run the file directly (make it executable and execute).
- Build a native Arch package using the provided PKGBUILD (see `arch/PKGBUILD`). The PKGBUILD downloads the upstream Android Studio tarball and installs it under `/opt/android-studio` so you can manage it with your package manager.

To build the Arch package locally:

```bash
git clone https://github.com/Rin247/android-studio-appimages.git
cd android-studio-appimages/arch
makepkg -si
```

## Building locally

There are helper scripts in `scripts/` that can build AppImages in a containerized environment. The `scripts/build-podman.sh` script uses an Ubuntu 22.04 container by default to produce AppImages. See the scripts for details.


