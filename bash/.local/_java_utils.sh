#!/bin/sh

swap-java(){
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
}

swap-javac(){ # if java is in the latest, only need to change javac for each other version used
    sudo update-alternatives --config javac
}

mvn-build-test(){
    mvn package
}

mvn-build(){
    mvn clean install -Dmaven.test.skip
}

mvn-spring-run(){
    mvn clean spring-boot:run
}
