# Next Steps

## Intro

In this lab series you created a very basic application based on micro services on Oracle Cloud Infrastructure. Of course we only scratched the surface of what is possible.

Here are a few ways to improve the application:

## Learn about X DevAPI

You were using the X DevAPI from Node.js. Besides simple searches, transactions,modifications there is a lot more to the API.

For instance to improve performance you could use the connection pool feature for re-using network connections to MySQL, when a instantiated function is deployed.

You could also do more complex searches or modifications on the data.

Checkout the [X DevAPI Userguide](https://dev.mysql.com/doc/x-devapi-userguide/en/) and [Connector/Node.js Reference](https://dev.mysql.com/doc/dev/connector-nodejs/8.0/).

## Get more out of MySQL Database Service

In this lab series you used Terraform to setup a MySQL instance with default configuration. You can explore MySQL Database Service also from the Web Console
and find different machine types or configuration options.

To prevent from user mistakes and failure you can take backups and restore them.

Read the [MySQL Database Service Documentation](https://docs.cloud.oracle.com/en-us/iaas/mysql-database/index.html) to learn more.

## Learn about automation of OCI setups

In this lab you did a lot of configuration manually in the Web console. That is
a good way to learn and experiment. For many use cases automation however has
benefits. Operations done in the Web Console are also available via API.

Type `oci --help` in the terminal to get a list of services with API. Typing
`oci mysql --help` will give you help for the MySQL Database Service.

For further automation there are client libraries. For instance the
[Oracle Cloud Infrastructure SDK for TypeScript and JavaScript](https://github.com/oracle/oci-typescript-sdk/)
might be of interest to you.

Learning about Terraform and the [OCI Terraform Provider](https://registry.terraform.io/providers/hashicorp/oci/latest/docs) allows you to build large environments in an easy way, as you saw.

## Improve security of your application

The application you built has no authentication. You can use the [Authorization Features](https://docs.cloud.oracle.com/en-us/iaas/Content/APIGateway/Tasks/apigatewayaddingauthzauthn.htm) of API Gateway to limit access.

Also the credentials of our database have been stored in plain configuration. for improved security you can use OCI's [Vault Service](https://docs.cloud.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) to protect the password or handling credentials for accessing data from object store.

For a secure deployment it is also advised not using the admin user (root) for the database, but creating special user accounts with limited permissions.

## And more ...

There is no end. Enjoy your coding!
