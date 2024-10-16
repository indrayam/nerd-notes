# MacOS CLIs installed using Homebrew

## CLI

### binsider 

Home: https://github.com/orhun/binsider

Type: Low-Level Programming Utilities

Description:
Binsider offers powerful static and dynamic analysis tools, similar to readelf(1) and strace(1). 
It lets you inspect strings, examine linked libraries, and perform hexdumps, all within a user-friendly TUI.
My Notes:
Installation worked using the following steps as the default `cargo install binsider` failed. 
Not entirely sure how useful this utility will ultimately be

```
git clone https://github.com/orhun/binsider
cd binsider/
CARGO_TARGET_DIR=target cargo build --release --no-default-features
cd target/release/
sudo cp binsider /usr/local/bin/
binsider -V
```

### moshi_mlx 
Home: https://x.com/danielsateler1/status/1836570838331535869

Type: AI/ML

Description:
...

My Notes:
...

### llm Simon Willison 
Home: https://simonwillison.net/2024/Sep/12/
Type: AI/ML
Description:
...
My Notes:
...

### json-flatten Simon Willison 
Home: https://github.com/simonw/json-flatten?tab=readme-ov-file#json-flattening-format
Type: Text Processing
Description:
...
My Notes:
...

### uv Simon Willison 
Home: https://simonwillison.net/2024/Sep/8/uv-under-discussion-on-mastodon/
Type: ...
Description:
...
My Notes:
...

### ell 
Home: https://x.com/wgussml/status/1836458651298730226?s=58&t=C4Jxe0JXpye1T5PSz2hBqw
Type: ...
Description:
...
My Notes:
...

### zellij 
Home: https://zellij.dev/documentation/overview
Type: ...
Description:
...
My Notes:
...

### dicedb 
Home: https://github.com/diceDB/dice
Type: Redis compatible database
Description:
...
My Notes:
...

### panda dataframes 
Home: https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html
Type: Data Processing
Description:
Pandas is a fast, powerful, flexible and easy to use open-source data analysis and data manipulation library built 
on top of the Python programming language.

### polars dataframes
Home: https://docs.pola.rs/
Type: Data Processing
Description:
Polars is a blazingly fast DataFrame library for manipulating structured data. The core is written in Rust, 
and available for Python, R and NodeJS.

### duckdb
Home: https://duckdb.org/
Type: Data Processing
Description:
DuckDB is an embeddable SQL OLAP database management system designed for on-disk analytics.

### achannarasappa/tap/ticker
Home: https://github.com/achannarasappa/ticker
Type: Finance
Description:
Terminal stock ticker with live updates and position tracking. 
Usage: `ticker -w TSLA, CSCO`

### ack
Home: https://beyondgrep.com/
Type: Text Processing
Description:
ack is a tool like grep, optimized for programmers 

### adns
Home: https://www.chiark.greenend.org.uk/~ian/adns/
Type: Networking Utilities
Description:
adns is a resolver library for C (and C++) programs, and a collection of useful DNS resolver utilities. 
If you plan to do bulk checks you will be soon disappointed by the built-in DNS resolver ### it is synchronous. 
There is a nice cute library called ADNS which offers asynchronous DNS queries.
Usage: `adnshost -a -tns cisco.com`

### age
Home: https://github.com/FiloSottile/age
Type: Security
Description:
A simple, modern and secure encryption tool (and Go library) with small explicit keys, no config options, and 
UNIX-style composability. 
My Notes:
Modern and easy to use tool for quick encryption and decryption.

### ansible
Home: https://www.ansible.com/
Type: Configuration Management
Description:
Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy.

### apr-util
Home: https://apr.apache.org/
Type: Development
Description: 
The Apache Portable Runtime (APR) is a supporting library for the Apache web server. 
It provides a set of APIs that map to the underlying operating system (OS). 
My Notes:
Not terribly useful on its own.

### asciidoc
Home: https://asciidoc.org/
Type: Documentation
Description:
AsciiDoc is a text document format for writing notes, documentation, articles, books, ebooks, slideshows, web pages

