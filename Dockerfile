# Build Stage
FROM openjdk:17-slim AS builder

# Set working directory
WORKDIR /usr/src/app

# Copy Maven wrapper separately to leverage caching
COPY ./.mvn/ .mvn/
COPY ./mvnw pom.xml ./

RUN chmod +x ./mvnw

# the mvn dependency:go-offline can be used to ensure you have
# all of your dependencies installed locally before you begin to work offline.
RUN ./mvnw dependency:go-offline
# Copy application source code
COPY ./src/ src/

# Build the application
RUN ./mvnw clean package -DskipTests

# Runtime Stage
FROM openjdk:17-slim

# Create a non-root user (diff between useradd and adduser)
RUN useradd -m appuser

WORKDIR /usr/src/app

# Copy the built JAR file from the builder stage
COPY --from=builder /usr/src/app/target/*.jar app.jar

# Change ownership and switch to non-root user
RUN chown -R appuser:appuser /usr/src/app
USER appuser

# Expose the application port
EXPOSE 8080

# Set entry point to run
ENTRYPOINT ["java", "-jar", "app.jar"]
