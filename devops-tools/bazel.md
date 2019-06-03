# bazel

## Install bazel

```bash
cd src/
curl -L -O https://github.com/bazelbuild/bazel/releases/download/0.26.0/bazel-0.26.0-installer-linux-x86_64.sh
chmod +x bazel-0.26.0-installer-linux-x86_64.sh
sudo apt-get install pkg-config zip g++ zlib1g-dev unzip python
sudo apt autoremove
./bazel-0.26.0-installer-linux-x86_64.sh --user
# Add export PATH="$PATH:$HOME/bin" to .zshrc
```

In order to compile Envoy, I needed to install an older version of `bazel`. To do that, all I did was to make sure I downloaded the right version of the installer script:

```bash
curl -L -O https://github.com/bazelbuild/bazel/releases/download/0.22.0/bazel-0.22.0-installer-linux-x86_64.sh
```
