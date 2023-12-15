#!/bin/sh

swap-java(){
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
}

swap-javac(){ # if java is in the latest, only need to change javac for each other version used
    sudo update-alternatives --config javac
}

mvn-build-test(){
    sudo mvn package
}

mvn-build(){
    sudo mvn package -Dmaven.test.skip
}

mvn-spring-run(){
    sudo mvn clean spring-boot:run
}
