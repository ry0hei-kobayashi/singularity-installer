sudo apt update

#install docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install docker-ce

#docker sudo 
sudo usermod -aG docker $USER

#install nessesary
# Ensure repositories are up-to-date
sudo apt-get update
# Install debian packages for dependencies
sudo apt-get install -y \
   autoconf \
   automake \
   make \
   cryptsetup \
   git \
   libfuse-dev \
   libglib2.0-dev \
   libseccomp-dev \
   libtool \
   pkg-config \
   runc \
   squashfs-tools \
   squashfs-tools-ng \
   uidmap \
   wget \
   make \
   zlib1g-dev

#install go
sudo rm -r /usr/local/go # remove prev go
#最新のGOのtarファイルを持ってきて/usr/local/で解凍
export VERSION=1.21.0 OS=linux ARCH=amd64
wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc
cd /usr/local/go/bin && cd 
source ~/.bashrc
sleep 1


# download singularity
export VERSION=4.1.0
wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-ce-${VERSION}.tar.gz
tar -xzf singularity-ce-${VERSION}.tar.gz
cd singularity-ce-${VERSION}

#install singularity
export VERSION=4.1.0
wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-ce-${VERSION}.tar.gz
tar -xzf singularity-ce-${VERSION}.tar.gz 
cd singularity-ce-${VERSION}

source ~/.bashrc
sleep 1

./mconfig
make -C ./builddir
sudo make -C ./builddir install

singularity help

# Set up user namespaces for unprivileged users, ubuntu24.04
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
# continue to use after reboot
echo 'kernel.apparmor_restrict_unprivileged_userns=0' | sudo tee /etc/sysctl.d/99-singularity.conf
sudo sysctl --system

#if your docker service is masked
sudo apt install docker.io

#if you use nvidia-container-toolkit
#edit /usr/local/etc/singularity 


