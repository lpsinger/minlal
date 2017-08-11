LALSUITE_VERSION=6.48

mkdir local
export PATH=$PATH:/opt/python/cp27-cp27mu/bin/:$PWD/local/bin
export PKG_CONFIG_PATH=$PWD/local/lib/pkgconfig

yum install -y zlib-devel gsl-devel *fftw3* *pcre* mlocate chrpath
# Install numpy
pip install numpy=='1.13.0'

# Install swig
wget https://www.atlas.aei.uni-hannover.de/~bema/tarballs/swig-3.0.7.tar.gz
tar -xvf swig-3.0.7.tar.gz 
cd swig-3.0.7/
./configure --with-python -prefix=$PWD/../local
make -j
make -j install
cd ../

# Install hdf5
curl https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.12/src/hdf5-1.8.12.tar.gz > hdf5-1.8.12.tar.gz
tar -zxvf hdf5-1.8.12.tar.gz
cd hdf5-1.8.12
./configure --prefix=$PWD/../local
make -j
make -j install
cd ../

# Install libframe
curl http://lappweb.in2p3.fr/virgo/FrameL/libframe-8.30.tar.gz > libframe.tar.gz
tar -xf libframe.tar.gz
cd libframe-*
./configure --prefix=$PWD/../local
make -j install
cd ../

ls local/lib

# Install libmetaio
curl http://software.ligo.org/lscsoft/source/metaio-8.4.0.tar.gz > metaio.tar.gz
tar -xf metaio.tar.gz
cd metaio-*
./configure --prefix=$PWD/../local
make -j install
cd ../

# Install lalsuite
git clone https://github.com/lscsoft/lalsuite.git
cd lalsuite
git checkout lalsuite-v$LALSUITE_VERSION

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

# Grab the libraries we need
updatedb
cd project
mkdir blal
cd blal
while read line
do
    file=`locate $line | grep --invert-match /usr/lib/ | grep --invert-match /lib/ | head -1`
    chrpath -r '$ORIGIN' $file
    chmod 777 $file
    cp $file ./
done < ../libs




