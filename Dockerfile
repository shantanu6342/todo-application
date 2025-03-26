# write your Docker file code here
FROM maven:3.9.0-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/ToDo-Application-0.0.1-SNAPSHOT.jar ToDo-Application-0.0.1-SNAPSHOT.jar
EXPOSE 8081
CMD [ "java", "-jar", "ToDo-Application-0.0.1-SNAPSHOT.jar", "test" ]