FROM maven:3.9.7-sapmachine-21 AS build

WORKDIR /app

COPY demo/pom.xml .

RUN mvn dependency:go-offline

COPY demo/src ./src

RUN mvn -f pom.xml clean package -DskipTests

#FROM eclipse-temurin:17-jre-alpine
FROM openjdk:21-jdk-slim
     
WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl dumb-init && \
    addgroup --system javauser && \
    adduser -S -s /bin/false -G javauser javauser && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8888

RUN chown -R javauser:javauser /app

USER javauser

CMD "dumb-init" "java" "-jar" "app.jar"