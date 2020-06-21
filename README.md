# multistage-docker-go



## Build the Docker image

The docker file is a multistage docker file, it contains two stages

builder -> used to build the go application
production -> high performance lite container to run the go application

### Development

```docker build [-f Dockerfile] --target builder -t myserver:v0.1 .```


### Production

```docker build [-f Dockerfile] -t myserver:v0.1 .```


## Running the Docker image


```docker run --name myserver -p 8000:8000 --dns 8.8.8.8 --dns 8.8.4.4 -it myserver:v0.1```
