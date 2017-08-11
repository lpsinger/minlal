LALSUITE_VERSION=6.48
NUMPY_VERSION=1.19

mkdir local
export PATH=$PATH:/opt/python/cp27-cp27m/bin/

yum install -y zlib-devel

# Install numpy
pip install numpy=='1.13.0'

# Install libframe
curl http://lappweb.in2p3.fr/virgo/FrameL/libframe-8.30.tar.gz > libframe.tar.gz
tar -xf libframe.tar.gz
cd libframe-*
./configure --prefix=$PWD/../local
make -j install
cd ../

# Install libmetaio
curl http://software.ligo.org/lscsoft/source/metaio-8.4.0.tar.gz > metaio.tar.gz
tar -xf metaio.tar.gz
cd metaio-*
./configure --prefix=$PWD/../loca
make -j install
cd ../

# Install lalsuite
curl https://codeload.github.com/lscsoft/lalsuite/zip/lalsuite-v$LALSUITE_VERSION > lalsuite.zip
unzip lalsuite.zip 1> /dev/null
cd lalsuite*

./00boot
./configure \
--prefix=$PWD/../loca \
--enable-swig-python \
--disable-lalapps \
--disable-lalinference \
--disable-lalpulsar \
--disable-lalxml \
--disable-laldetchar \
--disable-lalburst \
--disable-lalstochastic \
--disable-lalinspiral
make -j install
cd ..

ls
