#!/bin/bash -aux

#Set server to 0 when executing on Desktop environment
server=1

#Change timezone
sudo ln -sf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime

#change mirror
sudo cp /etc/apt/sources.list /etc/apt/sources.list.`date '+%Y-%m-%d:%H:%M:%S'`
sudo sed -ri "s/[a-z]{2}[a-z]?.archive.ubuntu.com/mirror.iith.ac.in/" /etc/apt/sources.list
sudo sed -ri "s/security.ubuntu.com/mirror.iith.ac.in/" /etc/apt/sources.list

sudo apt-get update
sudo apt-get dist-upgrade -fmy
sudo apt-get autoremove -fmy
sudo apt-get install -fmy autoconf automake make m4 libtool flex bison build-essential ninja-build cmake ccache cmake-curses-gui
sudo apt-get install -fmy binutils binutils-dev gawk texinfo glpk-utils
sudo apt-get install -fmy git git-lfs subversion wget curl
sudo apt-get install -fmy perl tcl
sudo apt-get install -fmy python python-pip python-setuptools python3 python3-pip python3-setuptools
sudo apt-get install -fmy gcc g++ gfortran gdb
sudo apt-get install -fmy lld lldb clang clang-format clang-tidy clang-tools clangd #llvm
sudo apt-get install -fmy openssh-server screen tmux byobu
sudo apt-get install -fmy vim exuberant-ctags valgrind
sudo apt-get install -fmy libyaml-dev libstdc++5 libstdc++6 libc6-dev libboost-dev libboost-all-dev libglpk-dev libgmp-dev libmpfr-dev libmpfrc++-dev zlib1g-dev libxml2 libxml2-dev libedit-dev swig libconfig-dev
sudo apt-get install -fmy libblas-dev libopenblas-dev liblapack-dev libtmglib-dev liblapacke-dev libatlas-base-dev libclblas-dev

#Graphics Libraries (SDL, GLUT, OpenGL)
#sudo apt-get install -fmy libsdl2-dev freeglut3-dev mesa-common-dev

#Network Monitoring
#sudo apt-get install -fmy lsof tcpdump iftop vnstat iptraf ifstat dstat bwm-ng netdig speedometer bmon slurm nethogs nload
#sudo apt-get install -fmy top htop atop iotop iftop iostat


#perf
sudo apt-get install -fmy linux-tools-common linux-tools-generic

#Debugging
sudo apt-get install -fmy libunwind8-dev libelf-dev libdwarf-dev

#Extras
#sudo apt-get install -fmy zip unzip
sudo apt-get install -fmy libevent-dev libdouble-conversion-dev libgoogle-glog-dev libgflags-dev libiberty-dev liblz4-dev liblzma-dev libsnappy-dev  libjemalloc-dev libssl-dev pkg-config xutils-dev dconf-cli
sudo apt-get install -fmy zsh fonts-powerline

#SAT, SMT Solvers & Theorem Provers
#sudo apt-get install -fmy minisat minisat+ picosat clasp z3 libz3-4 libz3-dev cvc3 libcvc3-dev cvc4 libcvc4-dev boolector alt-ergo hol-light spass mona prover9 libqsopt-ex2 libqsopt-ex-dev coq why3
#MapleCM Maplesat Lingeling Plingeling Treengeling Glucose3 Glucose4 cryptominisat Isabelle

#Assamese fonts
if (( !server )); then
  sudo apt-get install -fmy fonts-lohit-beng-assamese
  #Good fonts
  sudo apt-get install -fmy fonts-dejavu fonts-inconsolata fonts-vollkorn fonts-ubuntu fonts-roboto fonts-powerline fonts-mononoki fonts-open-sans fonts-lato
fi

#UI
if (( !server )); then
  sudo apt-get install -fmy xdot graphviz
  sudo apt-get install -fmy terminator ranger quilt doxygen graphviz
fi

#Filesystem extras
#sudo apt-get install -fmy xfsprogs exfat-fuse exfat-utils

#Bluetooth Driver for Ubuntu 18.04
if (( !server )); then
  sudo add-apt-repository ppa:bluetooth/bluez
  sudo apt-get update
  sudo apt upgrade
  sudo apt-get install -fmy blueman pavucontrol pulseaudio-module-bluetooth
  sudo apt-get install -fmy bluetooth bluez bluez-tools rfkill
fi

