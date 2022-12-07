FROM openjdk
EXPOSE 8080
WORKDIR /usr/jenkins
COPY ./target/demo-0.0.1.jar   /usr/jenkins
ENTRYPOINT ["java","-jar","demo-0.0.1.jar"]
