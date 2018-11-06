#!/bin/bash

#Change timezone
sudo ln -sf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime

#change mirror
sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
sudo sed -ri "s/[a-z]\{2\}[a-z]?\.archive\.ubuntu\.com/mirror\.iith\.ac\.in/" /etc/apt/sources.list
sudo sed -ri "s/security\.ubuntu\.com/mirror\.iith\.ac\.in/" /etc/apt/sources.list

sudo apt-get update
sudo apt-get dist-upgrade -fmy
sudo apt-get autoremove -fmy
sudo apt-get install -fmy autoconf automake make m4 libtool flex bison build-essential ninja-build cmake ccache
sudo apt-get install -fmy binutils binutils-dev gawk texinfo
sudo apt-get install -fmy git subversion wget curl
sudo apt-get install -fmy perl tcl
sudo apt-get install -fmy python python-pip python-setuptools python3 python3-pip python3-setuptools
sudo apt-get install -fmy gcc g++ gfortran gdb
sudo apt-get install -fmy llvm lld lldb clang clang-format clang-tidy clang-tools
sudo apt-get install -fmy openssh-server screen tmux byobu
sudo apt-get install -fmy vim exuberant-ctags valgrind
sudo apt-get install -fmy libyaml-dev libstdc++5 libstdc++6 libc6-dev libboost-dev libboost-all-dev libglpk-dev libgmp-dev libmpfr-dev libmpfrc++-dev zlib1g-dev libxml2
sudo apt-get install -fmy libblas-dev libopenblas-dev liblapack-dev libtmglib-dev liblapacke-dev libatlas-base-dev libclblas-dev

#perf
sudo apt-get install -fmy linux-tools-common linux-tools-generic

#Debugging
sudo apt-get install -fmy libunwind8-dev libelf-dev libdwarf-dev

#Extras
#sudo apt-get install -fmy zip unzip
sudo apt-get install -fmy libevent-dev libdouble-conversion-dev libgoogle-glog-dev libgflags-dev libiberty-dev liblz4-dev liblzma-dev libsnappy-dev  libjemalloc-dev libssl-dev pkg-config xutils-dev dconf-cli
sudo apt-get install -fmy zsh fonts-powerline

#Assamese fonts
#sudo apt-get install -fmy fonts-lohit-beng-assamese
#Good fonts
#sudo apt-get install -fmy fonts-dejavu fonts-inconsolata fonts-vollkorn fonts-ubuntu fonts-roboto fonts-powerline fonts-mononoki fonts-open-sans fonts-lato

#UI
sudo apt-get install -fmy xdot graphviz
sudo apt-get install -fmy terminator ranger quilt doxygen graphviz

#GCC
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -fmy gcc-4.8 gcc-5 gcc-6 gcc-7 gcc-8 gcc-4.8-multilib gcc-5-multilib gcc-6-multilib gcc-7-multilib gcc-8-multilib g++-4.8 g++-5 g++-6 g++-7 g++-8 g++-4.8-multilib g++-5-multilib g++-6-multilib g++-7-multilib g++-8-multilib gfortran-4.8 gfortran-5 gfortran-6 gfortran-7 gfortran-8
sudo apt-get install -fmy gcc-aarch64-linux-gnu gcc-mips-linux-gnu gcc-powerpc64-linux-gnu gcc-sparc64-linux-gnu
sudo apt-get install -fmy g++-aarch64-linux-gnu g++-mips-linux-gnu g++-powerpc64-linux-gnu g++-sparc64-linux-gnu

#LLVM
count5=$(grep -c "deb http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-5.0 main" /etc/apt/sources.list)
if [ $count5 -eq 0 ]; then
  echo "# LLVM 5.0" | sudo tee -a /etc/apt/sources.list
  echo "deb http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-5.0 main" | sudo tee -a /etc/apt/sources.list
  echo "#deb-src http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-5.0 main" | sudo tee -a /etc/apt/sources.list
fi

count6=$(grep -c "deb http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-6.0 main" /etc/apt/sources.list)
if [ $count6 -eq 0 ]; then
  echo "# LLVM 6.0" | sudo tee -a /etc/apt/sources.list
  echo "deb http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-6.0 main" | sudo tee -a /etc/apt/sources.list
  echo "#deb-src http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-6.0 main" | sudo tee -a /etc/apt/sources.list
fi

count7=$(grep -c "deb http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-7 main" /etc/apt/sources.list)
if [ $count7 -eq 0 ]; then
  echo "# LLVM 7" | sudo tee -a /etc/apt/sources.list
  echo "deb http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-7 main" | sudo tee -a /etc/apt/sources.list
  echo "#deb-src http://apt.llvm.org/`lsb_release -cs`/ llvm-toolchain-`lsb_release -cs`-7 main" | sudo tee -a /etc/apt/sources.list
