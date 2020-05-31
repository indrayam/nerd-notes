# Envoy on Ubuntu Xenial and macOS Mojave: The Hard Way

## Table of Contents
- [General Notes](#general-notes)
- [Build Envoy on macOS Mojave (10.14.5)](#build-envoy-on-macos-mojave-10145)
- [Build Envoy on Ubuntu Xenial (16.04)](#build-envoy-on-ubuntu-xenial-1604)
- [Filters Enabled by Default](#filters-enabled-by-default)

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

## Build Envoy on macOS Mojave (10.14.5)

1. Install Homebrew:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```bash
brew update
brew upgrade
```

2. Install `go`:

```bash
brew install go
export GOPATH=$HOME/workspace/go
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

3. Install `jdk`:

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

4. Install [Buildifer](https://github.com/bazelbuild/buildtools)

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

5. Install Bazel version 0.22:

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

6. Install the following External Dependencies

```bash
brew install coreutils wget cmake libtool automake ninja clang-format autoconf aspell
```

Here is the version I have running for each of the external dependencies (run `brew info coreutils wget cmake libtool automake ninja clang-format autoconf aspell`):

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

7. Git clone the exact version of Envoy source that you want to install

```bash
cd ~/src
git clone --branch v1.10.0 git@github.com:envoyproxy/envoy.git
```

8. Run envoy build

```bash
cd ~/src/envoy
bazel build //source/exe:envoy-static
```

Sit back and relax. This will take a while. Once it is all complete, go to the following folder:

```bash
cd ~/src/envoy/bazel-bin/source/exe
ls -al envoy-static
```

9. Test the build

Create the following `envoy.yaml` file in the `~/src/envoy/bazel-bin/source/exe` folder:

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

`./envoy-static -c envoy.yaml`

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

Enjoy!

## Build Envoy on Ubuntu Bionic (18.04)

1. Install `go`:

```bash
wget https://dl.google.com/go/go1.14.3.linux-amd64.tar.gz
sha256sum go1.14.3.linux-amd64.tar.gz
tar -xvzf go1.14.3.linux-amd64.tar.gz
sudo mv go /usr/local
```

Update PATH settings in your `.zshrc` (or `.bashrc`) to include the following:

```bash
export GOPATH=$HOME/workspace/go
export PATH=${GOPATH}/bin:/usr/local/go/bin:$PATH
```

Source the Zsh (or Bash) profile:

`source ~/.zshrc`

2. Install `jdk`:

```bash
# Install Java
sudo apt-get -y install default-jdk
sudo ln -s /usr/lib/jvm/java-11-openjdk-amd64 /usr/local/java
java --version
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

4. Install Bazelisk:

Bazelisk ensures that the right version of Bazel is used for the compilation

```bash
cd src/
sudo wget -O /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64
sudo chmod +x /usr/local/bin/bazel
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

6. Git clone the exact version of Envoy source that you want to install

```bash
cd ~/src
git clone --branch v1.14.1 git@github.com:envoyproxy/envoy.git
```

7. Run envoy build

```bash
cd ~/src/envoy
vim ci/SOURCE_VERSION
# Added this line: 3504d40f752eb5c20bc2883053547717bcb92fd8
bazel build -c opt //source/exe:envoy-static
```

Sit back and relax. This will take a while. Once it is all complete, go to the following folder:

```bash
cd ~/src/envoy/bazel-bin/source/exe
ls -al envoy-static
```

8. Test the build

Create the following `envoy.yaml` file in the `~/src/envoy/bazel-bin/source/exe` folder:

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

`./envoy-static -c envoy.yaml`

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
sudo mv envoy.yaml /etc/envoy
# Assuming /usr/local/bin is already in your PATH...
envoy -c /etc/envoy/envoy.yaml
```

## Filters Enabled By Default

When you run the `envoy -c /etc/envoy/envoy.yaml` command, the console output shows the Envoy filters 

```
access_loggers: 
    envoy.file_access_log
    envoy.http_grpc_access_log
filters.http: 
    envoy.buffer
    envoy.cors
    envoy.ext_authz
    envoy.fault
    envoy.filters.http.grpc_http1_reverse_bridge
    envoy.filters.http.header_to_metadata
    envoy.filters.http.jwt_authn
    envoy.filters.http.rbac
    envoy.filters.http.tap
    envoy.grpc_http1_bridge
    envoy.grpc_json_transcoder
    envoy.grpc_web,envoy.gzip
    envoy.health_check
    envoy.http_dynamo_filter
    envoy.ip_tagging
    envoy.lua
    envoy.rate_limit
    envoy.router
    envoy.squash
filters.listener: 
    envoy.listener.original_dst
    envoy.listener.original_src
    envoy.listener.proxy_protocol
    envoy.listener.tls_inspector
filters.network: 
    envoy.client_ssl_auth
    envoy.echo
    envoy.ext_authz
    envoy.filters.network.dubbo_proxy
    envoy.filters.network.mysql_proxy
    envoy.filters.network.rbac
    envoy.filters.network.sni_cluster
    envoy.filters.network.thrift_proxy
    envoy.filters.network.zookeeper_proxy
    envoy.http_connection_manager
    envoy.mongo_proxy
    envoy.ratelimit
    envoy.redis_proxy
    envoy.tcp_proxy
stat_sinks: 
    envoy.dog_statsd
    envoy.metrics_service
    envoy.stat_sinks.hystrix
    envoy.statsd
tracers: 
    envoy.dynamic.ot
    envoy.lightstep
    envoy.tracers.datadog
    envoy.zipkin
transport_sockets.downstream: 
    envoy.transport_sockets.alts
    envoy.transport_sockets.tap
    raw_buffer
    tls
transport_sockets.upstream: 
    envoy.transport_sockets.alts
    envoy.transport_sockets.tap
    raw_buffer
    tls
```
