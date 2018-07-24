# Dockerfile used to download latest tomcat image
# and build a new Docker Image 
# Copy in the WAR file for the HelloWebPKS.war
# Listening on port TCP 8088

FROM tomcat

MAINTAINER  TKraus 

# Create a directory inside the container to store our go web app and
# make it working directory.
# RUN mkdir -p /go/src/go-http
# WORKDIR /go/src/go-http

# Copy the WAR file into the webapps directory in Tomcat 
COPY /dist/HelloWebPKS.war /usr/local/tomcat/webapps/HelloWebPKS.war


# Expose port 8080 to the host so that outer-world can access your application
EXPOSE 8080:8080