### asciidoctor
Home: https://asciidoctor.org/
Type: Documentation
Description:
Asciidoctor is a fast text processor and publishing toolchain for converting AsciiDoc content to HTML5, DocBook, 
PDF, and other formats.
My Notes:
It seems to be a competitor of Markdown and Pandoc. I installed the additional backends for PDF and EPUB using `gem`.
After that, converting an `adoc` file to PDF and EPUB formats was super simple.

```ruby
gem install asciidoctor-pdf asciidoctor-epub3
# Created a sample test.adoc file using the following snippet:
# = Hello, AsciiDoc!
# Doc Writer <doc@example.com>
# 
# An introduction to http://asciidoc.org[AsciiDoc].
# 
# == First Section
# 
# * item 1
# * item 2
# 
# [source,ruby]
# puts "Hello, World!"
asciidoctor -b pdf -r asciidoctor-pdf test.adoc
open test.pdf
asciidoctor -b epub3 -r asciidoctor-epub3 test.adoc
open test.epub
```

### asciinema
Home: ...

Type: ...

Description:
...

My Notes:
...

### aspell

Home: ...

Type: ...

Description:
...

My Notes:
...

### automake

Home: ...

Type: ...

Description:
...

My Notes:
...

### aws/tap/copilot-cli

Home: ...

Type: ...

Description:
...

My Notes:
...

### azure-cli

Home: ...

Type: ...

Description:
...

My Notes:
...

### azure/draft/draft

Home: ...

Type: ...

Description:
...

My Notes:
...

### azure/functions/azure-functions-core-tools

Home: ...

Type: ...

Description:
...

My Notes:
...

### bash

Home: ...

Type: ...

Description:
...

My Notes:
...

### bat

Home: ...

Type: ...

Description:
...

My Notes:
...

### bazelisk

Home: ...

Type: ...

Description:
...

My Notes:
...

### bison

Home: ...

Type: ...

Description:
...

My Notes:
...

### brew-gem

Home: ...

Type: ...

Description:
...

My Notes:
...

### broot

Home: ...

Type: ...

Description:
...

My Notes:
...

### buildpacks/tap/pack

Home: ...

Type: ...

Description:
...

My Notes:
...

### cfn-lint

Home: ...

Type: ...

Description:
...

My Notes:
...

### clang-format

Home: https://clang.llvm.org/docs/ClangFormat.html

Description: 
Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript. 

### clisp

Home: https://clisp.sourceforge.io/

Type: Programming Language

Description:
CLISP. GNU CLISP, a Common Lisp implementation 

My Notes:
...

### cloc

Home: https://github.com/AlDanial/cloc/

Type: Programming

Description:
Statistics utility to count lines of code. 

My Notes:
...

### cmake

Home: https://cmake.org/overview/

Type: Programming

Description:
Cross-platform make. Unlike many cross-platform systems, CMake is designed to be used in conjunction with the native build environment. Simple configuration files placed in each source directory (called CMakeLists.txt files) are used to generate standard build files (e.g., makefiles on Unix and projects/workspaces in Windows MSVC) which are used in the usual way. 

My Notes:
...

### cmatrix

Home: https://github.com/abishekvashok/cmatrix/

Type: Fun

Description:
CMatrix is based on the screensaver from The Matrix website. It shows text flying in and out in a terminal like as 
seen in "The Matrix" movie. It can scroll lines all at the same rate or asynchronously and at a 
user-defined speed.

### cocoapods

Home: https://cocoapods.org/

Type: Programming

Description:
CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. 

My Notes:
...

### colima

Home: ...

Type: ...

Description:
...

My Notes:
...

### colordiff

Home: https://www.colordiff.org/

Type: Programming

Description:
Color-highlighted diff(1) output 

My Notes:
...

### consul

Home: https://www.consul.io

Description: 
Tool for service discovery, monitoring and configuration

### cosign

Home: https://github.com/sigstore/cosign

Type: Security, Containers

Description:
Container Signing. 

My Notes:
...

### crystal

Home: ...

Type: ...

Description:
...

My Notes:
...

### csvlens

Home: ...

Type: ...

Description:
...

My Notes:
...

### ctags

Home: ...

Type: ...

Description:
...

My Notes:
...

### ctop

Home: ...

Type: ...

Description:
...

My Notes:
...

### curl

Home: https://curl.se

