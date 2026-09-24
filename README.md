# Android Studio AppImages

[![Release](https://github.com/Rin247/android-studio-appimages/actions/workflows/release.yml/badge.svg)](https://github.com/Rin247/android-studio-appimages/actions/workflows/release.yml)

Packages [Android Studio](https://developer.android.com/studio) as AppImages.

AppImages are directly created from `.tar.gz` builds and are not decompiled or modified. AppImages are compiled in Ubuntu 24.04 (minimum). Only stable, release-ready builds are packaged — preview, beta, canary and release-candidate (RC) builds are intentionally skipped.

## Supported Builds

-   AMD64

## Installation

### Manual

Can be directly downloaded from Github Releases and integrated using tools like AppImageLauncher.

## Minimum distribution support

This project builds AppImages using an Ubuntu 24.04 (noble) chroot/container as the minimum supported build environment. Support for older distributions (Ubuntu 22.04 and earlier) has been removed.

## Arch Linux

Run the distributed AppImage directly on Arch. AppImages produced by this project bundle required libraries so they should run on Arch Linux; use AppImageLauncher or run the file directly (make it executable and execute). For a packaged version, use the [`android-studio`](https://aur.archlinux.org/packages/android-studio) package from the AUR.

## Building locally

There are helper scripts in `scripts/` that build AppImages in a containerized environment. The `scripts/build-podman.sh` script uses an Ubuntu 24.04 container by default to produce AppImages. See the scripts for details.