if (( !server )); then
  #Cisco OpenConnect VPN
  sudo apt-get install -fmy network-manager-openconnect-gnome

  #Ubuntu restricted Extras
  sudo apt-get install -fmy ubuntu-restricted-extras
  sudo apt-get install -fmy adobe-flashplugin flashplugin-installer
fi

#GCC
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -fmy gcc-4.8 g++-4.8 gfortran-4.8 #gcc-4.8-multilib g++-4.8-multilib
sudo apt-get install -fmy gcc-5 g++-5 gfortran-5 #gcc-5-multilib g++-5-multilib
sudo apt-get install -fmy gcc-6 g++-6 gfortran-6 #gcc-6-multilib g++-6-multilib
sudo apt-get install -fmy gcc-7 g++-7 gfortran-7 #gcc-7-multilib g++-7-multilib
sudo apt-get install -fmy gcc-8 g++-8 gfortran-8 #gcc-8-multilib g++-8-multilib
sudo apt-get install -fmy gcc-9 g++-9 gfortran-9 #gcc-9-multilib g++-9-multilib
sudo apt-get install -fmy gcc-10 g++-10 gfortran-10 #gcc-10-multilib g++-10-multilib
#sudo apt-get install -fmy gcc-multilib g++-multilib
sudo apt-get install -fmy gcc-aarch64-linux-gnu gcc-mips-linux-gnu gcc-powerpc64-linux-gnu gcc-sparc64-linux-gnu gcc-arm-linux-gnueabi
sudo apt-get install -fmy g++-aarch64-linux-gnu g++-mips-linux-gnu g++-powerpc64-linux-gnu g++-sparc64-linux-gnu g++-arm-linux-gnueabi

#CMake PPA
sudo apt-get install -fmy apt-transport-https wget
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
sudo rm /usr/share/keyrings/kitware-archive-keyring.gpg
sudo apt-get install -fmy kitware-archive-keyring
sudo apt-get install -fmy cmake

#LLVM
UBUNTU_VERSION=`lsb_release -cs`
for llvm_ver in 5.0 6.0 7 8 9 10 11 12 13 14; do
count=$(grep -c "deb http://apt.llvm.org/${UBUNTU_VERSION}/ llvm-toolchain-${UBUNTU_VERSION}-${llvm_ver} main" /etc/apt/sources.list)
if [ $count -eq 0 ]; then
  echo "# LLVM ${llvm_ver}" | sudo tee -a /etc/apt/sources.list
  echo "deb http://apt.llvm.org/${UBUNTU_VERSION}/ llvm-toolchain-${UBUNTU_VERSION}-${llvm_ver} main" | sudo tee -a /etc/apt/sources.list
  echo "#deb-src http://apt.llvm.org/${UBUNTU_VERSION}/ llvm-toolchain-${UBUNTU_VERSION}-${llvm_ver} main" | sudo tee -a /etc/apt/sources.list
fi
done

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-get update
for llvm_ver in 5.0 6.0 7 8 9 10 11 12 13 14; do
  echo "LLVM Version ${llvm_ver}"
  echo sudo apt-get install -fmy clang-${llvm_ver} lld-${llvm_ver} #lldb-${llvm_ver} python-lldb-${llvm_ver} #llvm-${llvm_ver}
  echo sudo apt-get install -fmy clang-${llvm_ver}-dev lld-${llvm_ver}-dev #lldb-${llvm_ver}-dev #llvm-${llvm_ver}-dev
  echo sudo apt-get install -fmy clang-format-${llvm_ver} clang-tidy-${llvm_ver} clang-tools-${llvm_ver}
  echo sudo apt-get install -fmy libc++1-${llvm_ver} libc++abi1-${llvm_ver} libomp5-${llvm_ver} libclang1-${llvm_ver} libclang-cpp${llvm_ver}
  echo sudo apt-get install -fmy libc++-${llvm_ver}-dev libc++abi-${llvm_ver}-dev libomp-${llvm_ver}-dev libclang-${llvm_ver}-dev libclang-common-${llvm_ver}-dev libclang-cpp${llvm_ver}-dev
  echo sudo apt-get install -fmy libfuzzer-${llvm_ver}-dev