Type: API

Description:
Get a file from an HTTP, HTTPS or FTP server. 

My Notes:
...

### dasel

Home: ...

Type: ...

Description:
...

My Notes:
...

### ddosify/tap/ddosify

Home: ...

Type: ...

Description:
...

My Notes:
...

### deno

Home: ...

Type: ...

Description:
...

My Notes:
...

### diff-so-fancy

Home: https://github.com/so-fancy/diff-so-fancy

Description:
Good-lookin' diffs with diff-highlight and more. 

### dive

Home: ...

Type: ...

Description:
...

My Notes:
...

### docker-machine

Home: ...

Type: ...

Description:
...

My Notes:
...

### doctl

Home: ...

Type: ...

Description:
...

My Notes:
...

### dust

Home: ...

Type: ...

Description:
...

My Notes:
...

### elixir

Home: ...

Type: ...

Description:
...

My Notes:
...

### emscripten

Home: ...

Type: ...

Description:
...

My Notes:
...

### espeak

Home: ...

Type: ...

Description:
...

My Notes:
...

### eza

Home: ...

Type: ...

Description:
...

My Notes:
...

### fd

Home: ...

Type: ...

Description:
...

My Notes:
...

### ffmpeg

Home: ...

Type: ...

Description:
...

My Notes:
...

### figlet

Home: ...

Type: ...

Description:
...

My Notes:
...

### filosottile/musl-cross/musl-cross

Home: ...

Type: ...

Description:
...

My Notes:
...

### findent

Home: ...

Type: ...

Description:
...

My Notes:
...

### findutils

Home: ...

Type: ...

Description:
...

My Notes:
...

### flyctl

Home: ...

Type: ...

Description:
...

My Notes:
...

### fortio

Home: ...

Type: ...

Description:
...

My Notes:
...

### fortls

Home: ...

Type: ...

Description:
...

My Notes:
...

### fortune

Home: ...

Type: ...

Description:
...

My Notes:
...

### fx

Home: ...

Type: ...

Description:
...

My Notes:
...

### fzf

Home: ...

Type: ...

Description:
...

My Notes:
...

### gawk

Home: ...

Type: ...

Description:
...

My Notes:
...

### gh

Home: ...

Type: ...

Description:
...

My Notes:
...

### git-cal

Home: ...

Type: ...

Description:
...

My Notes:
...

### git-delta

Home: ...

Type: ...

Description:
...

My Notes:
...

### git-extras

Home: ...

Type: ...

Description:
...

My Notes:
...

### git-lfs

Home: ...

Type: ...

Description:
...

My Notes:
...

### git-quick-stats

Home: ...

Type: ...

Description:
...

My Notes:
...

### gitui

Home: ...

Type: ...

Description:
...

My Notes:
...

### glances

Home: ...

Type: ...

Description:
...

My Notes:
...

### gnu-indent

Home: ...

Type: ...

Description:
...

My Notes:
...

### gnu-sed

Home: ...

Type: ...

Description:
...

My Notes:
...

### gnu-tar

Home: ...

Type: ...

Description:
...

My Notes:
...

### go

Home: ...

Type: ...

Description:
...

My Notes:
...

### gojq

Home: ...

Type: ...

Description:
...

My Notes:
...

### goreleaser/tap/goreleaser

Home: ...

Type: ...

Description:
...

My Notes:
...

### gradle

Home: ...

Type: ...

Description:
...

My Notes:
...

### grep

Home: ...

Type: ...

Description:
...

My Notes:
...

### grip

Home: ...

Type: ...

Description:
...

My Notes:
...

### gron

Home: ...

Type: ...

Description:
...

My Notes:
...

### groovy

Home: ...

Type: ...

Description:
...

My Notes:
...

### grpcurl

Home: ...

Type: ...

Description:
...

My Notes:
...

### grype

Home: https://github.com/anchore/grype

Type: Security, Container

Description:
A vulnerability scanner for container images and filesystems.

My Notes:
Need to double-check the license before actively using it

### gzip

Home: ...

Type: ...

Description:
...

My Notes:
...

### helm

Home: ...

Type: ...

Description:
...

My Notes:
...

### heroku/brew/heroku

Home: ...

Type: ...

