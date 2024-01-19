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
ARG MAVEN_VERSION=3.6.3

# Download and install Maven
#RUN curl -L https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -o /tmp/apache-maven.tar.gz && \
#    tar xf /tmp/apache-maven.tar.gz -C /opt && \
#    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
#    rm -f /tmp/apache-maven.tar.gz

#for old mavens
RUN curl -L https://mirrors.huaweicloud.com/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o /tmp/apache-maven.tar.gz && \
    tar xf /tmp/apache-maven.tar.gz -C /opt && \
    ln -s /opt/apache-maven-3.6.3 /opt/maven && \
    rm -f /tmp/apache-maven.tar.gz

# Set a different user (not tc agent) but the shared group with a real ID from the host
RUN groupadd -g 1001 sharedgroup && \
    useradd -ms /bin/bash -g sharedgroup newuser
USER newuser
