# Compile the app using maven
FROM maven:3.9.4-amazoncorretto-21 as build

WORKDIR /app
COPY . .
RUN mvn compile

# jdbc driver downloader
FROM alpine:latest as jdbc-driver
ENV jdbc_driver_download_url=https://downloads.mariadb.com/Connectors/java/connector-java-3.2.0/mariadb-java-client-3.2.0.jar

RUN apk update && apk add curl

WORKDIR /drivers
RUN curl -SOLs ${jdbc_driver_download_url}

# Final
FROM amazoncorretto:21-alpine-jdk as app

COPY --from=jdbc-driver /drivers /app/drivers
COPY --from=build /app/target/classes /app/classes

ENV DB_HOST=mariadb

CMD java -cp /app/drivers/*:/app/classes org/example/Main