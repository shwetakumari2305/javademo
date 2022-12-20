FROM openjdk
MAINTAINER shweta2305@gmail.com
EXPOSE 8080
WORKDIR /usr
COPY ./target/demo-0.0.1.jar /usr/app.jar
ENTRYPOINT ["java","-jar","app.jar"]
