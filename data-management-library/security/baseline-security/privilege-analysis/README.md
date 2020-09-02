![](../../images/banner_PA.PNG)

Privilege analysis increases the security of your applications and database operations by helping you to implement least privilege best practices for database roles and privileges.

Running inside the Oracle Database kernel, privilege analysis helps reduce the attack surface of user, tooling, and application accounts by identifying used and unused privileges to implement the least-privilege model.

![](images/PA_Concept.PNG)

Privilege analysis dynamically captures privileges used by database users and applications. The use of privilege analysis can help to quickly and efficiently enforce least privilege guidelines. In the least-privilege model, users are only given the privileges and access they need to do their jobs. Frequently, even though users perform different tasks, users are all granted the same set of powerful privileges. Without privilege analysis, figuring out the privileges that each user must have can be hard work and in many cases, users could end up with some common set of privileges even though they have different tasks. Even in organizations that manage privileges, users tend to accumulate privileges over time and rarely lose any privileges. Separation of duty breaks a single process into separate tasks for different users. Least privileges enforces the separation so users can only do their required tasks. The enforcement of separation of duty is beneficial for internal control, but it also reduces the risk from malicious users who steal privileged credentials.

Privilege analysis captures privileges used by database users and applications at runtime and writes its findings to data dictionary views that you can query. If your applications include definer’s rights and invoker’s rights procedures, then privilege analysis captures the privileges that are required to compile a procedure and execute it, even if the procedure was compiled before the privilege capture was created and enabled.

You can create different types of privilege analysis policies to achieve specific goals:

- **Role-based privilege use capture**<br>
You must provide a list of roles. If the roles in the list are enabled in the database session, then the used privileges for the session will be captured. You can capture privilege use for the following types of roles: Oracle default roles, user-created roles, Code Based Access Control (CBAC) roles, and secure application roles.

- **Context-based privilege use capture**<br>
You must specify a Boolean expression only with the SYS_CONTEXT function. The used privileges will be captured if the condition evaluates to TRUE. This method can be used to capture privileges and roles used by a database user by specifying the user in SYS_CONTEXT.

- **Role- and context-based privilege use capture**<br>
You must provide both a list of roles that are enabled and a SYS_CONTEXT Boolean expression for the condition. When any of these roles is enabled in a session and the given context condition is satisfied, then privilege analysis starts capturing the privilege use.

- **Database-wide privilege capture**<br>
If you do not specify any type in your privilege analysis policy, then the used privileges in the database will be captured, except those for the user SYS. (This is also referred to as unconditional analysis, because it is turned on without any conditions.)
<br><br>

**Benefits of using Privilege Analysis**

- Finding unnecessarily granted privileges

- Implementing least privilege best practices: the privileges of the account that accesses a database should be limited to the privileges that are strictly required by the application or the user

- Development of Secure Applications: during the application development phase, some administrators may grant many powerful system privileges and roles to application developers

- You can create and use privilege analysis policies in a multitenant environment

- Can be used to capture the privileges that have been exercised on pre-compiled database objects (PL/SQL packages, procedures, functions, views, triggers, and Java classes and data) 


---
![](../../images/banner_Docs.PNG)

- [Oracle Privilege Analysis 20c](https://docs.oracle.com/en/database/oracle/oracle-database/20/dbseg/performing-privilege-analysis-find-privilege-use1.html#GUID-44CB644B-7B59-4B3B-B375-9F9B96F60186)

---
![](../../images/banner_Video.PNG)

&nbsp; Watch Privilege Analysis presentation on OTube (**Internal only**):
- [Second Thursday: Privilege Analysis](https://otube.oracle.com/media/Second+ThursdayA+Privilege+Analysis/1_zalpv2vo) *(January 2019)*

---
![](../../images/banner_Labs.PNG)

Version tested in this lab: `Oracle DB 19.5`

- [Basics: Capture and Report](Simple_PA_Lab/README.md)

---
Click to return [home](/README.md)
