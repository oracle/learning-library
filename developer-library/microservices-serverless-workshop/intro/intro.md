# Microservices/Serverless Workshop (Gigi's Pizza)
## **Introduction**

This Hands-on Lab (HOL) is based on a Demo developed by the WeDo Team as part of an innovation initiative to approach Oracle Cloud Solutions by providing practical examples that can be “touched” and easily understood.

The Demo is called Gigi’s Pizza. The use case is focused on a microservices/serverless (fn) and Multitenant Database. We
have three microservices coded in different languages like Node.js and of course Java (Helidon framework). These three microservices are part of a delivery pizza app: one microservice controls the orders; other one controls the pizza delivery; and the last one controls the accounting. We coded a serverless function to calculate discounts, according to several business rules like credit card type or pizza order total prize.

1.  Order data will be saved as JSON files in multitenant DB (Node.js microservice)
2.  Delivery data will be accessed as graph node DB (Node.js microservice and mobile app)
3.  Accounting data will be saved as regular SQL data (Java -Helidon- microservice)

We have coded the front-end part of Gigi's pizza app using Visual Builder Cloud Service, that is the Oracle WYSIWYG - What You See Is What You Get - Service. We have three front-end webapps:

1.  Orders front-end. It's a list of orders to the cookers (only PIZZA ORDER and PIZZA COOKED status are visualized)
2.  Payment front-end. It's the accounting part of the demo and a dashboard to the manager of the gigi's pizza store.
3.  Stream front-end. It visualize the pizza status messages (We use Oracle Cloud Streams).

Finally we have tied a chatbot(Skill) with the microservice-order as a front-end to order the pizzas. And a mobile application for the delivery employees. This mobile app gets the PIZZA OUT FOR DELIVERY status orders and calculates the best route from the Gigi's pizza store to the customer address using Oracle Spatial PDB as location gps points/nodes database.

![](./images/gigis-architect01.png " ")

### Let's Get Started!

Click on [Sign Up For a Free Trial](?lab=sign-up-for-free-trial) to get your Oracle Free Trial. If you already have an Oracle Free Trial or Paid account, you can proceed to [Lab 1: Provision a DevCS Instance](?lab=lab-1-provision-devcs-instance).

## Acknowledgements
* **Authors** -  Iván Postigo, Jesus Guerra, Carlos Olivares - Oracle Spain SE Team
* **Contributors** - Jaden McElvey, Technical Intern Lead - Oracle LiveLabs 
* **Last Updated By/Date** - Tom McGinn, May 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues). Please include the workshop name and lab in your request.
