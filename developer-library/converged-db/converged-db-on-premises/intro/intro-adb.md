# Introduction
There are two contrasting approaches when it comes selecting databases to build your applications on. Do you choose multiple single-purpose databases for each data type and workload, or do you choose a converged database that that supports multiple data types and workloads.

## Today's Challenge
Companies need to create consumer-facing mobile and web apps with the same rapid iteration and flexibility as the internet giants. They also have to provide IT services to multiple departments with the same agility as commercial SaaS providers. Plus, they have to make their existing enterprise systems use data from those new environments and contribute data back to them. However, this is extremely difficult when each application is built on different single-purpose databases, each with different operational, security, and performance profiles.

### **Introducing the Oracle Converged Database**
A converged database is a multi-model, multitenant, multi-workload database (Figure 1). It supports the multiple data types and access methods each development team wants, without unneeded functionality getting in the way. It provides both the consolidation and isolation that dev teams want but don’t want to think about. And it excels in all types of workloads (like OLTP, analytics, and IoT) these teams require. Oracle Database 19c is the world’s first converged database.

![](images/converged-db-1.png " ")

These multi-model capabilities give developers simple API-driven access, model-specific languages, and powerful SQL capabilities. IT is simpler as well, with a common approach to security, upgrades, patching, and maintenance across all applications.

### Objectives
Oracle’s converged database supports JSON, XML, relational, spatial, graph, IoT, text and blockchain data with full joins, transactions, and other critical SQL features enterprises rely on.  In this workshop, you will gain first-hand experience of using data types beyond relational data - JSON, XML, Spatial and Graph all running on Oracle's Autonomous Database.

The workshop uses a hybrid cloud architecture, a web application running in docker on Oracle Compute connected to an ATP instance.  You will setup an ATP instance using terraform, load the data from dmp files, connect your application server and query multiple datatypes in the same database.

- Lab: JSON
- Lab: Spatial
- Lab: SODA
- Lab: XML

You will also use Oracle SQL Developer Web to help execute the programs associated with the lab. 

### Prerequisites

- A Free Trial, LiveLabs or Paid account

Estimated Workshop Time:  2 hours

*Please proceed to the first lab.*

## More Information
Feel free to share this LiveLabs workshop with your colleagues on social media

1. Blogs
      - [What is a converged database?](https://blogs.oracle.com/database/what-is-a-converged-database)
      - [Many single purpose database vs a converged database](https://blogs.oracle.com/database/many-single-purpose-databases-versus-a-converged-database)
      - [The Future is Data-driven](https://blogs.oracle.com/database/data-driven-apps)

## Acknowledgements
- **Authors** - Abhinav Srivastava, Yaisah Granillo, Kay Malcolm, Matthew O'Keefe
- **Workshop Owners** - Balasubramanian Ramamoorthy, Arvind Bhope
- **Contributors** - Laxmi Amarappanavar, Kanika Sharma, Venkata Bandaru, Ashish Kumar, Priya Dhuriya, Maniselvan K., Robbie Ruppel, David Start, Paul Sonderegger, Kamryn Vinson
- **Last Updated By** - Kay Malcolm, January 2021

