# HelloWebPKS
* Tested on OSX 10.12.6 and go 1.9

## Install JAVA
* This is not necessary as we will use a golang base container in our Dockerfile.

## Application Build Step
High Level is checkout the REPO and compiled in Netbeans or other.

## Test Application running in a Container with a tomcat
1. $ docker run -it -p 8088:8080 -v $(PWD)/dist/HelloWebPKS.war:/usr/local/tomcat/webapps/HelloWebPKS.war tomcat
2. TEST by accessing the port on local
  http://localhost:8088/HelloWebPKS/

## Build Application into a Docker Container
(Docker or Build Host)
* Checkout the Repo.
  * git clone https://github.com/tkrausjr/go-http.git
  * cd ./go-http
* Build the Go Binaries from Src.
  * docker build -t hellowwebpks:v2 .
* SHOW Build Output
  * docker images
* Test Locally:
  * docker run -p 8080:8080 --name="testing-conference-app:latest" -d conference-app

1. kraust: ~/gitHub/HelloWebPKS $ docker build -t hellowwebpks:v2 .
    1. Sending build context to Docker daemon  272.4kB
    2. Step 1/4 : FROM tomcat
    3.  ---> 2d43521f2b1a
    4. Step 2/4 : MAINTAINER TKraus
    5.  ---> Using cache
    6.  ---> 3df5829cc2f6
    7. Step 3/4 : COPY /dist/HelloWebPKS.war /usr/local/tomcat/webapps/HelloWebPKS.war
    8.  ---> Using cache
    9.  ---> e0e82275a9da
    10. Step 4/4 : EXPOSE 8080:8080
    11.  ---> Using cache
    12.  ---> 855794fafd89
    13. Successfully built 855794fafd89
    14. Successfully tagged hellowwebpks:v2
2. kraust: ~/gitHub/HelloWebPKS $ docker run -p 8080:8080 hellowwebpks:v2

## Push the Image to a new Repository
* (Optional) Log in to new repository
  * docker login 10.173.13.31 -u admin
* Tag the newly built image
  * docker tag conference-app:latest 10.173.13.31/conference/conference-app:latest
* Push the newly built image.
  * docker push 10.173.13.31/conference/conference-app:latest

## Run the site in Kubernetes Cluster
* Create a Deployment with the Image 
  * kubectl run conference-app --replicas=2 --labels="run=conference-app" --image=tkrausjr/conference-app:latest --port=8080
* Create an externally accessible Service for the Deployment
  * kubectl expose deployment conference-app --type=NodePort --name=conference-app
* Get NodePort: Value  (Ex. 32449 )
  * kubectl describe services conference-app
* Get node name ( Ex. vm-c7d7773d-fd57-4efa-b8aa-14c405dde4cb)
  * kubectl get nodes 
* Get IP  (Ex. 10.190.64.71) 
  * kubectl describe node vm-c7d7773d-fd57-4efa-b8aa-14c405dde4cb
* Now you can test access at http://<ExternalIP>:<NodePort>
  * Chrome http://10.190.64.71:32449
  * curl http://10.190.64.71:32449

## Run the site locally right from the local REPO.
* $ cd /Users/kraust/Documents/go-workspace/src/github/demo-app
* $ go run conference-app.go

## Test
* Note the PORT the server is Listening on:
* Open Chrome and navigate to http://localhost:<port>  Defaults to :8080 

## Update the Website Static Content
The App will serve the contents of the /public folder so to make canges to the Website you would update the contents of the ./public folder. In this case we are using the Open Source product HUGO so we change our site settings in this repo (https://github.com/tkrausjr/my-conference) and the output is put in a ./public folder which we can move over to the go-http repo.
* $ cp -R ./public ~/github/go-http/