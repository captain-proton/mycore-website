# Use a minimal base image
FROM alpine:3.18

# Add metadata labels
LABEL org.opencontainers.image.source="https://github.com/erodde/mycore-website"
LABEL org.opencontainers.image.description="Workflow test docker image"
LABEL org.opencontainers.image.licenses="MIT"

# Set a working directory
WORKDIR /app

# Copy readme
COPY README.md /app/README.md

# Run a basic command to demonstrate functionality
CMD ["echo", "Hello, Docker!"]
