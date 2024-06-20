FROM maven:3.9.7-sapmachine-21

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY simple-backend/pom.xml ./

RUN mvn dependency:go-offline

COPY /simple-backend .
     
RUN mvn clean install -DskipTests

EXPOSE 8888

HEALTHCHECK --interval=10s --timeout=30s \
     --retries=3 CMD curl -f http://localhost:8888/api/message|| exit 1


CMD ["sh", "-c", "mvn spring-boot:run"]