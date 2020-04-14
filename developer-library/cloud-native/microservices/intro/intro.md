# Gigi's Pizza Hands on Labs Overview #

## Gigi's Pizza Microservices Hands on Labs Introduction ##

Gigi's pizza Hands On Labs are a serie of labs based on a Demo developed by WeDo Team as part of an innovation initiative to approach Oracle Cloud Solutions by providing practical examples that could be “touched” and easily understood.

Demo is known as Gigi’s Pizza. The Use Case is focused in microservices/serverless (fn) and Multitenant DataBase. We have three microservices coded in different languages like nodejs and of course Java (Helidon framework). This three microservices are part of a delivery pizza app, one microservice controls the orders, other one controls the pizza delivery and the last one controls the accounting. We coded a serverless function to calculate discounts, according to several bussiness rules like credit card type or pizza order total prize.

1. Order data will be saved as JSON files in multitenant DB (nodejs microservice)
2. Delivery data will be accessed as graph node DB (nodejs microservice and mobile app)
3. Accounting data will be saved as regular SQL data (Java -Helidon- microservice)

We have coded the front-end part of Gigi's pizza app with Visual Builder Cloud Service, that is the Oracle WYSIWYG - What You See Is What You Get - Service. We have three front-end webapps:

1. Orders front-end. It's a list of orders to the cookers (only PIZZA ORDER and PIZZA COOKED status are visualized)
2. Payment front-end. It's the accounting part of the demo and a dashboard to the manager of the gigi's pizza store.
3. Stream front-end. It visualize the pizza status messages (We use Oracle Cloud Streams).

Finally we have tied a chatbot(Skill) with the microservice-order as a front-end to order the pizzas. And a mobile application for the delivery employees. This mobile app gets the PIZZA OUT FOR DELIVERY status orders and calculates the best route from the Gigi's pizza store to the customer address using Oracle Spatial PDB as location gps points/nodes database.

![](./images/gigis-architect01.png)

## Gigi's Pizza Serverless Hands on Labs Introduction ##

At you can see in the architecture, there is a little serverless function to calculate discounts. It is based in a simple bussiness rule and it was coded in java with fn project, that is an open source serverless project from Oracle (Oracle FaaS is based in fn project).

To improve this serverless function, we created a more complex serverless app to create dicount campaigns. This is the new serverless architecture that improves the first version.

![](./images/gigis-architect02.png)

In that architecture we introduced an Autonomous Database (ATP) to store the discount campaigns, we used an Object Storage to store discount campaings in json format and we used cloud events to upload the discount campaigns in json format to the ATP database.

Once we improve the serverless part of Gigi's pizza, we created an API-Gateway to connect the serverless part with the microservices part. In the first version we did that in a direct "mode" connecting the microservice orchestrator directly to the serverless discount function. After creating the discount campaign app, we had to connect the microservice orchestrator in a better way to the serverless app.

## Gigi's Pizza API-Gateway Hands on Labs Introduction ##

We created an API-Gateway that exposes the serverless function https calls to the world and we use that api call to connect microservice orchestrator to the discount campaing serverless function.

![](./images/gigis-architect-HOL1-2-API.png)

You'll can create your own Gigi's pizza project following the three Hand On Labs that we have created in this github repository.

## Acknowledgements ##

- **Authors/Contributors** - Iván Sampedro Cloud Architect - Presales Tech, Carlos Olivares - Senior Manager Cloud Native
- **Last Updated By/Date** - Iván Sampedro, March 2020
- **Workshop Expiration Date** - 
