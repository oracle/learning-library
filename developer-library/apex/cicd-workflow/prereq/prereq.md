# Install pre-requisites

## Introduction

In this lab we will get the workflow template and install SQLcl.

SQLcl integrates a version of Liquibase, which is used extensively to track DB schema changes in this workshop.

Estimated Lab Time: 5 minutes

### Objectives

In this lab you will:

- Get the repository template 
- Install SQLcl

## **STEP 1:** Get the template

1. Go to the github repository [https://github.com/oracle-quickstart/oci-apex-workflow-template](https://github.com/oracle-quickstart/oci-apex-workflow-template) and click **Use this Template**

  ![](./images/template.png)

  Enter a repository name of your choice.

2. Clone your new repository on your local computer.

## **STEP 2:** Download and install SQLcl

1. Download SQLcl from [https://www.oracle.com/tools/downloads/sqlcl-downloads.html](https://www.oracle.com/tools/downloads/sqlcl-downloads.html)

2. Place the SQLcl zip file download in the root folder of your cloned repository

3. To setup SQLcl, run:

    ```bash
    <copy>
    ./setup_env.sh
    </copy>
    ```

You may proceed to the next lab.

## Acknowledgements

 - **Author** - Emmanuel Leroy, Vanitha Subramanyam, March 2021
 - **Last Updated By/Date** - Emmanuel Leroy, Vanitha Subramanyam, March 2021

