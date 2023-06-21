# Base
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /code
COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src

# Package
RUN mvnw package

# Final
FROM adoptopenjdk:8-jre-hotspot

# Set the working directory
WORKDIR /code
COPY --from=build /code/target/.jar .
EXPOSE 8080
CMD ["java", "-jar", ".jar"]
