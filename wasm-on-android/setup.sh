#! /bin/bash

# based on https://github.com/kennytm/rust-ios-android

set -euo pipefail

if [ -d NDK ]; then
    printf '\e[33;1mStandalone NDK already exists... Delete the NDK folder to make a new one.\e[0m\n\n'
    printf '$ rm -rf NDK\n'
    exit 0
fi

MAKER="$NDK_HOME/build/tools/make_standalone_toolchain.py"

if [ -x "$MAKER" ]; then
    echo 'Creating standalone NDK...'
else
    printf 'Please install android-ndk\n\n'
    printf 'from https://developer.android.com/ndk/downloads or with sdkmanager'
    exit 1
fi

mkdir NDK

sdkVersion=$(( $# >= 1 ? $1 : 29 ))  

for ARCH in arm64 arm x86; do
    echo "($ARCH)..."
    "$MAKER" --arch $ARCH --install-dir "NDK/$ARCH" --api sdkVersion
done

echo 'Updating ./rust/.cargo/config.toml...'

#  set up custom linker if rust uses C libraries

cd ..
mkdir -p ../rust/.cargo
sed 's|$PWD|'"${PWD}"'|g' config.toml.template > ./../rust/.cargo/config


