# Use a base image with openjdk 21
FROM eclipse-temurin:21-jdk-jammy

# Add metadata labels
LABEL org.opencontainers.image.source="https://github.com/erodde/mycore-website"
LABEL org.opencontainers.image.description="MyCoRe website docker image"
LABEL org.opencontainers.image.licenses="MIT"

# Set the working directory
WORKDIR /app

# Install curl and git
RUN apt-get update && \
    apt-get install -y curl git && \
    rm -rf /var/lib/apt/lists/*

# Install Maven 3.9.6
ENV MAVEN_VERSION=3.9.6
ENV MAVEN_HOME=/opt/maven/apache-maven-${MAVEN_VERSION}
ENV PATH=${MAVEN_HOME}/bin:${PATH}

RUN mkdir -p ${MAVEN_HOME} && \
    curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar xzf - -C ${MAVEN_HOME} --strip-components=1

# Install gohugo extended 0.89.4
ENV HUGO_VERSION=0.89.4
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar xzf - -C /tmp && \
    mv /tmp/hugo /usr/local/bin/hugo && \
    chmod +x /usr/local/bin/hugo

# Copy the pom.xml to the container
COPY pom.xml /app/

# Load all dependencies necessary for building
RUN mvn dependency:go-offline

# Set default args needed inside the entrypoint
ARG GIT_REPO_URL="https://github.com/MyCoRe-Org/mycore-website.git"
ARG HUGO_BASE_URL="https://www.mycore.de"

# Set the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh ${GIT_REPO_URL} ${HUGO_BASE_URL}
