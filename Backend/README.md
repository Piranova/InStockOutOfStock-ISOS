## Technical Details
* Python Flask
* Mongo Database
* MongoEngine Client
* Docker

## Pre-requisites
* Make sure docker is installed. Follow [this link](https://docs.docker.com/get-docker/) to get details of docker installation.


## Instructions
* Once the docker is installed, To boot-up the docker containers, run below commands from InStockOutOfStock-ISOS folder.
```
# To build docker images:
docker-compose build

# To run the docker containers:
docker-compose up
```

* Now to test service is running, launch http://localhost:5000/isos/ from any browser, should see below response.
```
{
    "message": "InStockOutofStock-ISOS App is running!",
    "result": "Success"
}
```

* [Postman Collections Link](https://www.getpostman.com/collections/e5bda7677a968731fa44)
