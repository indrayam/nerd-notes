# Envoy on Ubuntu Xenial and macOS Mojave: The Hard Way

## Table of Contents
- [General Notes](#gotchas)
- [Build Envoy on Ubuntu Xenial (16.04)](#build-envoy-on-ubuntu-xenial-1604)
- [Build Envoy on macOS Mojave (10.14.5)](#build-envoy-on-macos-mojave-10145)

## General Notes
- Start [here](https://github.com/envoyproxy/envoy/tree/master/bazel#building-envoy-with-bazel)!
- Using [Docker images](https://www.envoyproxy.io/docs/envoy/v1.10.0/start/start#quick-start-to-run-simple-example) to play with Envoy container is definitely doing "Envoy the Easy Way". I was interested in "Envoy the Hard Way" :wink:
- Another "Envoy The Easy Way" would be to refer to the steps documented here: [Developer use of CI Docker images](https://github.com/envoyproxy/envoy/blob/8d1ad35aa724962f64f7535531e408c9a93d364c/ci/README.md). Basically, assuming you have Docker installed on your machine, you run `IMAGE_NAME=envoyproxy/envoy-build-ubuntu ./ci/run_envoy_docker.sh './ci/do_ci.sh bazel.dev'` or `IMAGE_NAME=envoyproxy/envoy-build-ubuntu ./ci/run_envoy_docker.sh './ci/do_ci.sh bazel.release.server_only'` from within untarred (or cloned) folder. It definitely worked for me on Ubuntu! As I said, I was interested in "Envoy The Hard Way" :wink: 
- Not knowing [Bazel](https://docs.bazel.build/versions/master/build-ref.html) as a build tool made things **harder**. I personally benefitted by briefly scanning through these URLs. It's not necessary, but it will help:
   + [Bazel: Concepts and Terminology](https://docs.bazel.build/versions/master/build-ref.html)
   + [Bazel: Introduction to Bazel: Building a C++ Project](https://docs.bazel.build/versions/0.22.0/tutorial/cpp.html)
   + [Bazel: Installing Bazel on macOS](https://docs.bazel.build/versions/0.22.0/install-os-x.html)
- **DO NOT** download the Envoy binaries from the "Releases" section in GitHub and try compiling. The build process complained about not being inside a Git repo. The way I got around it is by downloading the version of the Envoy source code that was tagged with the version I was interested in. See installation steps below
- [Step 1](https://github.com/envoyproxy/envoy/issues/2181#issuecomment-378290320) of this GitHub issue thread documents another way to compile Envoy releases. Basically, download the Envoy Release tar gzipped file, untar it, create a SOURCE_VERSION file in `~/envoy/ci` sub-folder and put the Git Commit SHA of the Release. For example, Git Commit SHA of [v1.10.0](https://github.com/envoyproxy/envoy/releases/tag/v1.10.0) is [e95ef6bc43daeda16451ad4ef20979d8e07a5299](https://github.com/envoyproxy/envoy/commit/e95ef6bc43daeda16451ad4ef20979d8e07a5299). Where did I find this? Look to the top-right for the full Git Commit SHA

## Build Envoy on Ubuntu Xenial (16.04)

1. Install `go`:

```bash
# Install Go
# sudo add-apt-repository -y ppa:longsleep/golang-backports
# sudo apt-get -y update
# sudo apt-get install -y golang-go
# mkdir -p ${USER_HOME}/workspace/go-apps
## OR
export GOPATH=$HOME/workspace/go-apps
git clone https://github.com/udhos/update-golang
RELEASE=1.12 ./update-golang/update-golang.sh
RELEASE=1.12 sudo ./update-golang.sh
mkdir -p ${GOPATH}
```

Update PATH settings in your `.zshrc` (or `.bashrc`) to include the following:

```bash
export GOPATH=$HOME/workspace/go-apps
export PATH=${GOPATH}/bin:$PATH
```

Source the Zsh (or Bash) profile:

`source ~/.zshrc`

2. Install `jdk`:

```bash
# Install Java
apt-get -y install default-jdk
ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/local/java
```

3. Install [Buildifer](https://github.com/bazelbuild/buildtools)

```bash
go get -u github.com/bazelbuild/buildtools/buildifier
```

Add `BUILDIFIER_BIN` to your `.bashrc` (or `.zshrc`):

```bash
# Buildfier to format Bazel BUILD files
export BUILDIFIER_BIN="${GOPATH}/bin"
```

Source the Zsh (or Bash) profile:

`source ~/.zshrc`

4. Install Bazel version 0.22:

*NOTE*: Using the latest version (0.26) of Bazel gave errors.

```bash
cd src/
curl -L -O https://github.com/bazelbuild/bazel/releases/download/0.22.0/bazel-0.22.0-installer-linux-x86_64.sh
chmod +x bazel-0.26.0-installer-linux-x86_64.sh
sudo ./bazel-0.26.0-installer-linux-x86_64.sh
# This will install bazel in /usr/local/bin
```

Run `bazel version` to make sure it is running the correct version (v0.22.0):

```bash
WARNING: --batch mode is deprecated. Please instead explicitly shut down your Bazel server using the command "bazel shutdown".
INFO: Invocation ID: 425d090b-1c93-4501-bba6-ed2a704e1d68
Build label: 0.22.0
Build target: bazel-out/k8-opt/bin/src/main/java/com/google/devtools/build/lib/bazel/BazelServer_deploy.jar
Build time: Mon Jan 28 12:58:08 2019 (1548680288)
Build timestamp: 1548680288
Build timestamp as int: 154868028
```

5. Install the following External Dependencies

```bash
sudo apt-get install \
   libtool \
   cmake \
   clang-format-6.0 \
   automake \
   autoconf \
   make \
   ninja-build \
   curl \
   unzip \
   pkg-config \
   zip \
   g++ \
   zlib1g-dev \
   python \
   virtualenv
```

Here is the version I have running for each of the external dependencies:

```bash
apt show libtool \
   cmake \
   clang-format-6.0 \
   automake \
   autoconf \
   make \
   ninja-build \
   curl \
   unzip \
   pkg-config \
   zip \
   g++ \
   zlib1g-dev \
   python \
   virtualenv
```

gives the following output:

```
Package: libtool
Version: 2.4.6-0.1
...

Package: cmake
Version: 3.5.1-1ubuntu3
...

Package: clang-format-6.0
Version: 1:6.0-1ubuntu2~16.04.1
...

Package: automake
Version: 1:1.15-4ubuntu1
...

Package: autoconf
Version: 2.69-9
...

Package: make
Version: 4.1-6
...

Package: ninja-build
Version: 1.5.1-0.1ubuntu1
...

Package: curl
Version: 7.47.0-1ubuntu2.13
...

Package: unzip
Version: 6.0-20ubuntu1
...

Package: pkg-config
Version: 0.29.1-0ubuntu1
...

Package: zip
Version: 3.0-11
...

Package: g++
Version: 4:5.3.1-1ubuntu1
...

Package: zlib1g-dev
Version: 1:1.2.8.dfsg-2ubuntu4.1
...

Package: python
Version: 2.7.12-1~16.04
...

Package: virtualenv
Version: 15.0.1+ds-3ubuntu1
...
```

6. Git clone the exact version of Envoy source that you want to install

```bash
cd ~/src
git clone --branch v1.10.0 git@github.com:envoyproxy/envoy.git
```

7. Run envoy build

```bash
cd ~/src/envoy
bazel build //source/exe:envoy-static
```

Sit back and relax. This will take a while. Once it is all complete, go to the following folder:

```bash
cd ~/src/envoy/bazel-bin/source/exe
ls -al envoy-static
```

8. Test the build

Create the following `config.yaml` file in the `~/src/envoy/bazel-bin/source/exe` folder:

```yaml
admin:
  access_log_path: /tmp/admin_access.log
  address:
    socket_address:
      protocol: TCP
      address: 127.0.0.1
      port_value: 9901
static_resources:
  listeners:
  - name: listener_0
    address:
      socket_address:
        protocol: TCP
        address: 0.0.0.0
        port_value: 10000
    filter_chains:
    - filters:
      - name: envoy.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains: ["*"]
              routes:
              - match:
                  prefix: "/"
                route:
                  host_rewrite: www.google.com
                  cluster: service_google
          http_filters:
          - name: envoy.router
  clusters:
  - name: service_google
    connect_timeout: 0.25s
    type: LOGICAL_DNS
    # Comment out the following line to test on v6 networks
    dns_lookup_family: V4_ONLY
    lb_policy: ROUND_ROBIN
    load_assignment:
      cluster_name: service_google
      endpoints:
      - lb_endpoints:
        - endpoint:
            address:
              socket_address:
                address: www.google.com
                port_value: 443
    tls_context:
      sni: www.google.com
```

Run:

`./envoy-static -c config.yaml`

Open a new terminal window and run:

`curl -I http://localhost:10000`

You should see an output like this:

```
HTTP/1.1 200 OK
date: Mon, 03 Jun 2019 13:43:13 GMT
expires: -1
cache-control: private, max-age=0
content-type: text/html; charset=ISO-8859-1
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
server: envoy
x-xss-protection: 0
x-frame-options: SAMEORIGIN
set-cookie: 1P_JAR=2019-06-03-13; expires=Wed, 03-Jul-2019 13:43:26 GMT; path=/; domain=.google.com
set-cookie: NID=184=vAr2ocOEDIYmjU1J-f1evYH_YUsPSPFgSXjq2SSn-EqA4cesjhHrZLx9BhEJ5xC2QokartDHpzFzC01k1TqIzUQC5nkpIAzNInoPhXdfLY0Orhs8F66QvWSnQB0WtIGZGJCgVLMtM666F48ho6qdq9sX-q2X_c1B5827xh-7Fjs; expires=Tue, 03-Dec-2019 13:43:26 GMT; path=/; domain=.google.com; HttpOnly
alt-svc: quic=":443"; ma=2592000; v="46,44,43,39"
accept-ranges: none
vary: Accept-Encoding
x-envoy-upstream-service-time: 99
transfer-encoding: chunked
```

Bingo! You are all set!

9. OPTIONAL: Move things around

```bash
cd ~/src/envoy/bazel-bin/source/exe
sudo cp envoy-static /usr/local/bin/envoy
sudo mkdir -p /etc/envoy
sudo mv config.yaml /etc/envoy
# Assuming /usr/local/bin is already in your PATH...
envoy -c /etc/envoy/config.yaml
```

## Build Envoy on macOS Mojave (10.14.5)

1. Install Homebrew:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```bash
brew update
brew upgrade
```

1. Install `go`:

```bash
brew install go
export GOPATH=$HOME/workspace/go-apps
mkdir -p ${GOPATH}
```

Update PATH settings in your `.zshrc` (or `.bashrc`) to include the following:

```bash
export GOPATH=$HOME/workspace/go-apps
export PATH=${GOPATH}/bin:$PATH
```

Source the Zsh (or Bash) profile and make sure things look good:

```bash
source ~/.zshrc
go version
# Make sure the output looks like
# go version go1.12.5 darwin/amd64
```

2. Install `jdk`:

Download Java 8 directly from [Oracle](https://www.java.com/en/download/mac_download.jsp) and follow these [instructions](https://www.java.com/en/download/help/mac_install.xml)

Add `JAVA_HOME` to your `.bashrc` (or `.zshrc`):

```bash
# Define Java Home settings
export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"
export PATH=${JAVA_HOME}/bin:$PATH
```

Source the Zsh (or Bash) profile and make sure things look good:

```bash
source ~/.zshrc
java -version
# Make sure the output looks like
# java version "1.8.0_171"
# Java(TM) SE Runtime Environment (build 1.8.0_171-b11)
# Java HotSpot(TM) 64-Bit Server VM (build 25.171-b11, mixed mode)
```

3. Install [Buildifer](https://github.com/bazelbuild/buildtools)

```bash
go get -u github.com/bazelbuild/buildtools/buildifier
```

Add `BUILDIFIER_BIN` to your `.bashrc` (or `.zshrc`):

```bash
# Buildfier to format Bazel BUILD files
export BUILDIFIER_BIN="${GOPATH}/bin"
```

Source the Zsh (or Bash) profile and make sure things look good:

```bash
source ~/.zshrc
echo $BUILDIFIER_BIN
```

4. Install Bazel version 0.22:

*NOTE*: Using the latest version (0.26) of Bazel gave errors.

```bash
cd src/
curl -L -O https://github.com/bazelbuild/bazel/releases/download/0.22.0/bazel-0.22.0-installer-darwin-x86_64.sh
chmod +x bazel-0.26.0-installer-linux-x86_64.sh
sudo ./bazel-0.26.0-installer-linux-x86_64.sh
# This will install bazel in /usr/local/bin
```

Run `bazel version` to make sure it is running the correct version (v0.22.0):

```bash
INFO: Invocation ID: 4d7a6147-dd2d-4ec2-8baa-67a03febe289
Build label: 0.22.0
Build target: bazel-out/darwin-opt/bin/src/main/java/com/google/devtools/build/lib/bazel/BazelServer_deploy.jar
Build time: Mon Jan 28 13:00:18 2019 (1548680418)
Build timestamp: 1548680418
Build timestamp as int: 1548680418
```

5. Install the following External Dependencies

```bash
brew install coreutils wget cmake libtool automake ninja clang-format autoconf aspell
```

Here is the version I have running for each of the external dependencies:

```bash
brew info coreutils wget cmake libtool automake ninja clang-format autoconf aspell
```

gives the following output:

```
coreutils: stable 8.31 (bottled), HEAD
GNU File, Shell, and Text utilities
...

wget: stable 1.20.3 (bottled), HEAD
Internet file retriever
...

cmake: stable 3.14.5 (bottled), HEAD
Cross-platform make
...

libtool: stable 2.4.6 (bottled)
Generic library support script
...

automake: stable 1.16.1 (bottled)
Tool for generating GNU Standards-compliant Makefiles
...

ninja: stable 1.9.0 (bottled), HEAD
Small build system for use with gyp or CMake
...

clang-format: stable 2019-01-18 (bottled), HEAD
Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript
...

autoconf: stable 2.69 (bottled)
Automatic configure script builder
...

aspell: stable 0.60.6.1 (bottled)
Spell checker with better logic than ispell
...
```

6. Git clone the exact version of Envoy source that you want to install

```bash
cd ~/src
git clone --branch v1.10.0 git@github.com:envoyproxy/envoy.git
```

7. Run envoy build

```bash
cd ~/src/envoy
bazel build //source/exe:envoy-static
```

Sit back and relax. This will take a while. Once it is all complete, go to the following folder:

```bash
cd ~/src/envoy/bazel-bin/source/exe
ls -al envoy-static
```

8. Test the build

Create the following `config.yaml` file in the `~/src/envoy/bazel-bin/source/exe` folder:

```yaml
admin:
  access_log_path: /tmp/admin_access.log
  address:
    socket_address:
      protocol: TCP
      address: 127.0.0.1
      port_value: 9901
static_resources:
  listeners:
  - name: listener_0
    address:
      socket_address:
        protocol: TCP
        address: 0.0.0.0
        port_value: 10000
    filter_chains:
    - filters:
      - name: envoy.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains: ["*"]
              routes:
              - match:
                  prefix: "/"
                route:
                  host_rewrite: www.google.com
                  cluster: service_google
          http_filters:
          - name: envoy.router
  clusters:
  - name: service_google
    connect_timeout: 0.25s
    type: LOGICAL_DNS
    # Comment out the following line to test on v6 networks
    dns_lookup_family: V4_ONLY
    lb_policy: ROUND_ROBIN
    load_assignment:
      cluster_name: service_google
      endpoints:
      - lb_endpoints:
        - endpoint:
            address:
              socket_address:
                address: www.google.com
                port_value: 443
    tls_context:
      sni: www.google.com
```

Run:

`./envoy-static -c config.yaml`

Open a new terminal window and run:

`curl -I http://localhost:10000`

You should see an output like this:

```
HTTP/1.1 200 OK
date: Mon, 03 Jun 2019 14:10:21 GMT
expires: -1
cache-control: private, max-age=0
content-type: text/html; charset=ISO-8859-1
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
server: envoy
x-xss-protection: 0
x-frame-options: SAMEORIGIN
set-cookie: 1P_JAR=2019-06-03-14; expires=Wed, 03-Jul-2019 14:10:21 GMT; path=/; domain=.google.com
set-cookie: NID=184=mRvFRmb_DdL_LTEL9hFb_f7tEuCnsZcLxkC8elEuRZD-rRO3O2raDjjAxwxs_g01mvFpHvSizlfyRNHIfvzG6wCnzDZR1Ipvj7NVemKqcq4ENDK3CRnQaLSYGEZ5QMywoCGSuNw0XUt0v9YfILwrRuk6Ek2dqVizoFCttlmrZLI; expires=Tue, 03-Dec-2019 14:10:21 GMT; path=/; domain=.google.com; HttpOnly
alt-svc: quic=":443"; ma=2592000; v="46,44,43,39"
accept-ranges: none
vary: Accept-Encoding
x-envoy-upstream-service-time: 92
transfer-encoding: chunked
```

Bingo! You are all set!

