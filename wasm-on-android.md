# Use Substrate wasm on Android

## Compile rust for android platform

### Background

#### Rustup

When you first install a toolchain, rustup installs only the standard library for your host platform - that is, the architecture and operating system you are presently running. To compile to other platforms you must install other target platforms. This is done with the `rustup target add` command. For example, to add the Android target:

```shell
$ rustup target add aarch64-linux-android
$ rustup target add armv7-linux-androideabi
$ rustup target add i686-linux-android

info: downloading component 'rust-std' for 'arm-linux-androideabi'
info: installing component 'rust-std' for 'arm-linux-androideabi'
```

With the `arm-linux-androideabi` target installed you can then build for Android with Cargo by passing the `--target` flag, as in `cargo build --target=arm-linux-androideabi`.

Note that `rustup target add` only installs the Rust standard library
for a given target. There are typically other tools necessary to
cross-compile, particularly a linker. For example, to cross compile
to Android the [Android NDK] must be installed. In the future, `rustup`
will provide assistance installing the NDK components as well.

[Android NDK]: https://developer.android.com/tools/sdk/ndk/index.html

To install a target for a toolchain that isn't the default toolchain
use the `--toolchain` argument of `rustup target add`, like so:

```console
$ rustup target add --toolchain <toolchain> <target>...
```

To see a list of available targets, `rustup target list`. To remove a
previously-added target, `rustup target remove`.




## Linux

```shell
rustup update nightly 

rustup target add aarch64-linux-android
rustup target add armv7-linux-androideabi
rustup target add i686-linux-android

rustup update

```

then build stand alone toolchain 
