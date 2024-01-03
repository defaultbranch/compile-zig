FROM library/debian:bookworm-slim
RUN apt-get update

# See https://github.com/ziglang/zig/wiki/Building-Zig-From-Source

RUN apt-get install -y wget
RUN wget --no-verbose https://ziglang.org/download/0.11.0/zig-0.11.0.tar.xz

RUN apt-get install -y xz-utils
RUN tar xf zig-0.11.0.tar.xz
WORKDIR /zig-0.11.0

RUN apt-get install -y cmake

RUN apt-get install -y clang-16 liblld-16-dev libclang-16-dev
ENV CC=clang-16
ENV CXX=clang++-16

RUN mkdir build
WORKDIR build

RUN cmake -DCLANG_INCLUDE_DIRS=/usr/lib/llvm-16/lib/clang/16/include -DCMAKE_INSTALL_PREFIX=/usr ..
RUN make install
