#!/usr/bin/env bash

VERSION="2.0.0"
ARCH=$(uname -sm)

function download {
    ARCHIVE=gotop_${VERSION}_${1}.tgz
    curl -LO https://github.com/cjbassi/gotop/releases/download/${VERSION}/${ARCHIVE}
    tar xf ${ARCHIVE}
    rm ${ARCHIVE}
}

function main {
    case "${ARCH}" in
        # order matters
        Darwin\ *64)        download darwin_amd64   ;;
        Darwin\ *86)        download darwin_386     ;;
        Linux\ armv5*)      download linux_arm5     ;;
        Linux\ armv6*)      download linux_arm6     ;;
        Linux\ armv7*)      download linux_arm7     ;;
        Linux\ armv8*)      download linux_arm8     ;;
        Linux\ aarch64*)    download linux_arm8     ;;
        Linux\ *64)         download linux_amd64    ;;
        Linux\ *86)         download linux_386      ;;
        *)
            echo "\
    No binary found for your system.
    Feel free to request that we prebuild one that works on your system."
            exit 1
            ;;
    esac
}

main
