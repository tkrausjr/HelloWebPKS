# HelloWebPKS
* Develeoped on OSX 10.12.6 and Netbeans 8.2 and JRE and JDK 1.8


## Application Build from Source
High Level is checkout the REPO and compile in Netbeans or use Maven.
Artifact is a WAR file located in /dist folder.

## Test Application running in a tomcat Container 
* docker run -it -p 8088:8080 -v $(PWD)/dist/HelloWebPKS.war:/usr/local/tomcat/webapps/HelloWebPKS.war tomcat
* TEST by accessing the port on local
  http://localhost:8088/HelloWebPKS/

## Build Application into a Docker Container
(Docker or Build Host)
* Checkout the Repo.
  * git clone https://github.com/tkrausjr/HelloWebPKS.git
  * cd ./HelloWebPKS
* Build the Compiled WAR file into a Tomcat Docker Image and Save.
  * docker build -t hellowwebpks:v2 .
* SHOW Build Output
  * docker images
* Test Locally:
  * docker run -p 8080:8080 hellowwebpks:v2

## Push the Image to a new Repository
* (Optional) Log in to new repository
  * docker login harbor.tpmlab.vmware.com -u admin
* Tag the newly built image
  * docker tag hellowwebpks:v2 harbor.tpmlab.vmware.com/library/hellowwebpks:v2
* Push the newly built image.
  * docker push harbor.tpmlab.vmware.com/library/hellowwebpks:v2

## Run the site in Kubernetes Cluster
* Create a Deployment with the Image 
  * kubectl run hello-java --replicas=2 --labels="run=hello-java" --image=harbor.tpmlab.vmware.com/library/hellowwebpks:v2 --port=8080
* Create an externally accessible Service for the Deployment
  * k expose deployment hello-java --type=LoadBalancer --name=hello-java-svc
* Get LoadBalancer VIP External Address
  * kubectl get svc
* Now you can test access at http://<ExternalIP>:8080/HelloWebPKS/
  * Chrome http://10.51.0.56:8080/HelloWebPKS/

