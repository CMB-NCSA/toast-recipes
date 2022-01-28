# Install instructions for toast3 branch of toast using conda
# For Mac OSX

# conda pre-reqs
# 1.  For all
# conda install -y -c cmake=3.22.1
# conda install -y conda-forge pshmem tomlkit fftw
# 2. Only Linux
# conda install -y -c conda-forge gcc cxx-compiler fftw

FLAVOR=`uname -s`

if [[ $FLAVOR == 'Darwin' ]]
then
  MINICONDA_PATH=${HOME}/miniconda3
  BUILDSH="../platforms/osx_homebrew.sh"
elif [[$FLAVOR == 'Linux']
then
  MINICONDA_PATH="/projects/caps/spt3g/opt/miniconda3"
  BUILDSH="../platforms/linux-gcc.sh"
fi

# Start conda evn
source $MINICONDA_PATH/bin/activate base

# clone repo:
cd /tmp
git clone https://github.com/hpc4cmb/toast.git
cd toast/
git checkout toast3
mkdir build
cd build
$BUILDSH -DCMAKE_INSTALL_PREFIX=$MINICONDA_PATH/toast
make -j 4
make install

echo " -------- Done ----------"
echo "Add this to your $HOME/.bashrc"
echo "export PATH=\${PATH}:${MINICONDA_PATH}/toast/bin"
echo "export PYTHONPATH=${MINICONDA_PATH}/toast/lib/python3.8/site-packages:${PYTHONPATH}"
