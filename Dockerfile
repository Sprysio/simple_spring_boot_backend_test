FROM maven:3.9.7-sapmachine-21 AS build

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY demo/pom.xml .
COPY demo/src ./src

RUN mvn clean install -DskipTests

FROM maven:3.9.7-sapmachine-21
     
WORKDIR /app

COPY --from=build /app/target/app*.jar .

EXPOSE 8888

CMD ["java", "-jar", "app.jar"]