done
sudo apt-get install -fmy clang-5.0 lld-5.0 #llvm-5.0 lldb-5.0 python-lldb-5.0
sudo apt-get install -fmy clang-6.0 lld-6.0 #llvm-6.0 lldb-6.0 python-lldb-6.0
sudo apt-get install -fmy clang-7 lld-7 #llvm-7 lldb-7 python-lldb-7
sudo apt-get install -fmy clang-8 lld-8 #llvm-8 lldb-8 python-lldb-8
sudo apt-get install -fmy clang-9 lld-9 #llvm-9 lldb-9 python-lldb-9
sudo apt-get install -fmy clang-10 lld-10 #llvm-10 lldb-10 python-lldb-10
sudo apt-get install -fmy clang-11 lld-11 #llvm-11 lldb-11 python-lldb-11
sudo apt-get install -fmy clang-12 lld-12 #llvm-12 lldb-12 python-lldb-12
sudo apt-get install -fmy clang-13 lld-13 #llvm-13 lldb-13 python-lldb-13
sudo apt-get install -fmy clang-14 lld-14 #llvm-14 lldb-14 python-lldb-14
#sudo apt-get install -fmy llvm-5.0-dev clang-5.0-dev lld-5.0-dev #lldb-5.0-dev
#sudo apt-get install -fmy llvm-6.0-dev clang-6.0-dev lld-6.0-dev #lldb-6.0-dev
#sudo apt-get install -fmy llvm-7-dev clang-7-dev lld-7-dev #lldb-7-dev
#sudo apt-get install -fmy llvm-8-dev clang-8-dev lld-8-dev #lldb-8-dev
#sudo apt-get install -fmy llvm-9-dev clang-9-dev lld-9-dev #lldb-9-dev
#sudo apt-get install -fmy llvm-10-dev clang-10-dev lld-10-dev #lldb-10-dev
#sudo apt-get install -fmy llvm-11-dev clang-11-dev lld-11-dev #lldb-11-dev
#sudo apt-get install -fmy llvm-12-dev clang-12-dev lld-12-dev #lldb-12-dev
#sudo apt-get install -fmy llvm-13-dev clang-13-dev lld-13-dev #lldb-13-dev
#sudo apt-get install -fmy llvm-14-dev clang-14-dev lld-14-dev #lldb-14-dev
#sudo apt-get install -fmy clang-format-5.0 clang-tidy-5.0 clang-tools-5.0
#sudo apt-get install -fmy clang-format-6.0 clang-tidy-6.0 clang-tools-6.0
#sudo apt-get install -fmy clang-format-7 clang-tidy-7 clang-tools-7
#sudo apt-get install -fmy clang-format-8 clang-tidy-8 clang-tools-8
#sudo apt-get install -fmy clang-format-9 clang-tidy-9 clang-tools-9
#sudo apt-get install -fmy clang-format-10 clang-tidy-10 clang-tools-10
#sudo apt-get install -fmy clang-format-11 clang-tidy-11 clang-tools-11
#sudo apt-get install -fmy clang-format-12 clang-tidy-12 clang-tools-12
#sudo apt-get install -fmy clang-format-13 clang-tidy-13 clang-tools-13
#sudo apt-get install -fmy clang-format-14 clang-tidy-14 clang-tools-14
#sudo apt-get install -fmy libc++1-5.0 libc++abi1-5.0 libomp5-5.0 libclang1-5.0
#sudo apt-get install -fmy libc++-5.0-dev libc++abi-5.0-dev libomp-5.0-dev libclang-5.0-dev libclang-common-5.0-dev
#sudo apt-get install -fmy libc++1-6.0 libc++abi1-6.0 libomp5-6.0 libclang1-6.0
#sudo apt-get install -fmy libc++-6.0-dev libc++abi-6.0-dev libomp-6.0-dev libclang-6.0-dev libclang-common-6.0-dev
#sudo apt-get install -fmy libc++1-7 libc++abi1-7 libomp5-7 libclang1-7
#sudo apt-get install -fmy libc++-7-dev libc++abi-7-dev libomp-7-dev libclang-7-dev libclang-common-7-dev
#sudo apt-get install -fmy libc++1-8 libc++abi1-8 libomp5-8 libclang1-8
#sudo apt-get install -fmy libc++-8-dev libc++abi-8-dev libomp-8-dev libclang-8-dev libclang-common-8-dev
#sudo apt-get install -fmy libc++1-9 libc++abi1-9 libomp5-9 libclang1-9
#sudo apt-get install -fmy libc++-9-dev libc++abi-9-dev libomp-9-dev libclang-9-dev libclang-common-9-dev
#sudo apt-get install -fmy libc++1-10 libc++abi1-10 libomp5-10 libclang1-10
#sudo apt-get install -fmy libc++-10-dev libc++abi-10-dev libomp-10-dev libclang-10-dev libclang-common-10-dev
#sudo apt-get install -fmy libc++1-11 libc++abi1-11 libomp5-11 libclang1-11
#sudo apt-get install -fmy libc++-11-dev libc++abi-11-dev libomp-11-dev libclang-11-dev libclang-common-11-dev
#sudo apt-get install -fmy libc++1-12 libc++abi1-12 libomp5-12 libclang1-12
#sudo apt-get install -fmy libc++-12-dev libc++abi-12-dev libomp-12-dev libclang-12-dev libclang-common-12-dev
#sudo apt-get install -fmy libc++1-13 libc++abi1-13 libomp5-13 libclang1-13
#sudo apt-get install -fmy libc++-13-dev libc++abi-13-dev libomp-13-dev libclang-13-dev libclang-common-13-dev
#sudo apt-get install -fmy libc++-14-dev libc++abi-14-dev libomp-14-dev libclang-14-dev libclang-common-14-dev
# Default LLVM packages
sudo apt-get install -fmy libc++1 libc++abi1 libomp5 libclang1
sudo apt-get install -fmy libc++-dev libc++abi-dev libomp-dev libclang-dev
#sudo apt-get install -fmy llvm-dev lld-dev clang-dev clang-format-dev clang-tidy-dev clang-tools-dev
# Other compilers
sudo apt-get install -fmy ghc ghc-prof fp-compiler golang golang-1.7 golang-1.9 cython pypy

