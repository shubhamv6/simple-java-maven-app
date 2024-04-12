#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application into the local Maven repository, which will ultimately be stored in Jenkins\'s local Maven repository (and the "maven-repository" Docker data volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following command extracts the value of the <name/> element within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn -q -DforceStdout help:evaluate -Dexpression=project.name`
echo $NAME
set +x

echo 'The following command behaves similarly to the previous one but extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn -q -DforceStdout help:evaluate -Dexpression=project.version`
echo $VERSION
set +x

echo 'The following command runs and outputs the execution of your Java application (which Jenkins built using Maven) to the Jenkins UI.'
FILENAME=${NAME}-${VERSION}
echo $FILENAME
set -x
java -jar target/${NAME}-${VERSION}.jar