Description:
...

My Notes:
...

### highlight

Home: ...

Type: ...

Description:
...

My Notes:
...

### htop

Home: ...

Type: ...

Description:
...

My Notes:
...

### httpie

Home: ...

Type: ...

Description:
...

My Notes:
...

### hub

Home: ...

Type: ...

Description:
...

My Notes:
...

### hugo

Home: ...

Type: ...

Description:
...

My Notes:
...

### hyperfine

Home: ...

Type: ...

Description:
...

My Notes:
...

### imagemagick

Home: ...

Type: ...

Description:
...

My Notes:
...

### instantclienttap/instantclient/instantclient-sqlplus

Home: ...

Type: ...

Description:
...

My Notes:
...

### ipcalc

Home: ...

Type: ...

Description:
...

My Notes:
...

### iproute2mac

Home: ...

Type: ...

Description:
...

My Notes:
...

### jaq

Home: ...

Type: ...

Description:
...

My Notes:
...

### jfrog-cli

Home: ...

Type: ...

Description:
...

My Notes:
...

### jid

Home: ...

Type: ...

Description:
...

My Notes:
...

### johanhaleby/kubetail/kubetail

Home: ...

Type: ...

Description:
...

My Notes:
...

### jpeg

Home: ...

Type: ...

Description:
...

My Notes:
...

### jq

Home: ...

Type: ...

Description:
...

My Notes:
...

### jsonnet

Home: ...

Type: ...

Description:
...

My Notes:
...

### just

Home: ...

Type: ...

Description:
...

My Notes:
...

### kafka

Home: ...

Type: ...

Description:
...

My Notes:
...

### kops

Home: ...

Type: ...

Description:
...

My Notes:
...

### kotlin

Home: ...

Type: ...

Description:
...

My Notes:
...

### ktr0731/evans/evans

Home: ...

Type: ...

Description:
...

My Notes:
...

### kube-ps1

Home: ...

Type: ...

Description:
...

My Notes:
...

### kubectx

Home: ...

Type: ...

Description:
...

My Notes:
...

### kubespy

Home: ...

Type: ...

Description:
...

My Notes:
...

### lazydocker

Home: ...

Type: ...

Description:
...

My Notes:
...

### let-us-go/zkcli/zkcli

Home: ...

Type: ...

Description:
...

My Notes:
...

### libffi

Home:

Type:

Description:
FFI stands for Foreign Function Interface. A foreign function interface is the popular name for the interface 
that allows code written in one language to call code written in another language. The libffi library really 
only provides the lowest, machine dependent layer of a fully featured foreign function interface. A layer 
must exist above libffi that handles type conversions for values passed between the two languages.

My Notes:


### libtermkey

Home: ...

Type: ...

Description:
...

My Notes:
...

### links

Home: ...

Type: ...

Description:
...

My Notes:
...

### litecli

Home: ...

Type: ...

Description:
...

My Notes:
...

### lnav

Home: ...

Type: ...

Description:
...

My Notes:
...

### lolcat

Home: ...

Type: ...

Description:
...

My Notes:
...

### lorem

Home: ...

Type: ...

Description:
...

My Notes:
...

### luarocks

Home: ...

Type: ...

Description:
...

My Notes:
...

### make

Home: https://www.gnu.org/software/make/

Type: Programming

Description:
The purpose of the make utility is to determine automatically which pieces of a large program need to be recompiled, and issue the commands to recompile them.

My Notes:
...

### mariadb

Home: ...

Type: ...

Description:
...

My Notes:
...

### mas

Home: ...

Type: ...

Description:
...

My Notes:
...

### maven

Home: ...

Type: ...

Description:
...

My Notes:
...

### mercurial

Home: ...

Type: ...

Description:
...

My Notes:
...

### mergestat/mergestat/mergestat

Home: ...

Type: ...

Description:
...

My Notes:
...

### micro

Home: ...

Type: ...

Description:
...

My Notes:
...

### midnight-commander

Home: ...

Type: ...

Description:
...

My Notes:
...

### minikube

Home: ...

Type: ...

Description:
...

My Notes:
...

### modularml/packages/modular

Home: ...

Type: ...

Description:
...

My Notes:
...