fi

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
sudo apt-get update
sudo apt-get install -fmy llvm-5.0 clang-5.0 lld-5.0 lldb-5.0 llvm-6.0 clang-6.0 lld-6.0 lldb-6.0 llvm-7 clang-7 lld-7 lldb-7
#sudo apt-get install -fmy llvm-5.0-dev clang-5.0-dev lld-5.0-dev lldb-5.0-dev
#sudo apt-get install -fmy llvm-6.0-dev clang-6.0-dev lld-6.0-dev lldb-6.0-dev
#sudo apt-get install -fmy llvm-7-dev clang-7-dev lld-7-dev lldb-7-dev
sudo apt-get install -fmy clang-format-5.0 clang-format-6.0 clang-format-7 clang-tidy-5.0 clang-tidy-6.0 clang-tidy-7 clang-tools-5.0 clang-tools-6.0 clang-tools-7
sudo apt-get install -fmy libc++1 libc++-dev libc++abi1 libc++abi-dev libc++1-7 libc++-7-dev libomp5 libomp-dev libomp5-7 libomp-7-dev libfuzzer-5.0-dev libfuzzer-6.0-dev libfuzzer-7-dev
#sudo apt-get install -fmy libclang1-5.0 libclang1-6.0 libclang1-7 libclang-5.0-dev libclang-6.0-dev libclang-7-dev libclang1 libclang-dev libclang-common-5.0-dev libclang-common-6.0-dev libclang-common-7-dev
sudo apt-get install -fmy ghc ghc-prof fp-compiler golang golang-1.7 golang-1.9 cython pypy

#MiKTeX
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
echo "deb http://miktex.org/download/ubuntu `lsb_release -cs` universe" | sudo tee /etc/apt/sources.list.d/miktex.list
sudo apt-get update
sudo apt-get install -fmy miktex

#LaTeX
sudo apt-get install -fmy texlive-science texmaker xzdec
sudo tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final
tlmgr init-usertree
tlmgr install dirtree

#Monitoring
sudo apt-get install -fmy htop tree

#LAMP setup
#sudo apt-get install -fmy apache2 mysql-server php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip php7.0-gd php7.0-json php7.0-curl php7.0-mbstring php7.0-imap php7.0-ldap

#Ruby development
#sudo apt-get install ruby
#sudo apt-get install ruby-dev
#sudo apt-get install rubygems-integration

#exit 0

#Setup LLVM
export BASE=`pwd`
export LLVM_SRC=${BASE}/llvm
export LLVM_BUILD=${BASE}/ninja
export POLLY_SRC=${LLVM_SRC}/tools/polly
export CLANG_SRC=${LLVM_SRC}/tools/clang
export LLD_SRC=${LLVM_SRC}/tools/lld
export CLANG_EXTRA_SRC=${CLANG_SRC}/tools/extra
export COMPILER_RT_SRC=${LLVM_SRC}/projects/compiler-rt
export COMPILER_OMP_SRC=${LLVM_SRC}/projects/openmp
export LIBCXX_SRC=${LLVM_SRC}/projects/libcxx
export LIBCXXABI_SRC=${LLVM_SRC}/projects/libcxxabi
#export TEST_SUITE=${LLVM_SRC}/projects/test-suite

for GPath in ${LLVM_SRC} ${POLLY_SRC} ${CLANG_SRC} ${LLD_SRC} ${COMPILER_RT_SRC} ${COMPILER_OMP_SRC} ${LIBCXX_SRC} ${LIBCXXABI_SRC} ${TEST_SUITE} ${CLANG_EXTRA_SRC};
do (
    if ! test -d ${GPath}; then
      if [ "$GPath" = "${CLANG_EXTRA_SRC}" ]; then
        git clone https://git.llvm.org/git/clang-tools-extra.git ${CLANG_EXTRA_SRC}
      else
        git clone https://git.llvm.org/git/`basename ${GPath}`.git ${GPath}
      fi
    else
        git -C $GPath checkout master
        git -C $GPath pull
    fi
    );
done

if ! test -d ${LLVM_TEST_SUITE}; then
    svn co https://llvm.org/svn/llvm-project/test-suite/trunk ${LLVM_TEST_SUITE}
fi

mkdir -p ${LLVM_BUILD}
cd ${LLVM_BUILD}
export CC=clang
export CXX=clang++
export CFLAGS='-O3 -DNDEBUG -gmlt -march=native -fno-omit-frame-pointer'
export CXXFLAGS=$CFLAGS
#export LDFLAGS="-Wl,-rpath=$HOME/lib64 -Wl,-rpath=$HOME/lib"
export LDFLAGS="-fuse-ld=gold"
sudo ln -sf /usr/include/x86_64-linux-gnu/asm /usr/include/asm
#sudo ln -s /usr/include/asm-generic /usr/include/asm

if which cmake ; then
  cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_BINUTILS_INCDIR=/usr/include \
  -DCMAKE_C_FLAGS_RELEASE= \
  -DCMAKE_CXX_FLAGS_RELEASE= \
  -DCMAKE_INSTALL_PREFIX=${LLVM_BUILD} \
  -DLIBCXX_ABI_UNSTABLE=OFF \
  -DLLVM_CCACHE_BUILD=ON \
  -DLLVM_ENABLE_ASSERTIONS=OFF \
  -DLIBCXX_ENABLE_ASSERTIONS=OFF \
  -DLIBCXXABI_ENABLE_ASSERTIONS=OFF \
  -DLLVM_ENABLE_LLD=OFF \
  -DLLVM_INCLUDE_GO_TESTS=OFF \
  -DLLVM_LIBDIR_SUFFIX=64 \
  -DLLVM_TARGETS_TO_BUILD="X86" \
  ${LLVM_SRC}
  ninja
else
    ${LLVM_SRC}/configure --enable-assertions --enable-debug-runtime
    #--prefix=/install/path/
    #--enable-assertions is debug build with assertions
    #--disable-optimized is debug build
    #--enable-optimized is release build
    #--enable-jit is for jit functionality
    #--enable-targets=x86, x86_64
    #--enable-doxygen

    make
fi

cd
if ! test -d dotfiles; then
  git clone https://github.com/utpalbora/dotfiles.git && cd vimrc
  ./vimrc.sh
  ./zsh.sh
fi

