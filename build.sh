LALSUITE_VERSION=6.48
NUMPY_VERSION=1.19

mkdir local

# Install libframe
curl http://lappweb.in2p3.fr/virgo/FrameL/libframe-8.30.tar.gz > libframe.tar.gz
tar -xf libframe.tar.gz
cd librame*
./configure --prefix=../local
make -j install
cd ../

# Install libmetaio
curl http://software.ligo.org/lscsoft/source/metaio-8.4.0.tar.gz > metaio.tar.gz
tar -xf metaio.tar.gz
cd metaio*
./configure --prefix=../local
make -j install
cd ../

# Install lalsuite
curl https://codeload.github.com/lscsoft/lalsuite/zip/lalsuite-v$LALSUITE_VERSION > lalsuite.zip
unzip lalsuite.zip 1> /dev/null
cd lalsuite*

./00boot
./configure \
--prefix=../local/ \
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
