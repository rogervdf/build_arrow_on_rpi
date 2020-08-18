#! /bin/bash

# Linux dependencies
sudo apt-get install \
  autoconf \
  bison \
  clang-7 \
  cmake \
  curl \
  flex \
  libboost-dev \
  libboost-filesystem-dev \
  libboost-regex-dev \
  libboost-system-dev \
  libjemalloc-dev \
  libssl-dev \
  llvm-7-dev \
  python3-dev

rm -fr apache-arrow-*.zip
wget -q https://github.com/apache/arrow/archive/apache-arrow-0.15.1.zip
rm -fr arrow-apache-arrow-*
unzip -qq apache-arrow-0.15.1.zip
cd arrow-apache-arrow-0.15.1/cpp
mkdir release
cd release
export ARROW_HOME=/usr/local/lib
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PYTHON_BIN_PATH=${PYTHON_BIN_PATH:-"$(which python3)"}

cmake -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
      -DCMAKE_INSTALL_LIBDIR=lib  \
      -DARROW_FLIGHT=ON \
      -DARROW_GANDIVA=ON  \
      -DARROW_ORC=ON  \
      -DARROW_WITH_BZ2=ON \
      -DARROW_WITH_ZLIB=ON  \
      -DARROW_WITH_ZSTD=ON  \
      -DARROW_WITH_LZ4=ON \
      -DARROW_WITH_SNAPPY=ON  \
      -DARROW_WITH_BROTLI=ON  \
      -DARROW_PARQUET=ON  \
      -DARROW_PYTHON=ON \
      -DARROW_PLASMA=ON \
      -DARROW_CUDA=OFF \
      -DARROW_BUILD_TESTS=ON  \
      -DPYTHON_EXECUTABLE=/usr/bin/python3  \
      ..

make --jobs=`nproc`
sudo make install