## Introduction

In this lab, you learn how to create a REST API backend using Node.js.

## **STEP 1:** Create the Node.js REST API backend

You use Node.js and Express to create the REST API backend. After you install and download Node.js and npm, open a terminal window and create the application as follows:

1. Create the application folder:

```bash
<copy>
mkdir tasks-app && cd tasks-app
</copy>
```

2. Initialize the project:

```
<copy>
npm init -y
</copy>
```

>This command creates a minimal package.json file.

3. Install the dependencies:

```
$ npm install express body-parser oracle-nosqldb --save
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN tasks-app@1.0.0 No description
npm WARN tasks-app@1.0.0 No repository field.

+ body-parser@1.19.0
+ express@4.17.1
+ oracle-nosqldb@5.2.3
added 51 packages from 38 contributors and audited 51 packages in 3.015s
found 0 vulnerabilities
```

Before writing the code, let's look at the endpoints we want to support and how we can use the Oracle NoSQL Database library to interact with the NoSQL table.

The following table shows the list of endpoints we want to implement in the API.

| Endpoint | Method | Description |
| --- | --- | --- |
| / | POST | Creates a new task |
| / | GET | Returns all tasks |
| /:id | GET | Returns a task by ID | 
| /completed | GET | Returns all completed tasks |
| /uncompleted | GET | Returns all uncompleted tasks |
| /:id | DELETE | Deletes a task by ID |


### Create a task

To create a task in the NoSQL table, use the `put` method on the NoSQLClient client. Here's a snippet for creating a task in the table: 

```javascript
<copy>
const result = await client.put("tasks", {
          id: 1,
          title: "My first task",
          description: "This is my first task",
          completed: false,
      });
</copy>
```

The result object contains the response details (capacity consumed) and a property called `success`, which indicates whether the put was successful. Here's an example of the response from the `put` method:

```json
{"consumedCapacity":{"readUnits":0,"readKB":0,"writeUnits":1,"writeKB":1},"success":true,"version":{"type":"Buffer","data":[...]}}
```

### Retrieve tasks

To read data from the table, you can use SQL statements and the `query` method. Here's an example that shows how to get all tasks from the table:

```javascript
<copy>
const result = await client.query(`SELECT * FROM tasks`);
</copy>
```

The `rows` property on the result object contains all results from the query.


### Delete task

To delete a single task from the table, you can use the `delete` method and provide the task's ID. If you want to delete more tasks, you could use `deleteMany` and provide an array of IDs.

Here's an example of deleting a task with its ID set to 1:

```javascript
<copy>
const result = await client.delete("tasks", { id: 1 });
</copy>
```

Like when inserting data, the delete result object contains the success and consumed capacity:

```json
{"consumedCapacity":{"readUnits":2,"readKB":1,"writeUnits":1,"writeKB":1},"success":true}
```
