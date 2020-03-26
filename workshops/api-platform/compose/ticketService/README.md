# TicketService
This is a simple microservice that is used to store Service Tickets.  Following the principles of Microservices, this service is domain-bound to handle service tickets and only service tickets.  This service also maintains it's own copy of the data, even if the data exists elsewhere.

This service is used in the [Warranty Claim](../../../scenarios/warrantyClaim) training scenario.
![](../../../scenarios/warrantyClaim/TicketService.png)

## Getting Started
### Before you begin
Building, deploying and running this is optional.  Below there is a hosted option that you can use if you are just testing the read capability of the service.  In order to insert/update records, you need to have the appropriate basic-auth credentials.

> Note: If you choose to build and deploy your own, make sure you first edit [tickets-app.py](./tickets-app.py) and replace the user and password used in the basic auth function.  This is exceptionally important if you are deploying this to a cloud resource.  Furthermore you should protect the service!

### Hosted version
This service is running and available at http://oc-129-158-107-171.compute.oraclecloud.com:5000/tickets  This is just the raw service which you can use as the service request for your APIs.

### Host your own
Using docker and docker-compose you can very quickly spin up an instance of the microservice and use it in your testing.  This is purely an optional step and not necessary for testing API Platform.  This is simply if you want to test the service more in-depth with creating and updating records, etc.

> To learn more about installing and running docker and docker-compose, visit http://docker.com

Be aware that docker-compose is designed to build, deploy and run containers as well as clean everything up when you shut down.  If you wish to seed some sample tickets, you can use the [createTickets.json](./createTickets.json) file.  A sample command in cURL is:
`curl -X POST -u demoUSER:b0a3ae6162 -d @createTickets.json -H "Content-Type: application/json" http://localhost:5000/tickets`

Notice the username and password is the default, so you will need to change that to your choice of username and password you used before you ran `docker-compose up`

If you wish to persist containers, then you can build a mongo db, and use the Dockerfile to build the application container and use that directly.

## Using the API
You can refer to the [API Blueprint](../../../tutorials/design/design_api/ticketService.apib) to learn more about the *tickets* api that this service supports.  By default, the URL of the service is `http://<your host>:5000/tickets`

## Supportability
This microservice is provided for traning/sample only.  There is no support offered explicitly or implied for this service or any associated technologies.
