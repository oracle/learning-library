# Identity Cloud Service

Oracle Identity Cloud Service (IDCS) is an Identity-as-a-Service (IDaaS) solution available in Oracle Public Cloud (OPC). It is designed to extend enterprise controls by automating PaaS and SaaS account provisioning and de-provisioning, simplifying the user experience for accessing cloud applications by providing seamless integration with enterprise identity stores and authentication services, and facilitating compliance activities by clearly reporting on cloud application usage.

IDCS is built on a microservices, multitenant architecture involving small services running on their own processes and exposing RESTful service endpoints. Microservices can scale independently based on their role in the overall component. Because microservices are restricted to specific functionality, they are easier to understand, integrate and maintain.

## Oracle Identity Cloud Service Software Development Kit
Oracle Identity Cloud Service provides a Software Development Kit (SDK) that you download from the console, and can be used to integrate **Node.js** web applications with Oracle Identity Cloud Service.

The Node.js SDK is available as a passport strategy, called **passport-idcs**, and must be added to the Node.js web application source code's **/node_modules** folder.

Let's review some concepts first.

* **Node.js**: Node.js is a platform built on Chrome's JavaScript runtime for easily building fast and scalable network applications.

* **SDK**: A software development kit (SDK) is a collection of software development tools in one installable package.

* **Passport**: Passport is authentication middleware for Node.js. Extremely flexible and modular, Passport can be unobtrusively dropped in to any Express-based web application.


**What Do You Need?**
* A basic knowledge of Node.js framework and JavaScript programming language to understand the code logic presented in this tutorial.
* To download the Node.js sample web application as a zip file, and extract its content to a temp folder.
* Access to an instance of Oracle Identity Cloud Service, and rights to download the SDK from the console and to add a confidential application.
