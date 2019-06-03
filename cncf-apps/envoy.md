# envoy

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
# Buildfier (To complie Envoy)
export BUILDIFIER_BIN="${GOPATH}/bin"
```

Source the Zsh (or Bash) profile:

`source ~/.zshrc`

4. Install Bazel version 0.22:

```bash
cd src/
curl -L -O https://github.com/bazelbuild/bazel/releases/download/0.26.0/bazel-0.26.0-installer-linux-x86_64.sh
chmod +x bazel-0.26.0-installer-linux-x86_64.sh
sudo ./bazel-0.26.0-installer-linux-x86_64.sh
# This will install bazel in /usr/local/bin
```

In order to compile Envoy, I needed to install an older version of `bazel`. To do that, all I did was to make sure I downloaded the right version of the installer script:

```bash
curl -L -O https://github.com/bazelbuild/bazel/releases/download/0.22.0/bazel-0.22.0-installer-linux-x86_64.sh
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

Here is the version I have running for each of the external dependencies on my Ubuntu:

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
