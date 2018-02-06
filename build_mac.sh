# I have no idea how to build things on mac, this is going to be rough....
LALSUITE_VERSION=$(python setup.py --version | sed 's/\.post.*$//')
mkdir local

export PATH=$PATH:$PWD/local/bin:$HOME/Library/Python/2.7/bin
export PKG_CONFIG_PATH=$PWD/local/lib/pkgconfig

brew update
brew install fftw hdf5 gsl zlib swig gsl

wget -q https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user

ls $HOME/Library/Python/2.7
ls $HOME/Library/Python/2.7/bin


# Install numpy
pip install -q --user numpy=='1.13.0' delocate virtualenv wheel twine

# Libz (maybe needed for Mac < 10.12
curl -s https://codeload.github.com/madler/zlib/tar.gz/v1.2.11 > v1.2.11.tar.gz
tar -xf v1.2.11.tar.gz
cd zlib-1.2.11/
./configure --prefix=$PWD/../local
make -j install
cd ../

# Install libframe
curl -s http://lappweb.in2p3.fr/virgo/FrameL/libframe-8.30.tar.gz > libframe.tar.gz
tar -xf libframe.tar.gz
cd libframe-*
./configure --prefix=$PWD/../local
make -j install
cd ../

# Install libmetaio
curl -s http://software.ligo.org/lscsoft/source/metaio-8.4.0.tar.gz > metaio.tar.gz
tar -xf metaio.tar.gz
cd metaio-*
./configure --prefix=$PWD/../local
make -j install
cd ../

# Install lalsuite
git clone -q https://github.com/lscsoft/lalsuite.git
cd lalsuite
git checkout -q lalsuite-v$LALSUITE_VERSION

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
set -x

cp local/lib/python2.7/site-packages/lal/_lal.so blal/_lal.so
install_name_tool -add_rpath "@loader_path" blal/_lal.so
cp local/lib/python2.7/site-packages/lalframe/_lalframe.so blal/_lalframe.so
install_name_tool -add_rpath "@loader_path" blal/_lalframe.so
cp local/lib/python2.7/site-packages/lalsimulation/_lalsimulation.so blal/_lalsimulation.so
install_name_tool -add_rpath "@loader_path" blal/_lalsimulation.so

delocate-listdeps blal > maclibs

while read line
do
    file=`basename ${line}`
    cp $line blal/$file
    chmod 777 blal/$file
    install_name_tool -add_rpath "@loader_path" blal/$file
    echo $file
done < maclibs

cd blal
python ../fixup_libs.py
cd ..

ls blal
