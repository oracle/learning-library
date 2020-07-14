![](../../images/banner_DV.PNG)

Oracle Database Vault provides controls to prevent unauthorized privileged users from accessing sensitive data and to prevent unauthorized database changes.
The Oracle Database Vault security controls protect application data from unauthorized access, and comply with privacy and regulatory requirements.

![](images/DV_Concept.PNG)

You can deploy controls to block privileged account access to application data and control sensitive operations inside the database using trusted path authorization. Through the analysis of privileges and roles, you can increase the security of existing applications by using least privilege best practices. Oracle Database Vault secures existing database environments transparently, eliminating costly and time consuming application changes.

Oracle Database Vault enables you to create a set of components to manage security for your database instance.

These components are as follows:

- **Realms:** A realm is a protection zone inside the database where database schemas, objects, and roles can be secured. For example, you can secure a set of schemas, objects, and roles that are related to accounting, sales, or human resources. After you have secured these into a realm, you can use the realm to control the use of system and object privileges to specific accounts or roles. This enables you to provide fine-grained access controls for anyone who wants to use these schemas, objects, and roles.

- **Command rules:** A command rule is a special security policy that you can create to control how users can execute almost any SQL statement, including SELECT, ALTER SYSTEM, database definition language (DDL), and data manipulation language (DML) statements. Command rules must work with rule sets to determine whether the statement is allowed.

- **Factors:** A factor is a named variable or attribute, such as a user location, database IP address, or session user, which Oracle Database Vault can recognize and use as a trusted path. You can use factors in rules to control activities such as authorizing database accounts to connect to the database or the execution of a specific database command to restrict the visibility and manageability of data. Each factor can have one or more identities. An identity is the actual value of a factor. A factor can have several identities depending on the factor retrieval method or its identity mapping logic.

- **Rule sets:** A rule set is a collection of one or more rules that you can associate with a realm authorization, command rule, factor assignment, or secure application role. The rule set evaluates to true or false based on the evaluation of each rule it contains and the evaluation type (All True or Any True). The rule within a rule set is a PL/SQL expression that evaluates to true or false. You can have the same rule in multiple rule sets.

- **Secure application roles:** A secure application role is a special Oracle Database role that can be enabled based on the evaluation of an Oracle Database Vault rule set.

To augment these components, Oracle Database Vault provides a set of PL/SQL interfaces and packages.

In general, the first step you take is to create a realm composed of the database schemas or database objects that you want to secure. You can further secure the realm by creating rules, command rules, factors, identities, rule sets, and secure application roles. In addition, you can run reports on the activities these components monitor and protect.

**Benefits of using Database Vault**

- Addresses compliance regulations to security awareness

- Protects privileged user accounts from many security breaches and data steal, both external and internal

- Helps you design flexible security policies for your database

- Addresses Database consolidation and cloud environments concerns to reduce cost and reduce exposure sensitive application data to those without a true need-to-know

- Works in a Multitenant Environment increasing security for consolidation 

---
![](../../images/banner_Labs.PNG)

Version tested in this lab: `Oracle DB 19.5`

For these labs, you can also use **Enterprise Manager**, **Glassfish** or **SQL Developer** to check DB Vault impacts.

- [Getting connected](dir-getting-connected/get-connected.md)

- **Before** Continuing with the remainder of the labs, you must [Enable Database Vault](dir-enable-database-vault/enable-dv.md)

- [How to create a simple realm to protect sensitive data](dir-simple-realm/simple-realm.md)

- [How to configure multi-factor authorization / trusted path](dir-trusted-app-path/trusted-app-path.md)

- [How to use Simulation Mode to test Database Vault controls](dir-simulation-mode/simulation-mode.md)

- [How to use Operations Control to protect pluggable databases](dir-ops-control/ops-control.md)

- When you are finished, you can [disable Database Vault](dir-disable-database-vault/disable-database-vault.md) and run through the labs again to see just how much is possible without effective controls

---

Click to return [home](/README.md)