### mongodb/brew/mongodb-community

Home: ...

Type: ...

Description:
...

My Notes:
...

### mono-libgdiplus

Home: ...

Type: ...

Description:
...

My Notes:
...

### muesli/tap/duf

Home: ...

Type: ...

Description:
...

My Notes:
...

### multitail

Home: ...

Type: ...

Description:
...

My Notes:
...

### mycli

Home: ...

Type: ...

Description:
...

My Notes:
...

### ncdu

Home: ...

Type: ...

Description:
...

My Notes:
...

### neofetch

Home: ...

Type: ...

Description:
...

My Notes:
...

### neovim

Home: ...

Type: ...

Description:
...

My Notes:
...

### netcat

Home: ...

Type: ...

Description:
...

My Notes:
...

### netlify-cli

Home: ...

Type: ...

Description:
...

My Notes:
...

### newman

Home: ...

Type: ...

Description:
...

My Notes:
...

### nghttp2

Home: ...

Type: ...

Description:
...

My Notes:
...

### nginx/unit/unit

Home: ...

Type: ...

Description:
...

My Notes:
...

### ninja

Home: ...

Type: ...

Description:
...

My Notes:
...

### noahgorstein/tap/jqp

Home: ...

Type: ...

Description:
...

My Notes:
...

### nushell

Home: ...

Type: ...

Description:
...

My Notes:
...

### oha

Home: ...

Type: ...

Description:
...

My Notes:
...

### onefetch

Home: ...

Type: ...

Description:
...

My Notes:
...

### opencoarrays

Home: ...

Type: ...

Description:
...

My Notes:
...

### openldap

Home: ...

Type: ...

Description:
...

My Notes:
...

### ox

Home: ...

Type: ...

Description:
...

My Notes:
...

### pandoc

Home: ...

Type: ...

Description:
...

My Notes:
...

### parallel

Home: ...

Type: ...

Description:
...

My Notes:
...

### pgcli

Home: ...

Type: ...

Description:
...

My Notes:
...

### pinentry-mac

Home: ...

Type: ...

Description:
...

My Notes:
...

### podman

Home: ...

Type: ...

Description:
...

My Notes:
...

### procs

Home: ...

Type: ...

Description:
...

My Notes:
...

### protobuf

Home: ...

Type: ...

Description:
...

My Notes:
...

### pstree

Home: ...

Type: ...

Description:
...

My Notes:
...

### pth

Home: ...

Type: ...

Description:
...

My Notes:
...

### pv

Home: ...

Type: ...

Description:
...

My Notes:
...

### python@3.9, python@3.11, python@3.12

Home: https://python.org

Type: Programming Language

Description:
Python is a clear and powerful object-oriented programming language, comparable to Perl, Ruby, Scheme, or Java.

My Notes:
...

### rclone

Home: ...

Type: ...

Description:
...

My Notes:
...

### reattach-to-user-namespace

Home: ...

Type: ...

Description:
...

My Notes:
...

### redis

Home: ...

Type: ...

Description:
...

My Notes:
...

### ripgrep

Home: ...

Type: ...

Description:
...

My Notes:
...

### rm-improved

Home: ...

Type: ...

Description:
...

My Notes:
...

### rsync

Home: ...

Type: ...

Description:
...

My Notes:
...

### rustscan

Home: ...

Type: ...

Description:
...

My Notes:
...

### s3cmd

Home: ...

Type: ...

Description:
...

My Notes:
...

### sbcl

Home: ...

Type: ...

Description:
...

My Notes:
...

### scons

Home: ...

Type: ...

Description:
...

My Notes:
...

### scrypt

Home: ...

Type: ...

Description:
...

My Notes:
...

### sd

Home: ...

Type: ...

Description:
...

My Notes:
...

### shyaml

Home: ...

Type: ...

Description:
...

My Notes:
...

### siege

Home: ...

Type: ...

Description:
...

My Notes:
...

### skopeo

Home: ...

Type: ...

Description:
...

My Notes:
...

### socat

Home: ...

Type: ...

Description:
...

My Notes:
...

### speedtest-cli

Home: ...

Type: ...

Description:
...

My Notes:
...

### spoof-mac

Home: ...

Type: ...

