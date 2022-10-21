#!/usr/bin/env bash


# install OpenJDK
sudo apt update

sudo apt install default-jre default-jdk --yes

command -v java >/dev/null 2>&1 && {
    echo "Java has been installed"
    echo "java version installed:"
    java -version
    echo ""
}

command -v javac >/dev/null 2>&1 && {
    echo "Java Development Kit has been installed"
    echo "javac version installed:"
    javac -version
    echo ""
}
