#!/bin/sh

swap-java(){
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
}
swap-javac(){ # if java is in the latest, only need to change javac for each other version used
    sudo update-alternatives --config javac
}
mvn-package-test(){
    mvn package
}
mvn-install(){
    mvn clean install -DskipTests
}
mvn-package(){ # TODO test this
    mvn clean package -DskipTests
}
mvn-spring-run(){
    mvn spring-boot:run -DskipTests -Dspring-boot.run.profiles=$1
}
# mvn-spring-run3(){
#     # find the jar inside target folder
#     mvn-package
#     java -jar $1 --spring.profiles.active=$2
# }
# mvn-spring-run2(){
#     # find the jar inside target folder
#     mvn-package
#     java -jar $1 -Drun.jvmArguments="-Dspring.profiles.active=$2"
# }
