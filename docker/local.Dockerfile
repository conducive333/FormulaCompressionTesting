FROM ubuntu:18.04

# Install helper packages
RUN apt-get update && apt-get install -y vim

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;
    
# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# Get local files and folders
COPY ./.m2 ./home/cdeleon/.m2
COPY ./testing ./home/cdeleon/FormulaCompressionTesting/testing
COPY ./dataspread-web ./home/cdeleon/FormulaCompressionTesting/dataspread-web