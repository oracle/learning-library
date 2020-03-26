# hello earth
Another hello world type docker container example

This example is used for this Hands On Lab and runs on host port 80

Fork this example to your GitHub account, then after you build it in your Docker Hub account, replace "username" with your Docker Hub user name in the Docker commands below.

To pull this image: 
```
docker pull username/hello-earth:latest
```

To run this image: 
```
docker run -d -p 80:80/tcp "username/hello-earth:latest"
```
