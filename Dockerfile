# Use ubi8 as the base image
FROM registry.access.redhat.com/ubi8/ubi:latest

# Install necessary tools
RUN yum -y install curl tar gzip

# Set the JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

# Install OpenJDK 11
RUN yum -y install java-11-openjdk-devel

# Verify the installation
RUN java -version

# Set the MAVEN_HOME environment variable
ENV MAVEN_HOME=/opt/maven

# Set the PATH environment variable
ENV PATH=${MAVEN_HOME}/bin:${PATH}

# Define the version of Maven
ARG MAVEN_VERSION=3.8.4

# Download and install Maven
RUN curl -L https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -o /tmp/apache-maven.tar.gz && \
    tar xf /tmp/apache-maven.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
    rm -f /tmp/apache-maven.tar.gz

