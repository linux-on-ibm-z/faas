#!/bin/sh
set -e

export arch=$(uname -m)
export eTAG="latest-dev"
export DOCKERFILE="Dockerfile"

if [ "$arch" = "armv7l" ] ; then
   eTAG="latest-armhf-dev"
elif [ "$arch" = "aarch64" ] ; then
   eTAG="latest-arm64-dev"
   DOCKERFILE="Dockerfile.arm64"
elif [ "$arch" = "s390x" ] ; then
   eTAG="latest-s390x-dev"
   DOCKERFILE="Dockerfile.s390x"
fi

echo "$1"
if [ "$1" ] ; then
  eTAG=$1
  if [ "$arch" = "armv7l" ] ; then
    eTAG="$1-armhf"
  elif [ "$arch" = "aarch64" ] ; then
    eTAG="$1-arm64"
  elif [ "$arch" = "s390x" ] ; then
    eTAG="$1-s390x"
  fi
fi

NS=openfaas

echo Building $NS/basic-auth-plugin:$eTAG

docker build -t $NS/basic-auth-plugin:$eTAG . -f $DOCKERFILE

