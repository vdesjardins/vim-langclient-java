#!/bin/bash

command -v mvn 2>/dev/null
if [[ "$?" != 0 ]]; then
  echo "Maven not found in PATH. Please install Maven to compile Eclipse JDT"
    exit 1
fi

command -v javac 2>/dev/null
if [[ "$?" != 0 ]]; then
    echo "javac not found in PATH. Please install JDK 1.8 to compile Eclipse JDT"
    exit 1
fi

set -e

rm -rf eclipse
mkdir eclipse

git clone https://github.com/eclipse/eclipse.jdt.ls.git eclipse

pushd .
cd eclipse

mvn clean verify

popd


