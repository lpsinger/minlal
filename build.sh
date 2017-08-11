LALSUITE_VERSION=6.48
NUMPY_VERSION=1.19

mkdir local
export PATH=$PATH:/opt/python/cp27-cp27m/bin/:$PWD/local/bin
export PKG_CONFIG_PATH=$PWD/local/lib/pkg-config

yum install -y zlib-devel gsl-devel *fftw3* *pcre*
# Install numpy
pip install numpy=='1.13.0'

# Install swig
wget https://downloads.sourceforge.net/project/swig/swig/swig-3.0.12/swig-3.0.12.tar.gz --no-check-certificate
tar -xvf swig-3.0.12.tar.gz 
cd swig-3.0.12/
./configure --with-python -prefix=$PWD/../local
make -j
make -j install
cd ../

# Install hdf5
curl https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.12/src/hdf5-1.8.12.tar.gz > hdf5-1.8.12.tar.gz
tar -zxvf hdf5-1.8.12.tar.gz
cd hdf5-1.8.12
./configure --prefix=$PWD/../local
make -jls install
cd ../

# Install libframe
curl http://lappweb.in2p3.fr/virgo/FrameL/libframe-8.30.tar.gz > libframe.tar.gz
tar -xf libframe.tar.gz
cd libframe-*
./configure --prefix=$PWD/../local
make -j install
cd ../

ls local/lib
exit

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
--prefix=$PWD/../local \
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
