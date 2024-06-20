FROM maven:3.9.7-sapmachine-21 AS build

WORKDIR /app

COPY demo/pom.xml .
COPY demo/src ./src

RUN mvn -f pom.xml clean package

FROM openjdk:21-jdk-slim
     
WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8888

CMD ["java", "-jar", "app.jar"]