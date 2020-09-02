# Weblogic Helidon Lab

## Introduction

Helidon is a collection of Java Libraries for writing Microservices that run on fast webcore powered by Netty.  Helidon also supports MicroProfile and provides familiar APIs like JAX-RS, CDI and JSON P/B. The MicroProfile implementation runs on Helidon Reactive WebServer on top of Netty. Helidon supports health checks, metrics, tracing and fault tolerance.  
Helidon has what you need to write cloud ready applications that integrate with Prometheus, Jaeger/Zipkin and Kubernetes
Helidon supports SDKs and MicroProfile. 

### Lab Prerequisites

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup
   

### About the Weblogic Helidon Lab

This Lab uses a Bank Web Application deployed to Weblogic that can interoperate with a Helidon Microservice for a credit verfication.

The very purpose of writing microservices is do a small piece of job efficiently and re-use it multiple times in different applications. Helidon SE enables us to write one such microservice in this lab.
BestBank, a hypothetical bank has a web application deployed to Weblogic. As part of that application, the bank’s credit division wants to build a simple UI which showcases the details of top 15 customers with their SSN number and IBAN number.  The team wants to have a microservice which provides credit score of the customer as output taking the user details like IBAN/SSN numbers as input.

The IT developers create a CreditScore Microservice in Helidon and consume it in the current UI application listing the top 15 customers.




  
  

 

## Acknowledgements

- **Authors** - Srinivas Pothukuchi, Pradeep Chandramouli, Chethan BR
- **Contributors** - Srinivas Pothukuchi, Pradeep Chandramouli, Chethan BR, Laxmi Amarappanavar
- **Team** - North America SE Specialists.
- **Last Updated By** -  
- **Expiration Date** - 

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
      
 
