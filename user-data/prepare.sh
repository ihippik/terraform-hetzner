#!/usr/bin/env bash

apt-get update
apt-get upgrade -y

apt-get install -y \
  python3-minimal \
  python3-apt \
  python3-pip
