# Use a minimal base image
FROM alpine:3.18

# Set a working directory
WORKDIR /app

# Copy readme
COPY README.md /app/README.md

# Run a basic command to demonstrate functionality
CMD ["echo", "Hello, Docker!"]
