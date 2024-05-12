# Use a base image with Java and Maven pre-installed
FROM maven:3.3-jdk-8

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn package

# Use a lightweight base image for the final container
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the compiled application from the builder stage
COPY --from=builder /java-project/target/myjavaapp-1.0-SNAPSHOT.jar ./app.jar

# Specify the command to run on container start
CMD ["java", "-jar", "app.jar"]
