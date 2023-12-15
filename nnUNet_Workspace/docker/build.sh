#!/usr/bin/env bash
REG="xuanminator"
REPO="compat"
VER="$1"
echo "Building ${REG}/${REPO}:${VER}"
echo "Adjust build.sh and Dockerfile as needed."
docker build -t ${REG}/${REPO}:${VER} --build-arg NAMBA=${VER} .
