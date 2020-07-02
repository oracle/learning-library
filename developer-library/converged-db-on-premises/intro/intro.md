# Introduction

## eShop ##

eShop, based in New York, was founded by Mr. Vallabh Patel in 2015, a budding entrepreneur from India. With initial investments of $10 million, Patel and his team got a good start. They were making sales at about US$ 4M every quarter and there has been a consistent rise of 13 percent in sales per quarter. The eShop.biz an e-commerce brick and mortar company was expanding beyond New York to various other locations across the United States.

Gary Fairfield, their CTO has been tasked with expanding the necessary IT infrastructure to support the expansion. Gary's team had to assess, validate and align to organization's expansion goals. During this exercise, they also wanted to revisit their go-to market strategy and increase the return on investment.

The current infrastructure had multiple single purpose database environments, dedicated to only do a specific job and this had created a longer development cycle and complex administration activity. Each of these databases had their own set of standard and  individual Proprietary API's . This ended up doing a lot of custom work, writing more code independently using individual Proprietary API's and transaction models. Propagating and transforming all these changes with fragmented data all over the place creates lot more complexity and there is definitely a need to integrate it with a lot of customizations. This Integration job of the IT never ended practically. The necessary features like security, availability, scalability are complex and are SILO in nature. eShop.biz had a consistent challenge in addressing security, availability, scalability due to different technologies . Managing these different technology layers was one of the biggest challenge for eShop.biz. These systems were not scaling up and were consuming a lot of company’s revenue.

Development requirements at eShop.biz changed mid-project due to dynamic business needs, which rendered the original sound choice of single-purpose database, sadly lacking. This left developers with a tough decision. Start from scratch with another single-purpose database to accommodate the new requirements and hoping that no others will surface, or work around the limitations of the original single-purpose database, adding unnecessary complexity to the application code and the maintenance of that code.

![](./images/env_setup_nodejs.PNG " ") 

Gary wanted to address all of these challenges and did a POC with Oracle.  POC results were amazing as Oracle had proposed the **CONVERGED DATABASE** architecture.

This Converged DB approach creates the Data synergy and simplicity . Synergy across features makes the whole better than sum of parts. Oracle Converged Database Supports all Workloads(Traditional, Next Generation), Datatypes(Structured & Un-Structured). Converged DB makes it much simpler to develop apps. Just call the SQL to run ML,GRAPH, Spatial, JSON, Blockchain etc. Oracle converged DB on On-premise or on Oracle Cloud Delivered Union of Best Capabilities for each of data type and Workload. All those bottlenecks (Data Consistency ,Data Security, Availability, Scalability, Cross Site Consistency) of single purpose database were solved in Oracle Converged Database and these capabilities create better and informed decisions by increasing the value of information and reducing the time to business insight.

Since November 2019, The eShop.biz is on oracle platform  and they could not only see the expansion seamless ,but also the user experience, Sales Turnover now (26% per quarter) and ROI show a lot better numbers.

Mr. Vallabh Patel & Mr. Gary Fairfield had themselves proposed to be a reference customer by sharing their architecture and their POC use cases.

![](./images/arc.png " ") 

[](youtube:Sbbw2mcrfiA)


## The Data Driven Application Challenge
Modern data driven applications usher in a more complexity with different data types (Relational, Document, Spatial, Graph) and workloads (Transactions, Analytics, ML,IOT). These require different database algorithms to solve and the two possible data strategies are Single Purpose best of breed database for each data type and workload OR use a converged database for all data types and workloads. 

Once we have a single purpose separate database for spatial, ML, Blockchain, JSON, graph etc. we are actually introducing many variables which inherently increases the complexity.

Single purpose Database would eventually end up doing a lot of custom work, writing more code independently using individual proprietary API's and transaction models. Propagating and transforming all these changes with fragmented data all over the place creates lot more complexity and there is definitely a need to integrate it with a lot of customizations. This Integration is a job that never ends.

The necessary features like security, availability, scalability are just very complex to achieve, as each of them has its own models to be built. Later, to propagate any of the smallest change and integrate its a huge activity. 

Availability, scalability, consistency, End to End security etc. are very limited in their areas by weakest of their databases that are implemented. Combining all of them gives worst of weakness. These systems are JUST NO economies of scale.


## Solving the Challenge
Oracle has been doing decades of innovation meeting the needs of mission critical complex systems by doing automation and this journey is continuing with emerging needs and solving real-world challenges like real-time analytics, scale out architecture, zero down time, and defense on cyberattacks. This automation expands to Infrastructure, database, Automated Data center operations and machine learning. 

Calendar, messaging, clock, and camera functions are now part of Mobile devices. Similarly, key-value, ML, JSON, Transactional, and Sharding are now features of Converged DB. 

[](youtube:9d76-LhgMQs)

The Converged Database architecture approach creates Data synergy and simplicity. Synergy across features makes the whole better than the sum of parts. Oracle Converged Database Supports all Workloads (Traditional, Next Generation) and Datatypes (Structured & Un-Structured )

Converged DB makes it much simpler to develop apps. Just call the SQL to run ML, GRAPH, Spatial, JSON, Blockchain etc.

Oracle converged DB on On-premise or on Oracle Cloud Delivers Union of Best Capabilities for each of data type and Workload. 
All those bottlenecks (Data Consistency, Data Security, Availability, Scalability, Cross Site Consistency) of single purpose database are solved in Oracle Converged Database. 

All of these capabilities create better and informed decisions by increasing the value of information and reducing the time to business insight.

## Before You Begin  
To complete this workshop, you will use a preconfigured Converged Database image available in Oracle's Cloud Marketplace to build your compute instance.  This image comes pre-installed with all the information you need to create your environment. 

The Image OCID is below. Please copy it to a notepad, you will need it for later.

  ````
  <copy>
  ocid1.image.oc1..aaaaaaaaqa2rgmwe7qjvscsagpyyog4j3ihgbt3dlpoz7zfrprx7ffdzbozq
  </copy>
  ````

### Preferred Shell
We recommend you run this workshop using the **Oracle Cloud Shell**.

## Converged Database Workshop Collection

- [Node.js](?lab=node.js-lab-1-intro-setup) - Use Rest API to add products to the eShop Application
- [Json](?lab=json-lab-1-intro-setup) - Store and read JSON documents from the Oracle Database
- [XML](?lab=xml-lab-1-setup)- Manage XML content in the Oracle Database
- [Spatial](?lab=spatial-lab-1-setup) - Work with Spatial Data in the Oracle Database
- [Graph](?lab=graph-lab-1-intro-setup) - Work with Graph Data in the Oracle Database
- [Cross Datatype](?lab=cross-lab-1-intro-usage) - Work with Cross Data Types

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya,         Maniselvan K., Robbie Ruppel
- **Team** - North America Database Specialists
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2021
- **Expiration Date** - June 2021

## Issues?
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.


