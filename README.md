# jetson-ppa
Build scripts and infrastructure to publish Jetson-optimized software to a custom apt repository.

# Usage

To use the software published in this repository, you need to add the repository to your apt sources. To do this, run the following commands (assuming Jetson R32.7):

```bash
wget -qO- https://repo.download.martian.ag/verdant-public-key.asc | sudo gpg --no-default-keyring --keyring /usr/share/keyrings/verdant.gpg --import
echo "deb [signed-by=/usr/share/keyrings/verdant.gpg] https://repo.download.martian.ag/jetson/common r32.7 main" | sudo tee /etc/apt/sources.list.d/verdant-ppa.list
sudo apt update
```

You can then upgrade to a recent OpenCV Jetson-optimized build with the following command:

```bash
sudo apt upgrade nvidia-jetpack
```

Or if you are only interested in OpenCV and do not have JetPack installed:

```bash
sudo apt install libopencv
```

# Development

Docker is the only dependency for the build process, and QEMU if you are not on an ARM64 machine.

```bash
./scripts/build.sh <jetson-r32 x64> <package-name>
```

Publishing requires `GPG_PUBLIC_KEY` and `GPG_PRIVATE_KEY` environment variables to be set. If you have `public.asc` and `private.asc` GnuPG keypair files, you can run `source scripts/load-gpg-keys.sh`.

```bash
$ source scripts/load-gpg-keys.sh
GPG_PUBLIC_KEY: 769C7415E2432C692083A9AE6EB98ECE6EA5E620
GPG_PRIVATE_KEY: <redacted 6650 bytes>
```

To publish a package, run:

```bash
./scripts/publish-<package_name>.sh <jetson-r32 x64>
```
