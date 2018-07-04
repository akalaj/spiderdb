#!/bin/bash

#Variables
HASH="4b677d698c65370afa33757b6954ade60347aaca310ea92a63ed717d7cb0c2ff"
GO_TAR_PACKAGE="go1.10.2.linux-amd64.tar.gz"

#Ensure this is not being run as root
if [ "$EUID" -ne 0 ]; then
	:
else
	echo "Please run this script as a non-root user so that Golang is not limited to the root user."
	exit 1
fi

#install curl
apt install curl -y

#download golang package
curl -O https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz

#verify successful transfer
if [ ! -f ./${GO_TAR_PACKAGE} ]; then
    echo -e "${GO_TAR_PACKAGE} File not found!\nPlease check if curl was successful"
    exit 1
fi

#verify checksum
SUM=$(sha256sum go1.10.2.linux-amd64.tar.gz)
if [[ ${SUM} != ${HASH} ]]; then
	echo -e "Sketchy...file hash doesn't match.\nCheck out the validity of that download.\n Like fa real WTF. Can't believe that shit don't match.\nThese ma fuckas hating. Fuck tha hatas.\nFarty..."
fi

#Extract go
tar xvf go1.10.2.linux-amd64.tar.gz

#Chown and move dir
sudo chown -R root:root ./go
sudo mv go /usr/local

#Create profile & add to env
echo -e "export GOPATH=$HOME/work\nexport PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> ~/.profile
source ~/.profile