#MiKTeX
if (( !server )); then
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
  #echo "deb http://miktex.org/download/ubuntu ${UBUNTU_VERSION} universe" | sudo tee /etc/apt/sources.list.d/miktex.list
  #sudo apt-get update
  #sudo apt-get install -fmy miktex
fi

#LaTeX
if (( !server )); then
  sudo apt-get install -fmy texlive-science texmaker xzdec
  sudo tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final
  tlmgr init-usertree
  tlmgr install dirtree
fi

#Monitoring
sudo apt-get install -fmy htop tree

#LAMP setup
#sudo apt-get install -fmy apache2 mysql-server php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip php7.0-gd php7.0-json php7.0-curl php7.0-mbstring php7.0-imap php7.0-ldap

#Ruby development
if (( !server )); then
  sudo apt-get install -fmy ruby-full build-essential zlib1g-dev
  #echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
  #echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
  #echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
  #source ~/.bashrc
  #echo 'export GEM_HOME="$HOME/gems"'
  #echo 'export PATH="$HOME/gems/bin:$PATH"'
  #gem install jekyll bundler
fi

#Setup Dotfiles
if ! test -d dotfiles; then
  git clone https://github.com/utpalbora/dotfiles.git && cd dotfiles
  ./vimrc.sh
  ./zsh.sh
fi

#Github hub setup
if ! test -d $HOME/hub-linux-amd64-2.6.0; then
  wget https://github.com/github/hub/releases/download/v2.6.0/hub-linux-amd64-2.6.0.tgz
  tar -xf hub-linux-amd64-2.6.0.tgz
  mv hub-linux-amd64-2.6.0 $HOME/hub-linux-amd64-2.6.0
  rm hub-linux-amd64-2.6.0.tgz
  echo 'export PATH="$PATH:$HOME/hub-linux-amd64-2.6.0/bin/"' >> $HOME/.profile
  bashhub=$(grep -c "$HOME/hub-linux-amd64-2.6.0/etc/hub.bash_completion.sh" $HOME/.bashrc)
  if [ $bashhub -eq 0 ]; then
    echo "if [ -f $HOME/hub-linux-amd64-2.6.0/etc/hub.bash_completion.sh ] ; then" >> $HOME/.bashrc
    echo ". $HOME/hub-linux-amd64-2.6.0/etc/hub.bash_completion.sh" >> $HOME/.bashrc
    echo "fi" >> $HOME/.bashrc
  fi
  zshhub=$(grep -c "$HOME/hub-linux-amd64-2.6.0/etc/hub.zsh_completion" $HOME/.zshrc)
  if [ $zshhub -eq 0 ]; then
    echo "source $HOME/hub-linux-amd64-2.6.0/etc/hub.zsh_completion" >> $HOME/.zshrc
  fi
fi

# Remap CAPS to ESCAPE
capsesc=$(grep -c "XKBOPTIONS=\"caps:escape\"" /etc/default/keyboard)
if [ $capsesc -eq 0 ]; then
  echo "XKBOPTIONS=\"caps:escape\"" | sudo tee -a /etc/default/keyboard
  sudo dpkg-reconfigure keyboard-configuration
fi

exit 0

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