Description:
...

My Notes:
...

### spring-io/tap/spring-boot

Home: ...

Type: ...

Description:
...

My Notes:
...

### ssh-copy-id

Home: ...

Type: ...

Description:
...

My Notes:
...

### starship

Home: ...

Type: ...

Description:
...

My Notes:
...

### step

Home: ...

Type: ...

Description:
...

My Notes:
...

### stern

Home: ...

Type: ...

Description:
...

My Notes:
...

### swig

Home: ...

Type: ...

Description:
...

My Notes:
...

### syft

Home: https://github.com/anchore/syft

Type: Security, Container

Description:
Syft is a powerful and easy-to-use open-source tool for generating Software Bill of Materials (SBOMs) for container images and filesystems.

My Notes:
Need to double-check the license of this software before actively using it

### sysdig

Home: ...

Type: ...

Description:
...

My Notes:
...

### telnet

Home: ...

Type: ...

Description:
...

My Notes:
...

### terraform

Home: ...

Type: ...

Description:
...

My Notes:
...

### terragrunt

Home: ...

Type: ...

Description:
...

My Notes:
...

### the_silver_searcher

Home: ...

Type: ...

Description:
...

My Notes:
...

### tidy-html5

Home: ...

Type: ...

Description:
...

My Notes:
...

### tinygo-org/tools/tinygo

Home: ...

Type: ...

Description:
...

My Notes:
...

### tmux

Home: ...

Type: ...

Description:
...

My Notes:
...

### toilet

Home: ...

Type: ...

Description:
...

My Notes:
...

### tokei

Home: ...

Type: ...

Description:
...

My Notes:
...

### topgrade

Home: ...

Type: ...

Description:
...

My Notes:
...

### tree

Home: ...

Type: ...

Description:
...

My Notes:
...

### txn2/tap/kubefwd

Home: ...

Type: ...

Description:
...

My Notes:
...

### vim

Home: ...

Type: ...

Description:
...

My Notes:
...

### vimpager

Home: ...

Type: ...

Description:
...

My Notes:
...

### wasm3

Home: ...

Type: ...

Description:
...

My Notes:
...

### watch

Home: ...

Type: ...

Description:
...

My Notes:
...

### watchman

Home: ...

Type: ...

Description:
...

My Notes:
...

### wget

Home: ...

Type: ...

Description:
...

My Notes:
...

### wrk

Home: ...

Type: ...

Description:
...

My Notes:
...

### xdot

Home: ...

Type: ...

Description:
...

My Notes:
...

### xsv

Home: ...

Type: ...

Description:
...

My Notes:
...

### ycd/tap/dstp

Home: ...

Type: ...

Description:
...

My Notes:
...

### yq

Home: ...

Type: ...

Description:
...

My Notes:
...

### z

Home: ...

Type: ...

Description:
...

My Notes:
...

### zellij

Home: ...

Type: ...

Description:
...

My Notes:
...

### zig

Home: ...

Type: ...

Description:
...

My Notes:
...

## Libraries

### pcre

Home: https://www.pcre.org/

Description:
The PCRE library is a set of functions that implement regular expression pattern matching using the same 
syntax and semantics as Perl 5. 

### pixman

Home: https://cairographics.org/

Description:
Low-level library for pixel manipulation 

### gmp

Home: https://gmplib.org/

GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and 
floating-point numbers. There is no practical limit to the precision except the ones implied by the 
available memory in the machine GMP runs on. GMP has a rich set of functions, and the functions 
have a regular interface. The main target applications for GMP are cryptography applications 
and research, Internet security applications, algebra systems, computational algebra research, 
etc. 

### adns

Home: https://www.chiark.greenend.org.uk/~ian/adns/

Description:
C/C++ resolver library and DNS resolver utilities. 

### libevent

Home: https://libevent.org/

Description:
The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file 
descriptor or after a timeout has been reached. Furthermore, libevent also support callbacks due to 
signals or regular timeouts. 

### libunistring

Home: https://www.gnu.org/software/libunistring/

Description:
C string library for manipulating Unicode strings. 

### coreutils

Home: https://www.gnu.org/software/coreutils

Description:
The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system. These are the core utilities which are expected to exist on every operating system.