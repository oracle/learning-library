# Oracle Graph 

## Introduction

This lab walks you through the steps of setting up the environment for property graph. Below are the prerequisites:

-	The Oracle Graph Server and Graph Client must be installed.
-	max\_string\_size must be enabled.
-	AL16UTF16 (instead of UTF8) must be specified as the NLS\_NCHAR\_CHARACTERSET.
-	AL32UTF8 (UTF8) should be the default character set,  but  AL16UTF16 must be the NLS\_NCHAR\_CHARACTERSET.

## Before You Begin

**What Do You Need?**

This lab assumes you have completed the following labs:
- Lab 1:  Login to Oracle Cloud
- Lab 2:  Generate SSH Key
- Lab 3:  Create Compute instance 
- Lab 4:  Environment setup

#### Oracle Graph Server and Client

It is a software package for use with the Property Graph feature of Oracle Database. Oracle Graph Server and Client includes the high speed in-memory analytics server (PGX) and client libraries required for graph applications.

Oracle Graph Client: A zip file containing Oracle Graph Client.

Oracle Graph Server: An rpm file containing an easy to deploy Oracle Graph Server.

**For installing the Graph server, the prerequisites are:**
-	Oracle Linux 6 or 7 x64 or a similar Linux distribution such as RedHat
-	Oracle JDK 8
  
**For installing the Graph client, the prerequisites are:**
-	A Unix-based operation system (such as Linux) or macOS or Microsoft Windows
-	Oracle JDK 11


**Note:** Graph client and Sever installation is completed and the setup is ready for use.

#### Interactive Graph Shell

Both the Oracle Graph server and client packages contain an interactive command-line application for interacting with all the Java APIs of the product, locally or on remote computers.

This interactive graph shell dynamically interprets command-line inputs from the user, executes them by invoking the underlying functionality, and can print results or process them further.

This graph shell is implemented on top of the Java Shell tool (JShell).

The graph shell automatically connects to a PGX instance (either remote or embedded depending on the --base_url command-line option) and creates a PGX session.

### About Oracle Graph ##

Oracle’s converged, multi-model database natively supports graphs and delivers high performance, scalable graph data management, query, and analytics for enterprise applications. State-of-the-art graph features are available along with functionality required for enterprise grade applications: fine-grained security, high availability, easy manageability, and integration with other data in an application.


Oracle’s mission is to help people see data in new ways, discover insights, and unlock endless possibilities.  Graph analysis is about understanding relationships and connections in data, and detecting patterns that identify new insights. With Oracle’s Graph offerings developers can use a comprehensive suite of graph query and analytics tools to integrate graphs into applications on enterprise grade data management infrastructure.

**For example,** graph algorithms can identify what individual or item is most connected to others in social networks or business processes.  They can identify communities, anomalies, common patterns, and paths that connect individuals or related transactions.
Every Oracle Database now includes both property graph and RDF graph data models as well as algorithms, query languages, and visualization tools.


**Property Graph database includes:**

- PGX in-memory graph engine
- PGQL graph query language
- 50+ Graph algorithms
- Support for graph visualization 


Customers use Property Graphs in fraud analytics, vulnerability analysis, recommendation systems, and more.

**RDF Graph database includes:**

- SPARQL graph query language
- Java APIs via open source Apache Jena 
- W3C standards support for semantic data, ontologies and inferencing
- RDF Graph views of relational tables

Customers use RDF Graphs in linked data and data sharing applications in pharma, publishing, public sector and more.
This workbook provides an overview of Oracle Graph support for property graph features.


## Introduction to Property Graph

**What Are Property Graphs?** 

A property graph consists of a set of objects or vertices, and a set of arrows or edges connecting the objects. Vertices and edges can have multiple properties, which are represented as key-value pairs.

**Each vertex has a unique identifier and can have:**

- A set of outgoing edges
- A set of incoming edges
- A collection of properties

**Each edge has a unique identifier and can have:**

- An outgoing vertex
- An incoming vertex
- A text label that describes the relationship between the two vertices
- A collection of properties


The following figure illustrates a very simple property graph with two vertices and one edge. The two vertices have identifiers 1 and 2. Both vertices have properties name and age. The edge is from the outgoing vertex 1 to the incoming vertex 2. The edge has a text label knows and a property type identifying the type of relationship between vertices 1 and 2.

![](./images/IMGG1.PNG) 

Figure: Simple Property Graph Example


**A very brief note on PGQL**

The [pgql-lang.org](pgql-lang.org) site and specification [pgql-land.org/spec/1.2](pgql-land.org/spec/1.2) are the best reference for details and examples. For the purposes of this lab, however, here are minimal basics. 

The general structure of a PGQL query is

SELECT (select list) FROM (graph name) MATCH (graph pattern) WHERE (condition)


PGQL provides a specific construct known as the MATCH clause for matching graph patterns. A graph pattern matches vertices and edges that satisfy the given conditions and constraints. 
() indicates a vertex variable

  -an undirected edge, as in (source)-(dest)

-> an outgoing edge from source to destination

<- an incoming edge from destination to source

[]  indicates an edge variable


## Oracle Graph Video

[](youtube:-DYVgYJPbQA)
[](youtube:zfefKdNfAY4)

## Want to learn more
- [Oracle Graph](https://docs.oracle.com/en/database/oracle/oracle-database/19/spatl/index.html)
- [GeoRaster Developer's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/geors/index.html)


## **Step 1:**Connect to Graph Server 

For connecting to graph server, open a terminal in VNC and execute below steps as oracle user.

 ````
<copy>
   cd /opt/oracle/graph/pgx/bin 
</copy>
````

## **Step 2:** Start Graph server
````
<copy>
./start-server
</copy>
````
![](./images/g1.png) 

![](./images/g2.png) 

The PGX server is now ready to accept requests.
Now that the server is started, will keep this window open and will proceed to start the client now.

## **Step 3:**Connect to Graph Client

The Graph Shell uses JShell, which means the shell needs to run on Java 11 or later. In our case the installation is completed, the shell executables can be found in /u01/graph/oracle-graph-client-20.1.0/bin after server installation or <\INSTALL\_DIR>/bin after client installation.

For connecting to graph client, open a putty session and execute below commands as oracle user.

````
<copy>
export JAVA_HOME=/u01/graph/jdk-11.0.5/
cd /u01/graph/oracle-graph-client-20.1.0/bin
</copy>
````

The graph shell automatically connects to a PGX instance (either remote or embedded depending on the --base_url command-line option) and creates a PGX session.

To launch the shell in remote mode, specify the base URL of the server with the --base_url option. For example:

````
<copy>
[oracle@bigdata bin]$ ./opg-rdbms-jshell --base_url http://machine-IP-address:7007
</copy>
````
Below screenshot is an example how Connection to a PGX server using Jshell looks like

![](./images/IMGG4.PNG) 


## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K.
- **Team** - North America Database Specialists.
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2020
- **Expiration Date** - June 2021   

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
  