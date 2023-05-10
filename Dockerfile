# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jdk-slim

RUN mkdir -p /home/app
# Set the working directory to /app
WORKDIR /home/app

# Install Maven
RUN apt-get update && \
    apt-get install -y maven

# Copy the pom.xml file to the container
COPY pom.xml /home/app

# Download all dependencies. This step is cached unless the pom.xml file changes.
#RUN mvn dependency

# Copy the rest of the application to the container
COPY . /home/app

# Build the application
RUN mvn package -DskipTests

# Expose port 8080 for the container
EXPOSE 3090

# Run the application
CMD ["java", "-jar", "target/java-maven-app-1.1.0-SNAPSHOT.jar"]
