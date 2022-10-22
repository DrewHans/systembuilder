#!/usr/bin/env bash


command -v java >/dev/null 2>&1 && {
	echo "java detected:"
	java -version
	echo ""
} || {
	echo "Java was not detected"
	echo "Aborting"
	exit 1
}

command -v javac >/dev/null 2>&1 && {
	echo "Java Development Kit detected"
	javac -version
	echo ""
} || {
	echo "Java Development Kit was not detected"
	echo "Aborting"
	exit 1
}

wget https://services.gradle.org/distributions/gradle-7.5.1-bin.zip

sudo mkdir -p /opt/gradle
sudo unzip -d /opt/gradle gradle-7.5.1-bin.zip

export PATH=$PATH:/opt/gradle/gradle-7.5.1/bin
