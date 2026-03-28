FROM openjdk:21-ea-2-jdk-slim

COPY target/product-service-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]