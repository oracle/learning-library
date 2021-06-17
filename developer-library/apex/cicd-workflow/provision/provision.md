# Provision the databases and environments

## Introduction

In this lab we will provision the infrastructure and set up various environments.

We'll use the Terraform template from the repository to deploy two Oracle Autonomous Databases, create credential files for four environments (dev, tst, stg and prd) and configure these four environments for APEX development

Estimated Lab Time: 10 minutes.

### Objectives

In this lab you will:

- Provision the databases.
- Configure the environments.

## **STEP 1:** Terraform Setup

1. Navigate to the `terraform` folder:

    ```bash
    <copy>
    cd terraform
    </copy>
    ```

2. Create a `TF_VARS.sh` file:

    ```bash
    <copy>
    cp TF_VARS.tpl TF_VARS.sh
    </copy>
    ```

3. Edit with your favorite editor and populate the following:

    ```bash
    export TF_VAR_user_ocid=ocid1.user.oc1..
    export TF_VAR_fingerprint=dc:6e:1c:d4:76:...
    export TF_VAR_private_key_path=~/.oci/oci_api_key.pem
    export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..
    export TF_VAR_region=us-ashburn-1
    ```

    These values come from your Oracle Cloud Infrastructure (OCI) CLI installation.

4. Create a `terraform.tfvars` file from template:

    ```bash
    <copy>
    cp terraform.tfvars.template terraform.tfvars
    </copy>
    ```

5. Populate the required variables:

    ```
    region="us-ashburn-1"
    compartment_id="ocid1.compartment.oc1.."
    ```

    You can then edit the schema, workspace and user names as desired. We'll use the defaults defined below:

    ```
    databases=[
        {
            "db_name" = "apexdev"
            "display_name" = "APEX_DEV"
            "cpu_core_count" = 1
            "storage_size_in_tbs" = 1
            "db_version" = "19c"
            "db_workload" = "OLTP"
            "is_free_tier" = true
            "license_model" = "LICENSE_INCLUDED"
            "envs" = ["dev", "stg", "tst"]
        },
        {
            "db_name" = "apexprd"
            "display_name" = "APEX_PRD"
            "cpu_core_count" = 2
            "storage_size_in_tbs" = 2
            "db_version" = "19c"
            "db_workload" = "OLTP"
            "is_free_tier" = false
            "license_model" = "LICENSE_INCLUDED"
            "envs" = ["prd"]
        }
    ]

    environments = {
        "dev" = {
            workspace_name = "WS"
            schema_name = "MYAPP"
            workspace_admin = "WS_ADMIN"
            apex_admin_email = "admin@local"
            ws_admin_email = "admin@local"
        },
        # if environments are on the same DB,
        # the schema and workspace need a different name
        "stg" = {
            workspace_name = "WS_STG"
            schema_name = "MYAPP_STG"
            workspace_admin = "WS_ADMIN_STG"
            apex_admin_email = "admin@local"
            ws_admin_email = "admin@local"
        }
        "tst" = {
            workspace_name = "WS_TST"
            schema_name = "MYAPP_TST"
            workspace_admin = "WS_ADMIN_TST"
            apex_admin_email = "admin@local"
            ws_admin_email = "admin@local"
        }
        # on separate database, use the same name for schema and workspace
        "prd" = {        
            workspace_name = "WS"
            schema_name = "MYAPP"
            workspace_admin = "WS_ADMIN"
            apex_admin_email = "admin@local"
            ws_admin_email = "admin@local"
        }
    }
    ```

    This creates two databases, and four environments: dev, tst, and stg are on the APEX\_DEV database and prd is on the APEX\_PRD database.

    Feel free to configure these as you need for your own environment. In this workshop we will use these defaults.

    If you make changes, make sure that SCHEMA, WORKSPACE and WS_ADMIN names are different if setting up multiple environments in the same database as these need to be unique per database.

## **STEP 2:** Provision the Database and Setup the Environments

1. The whole stack and environments can be deployed and configured in one command:

    ```bash
    <copy>
    # go back to the root folder
    cd ..
    # run
    make init
    </copy>
    ```

    Type `yes` at the prompt to confirm applying the terraform stack.

    The terraform stacks generates environment files for each environment. The files are on the root folder, named *`<env_name>.env`* and they contain the credentials for user/schema/workspace for each environment.

    The script sets up all of the environments for you, ready to install a new app.

## **STEP 3:** Using the makefile

1. The makefile in this repository simplifies a lot of the tasks to be performed. Get the full list of commands with:

    ```bash
    <copy>
    make help
    </copy>
    ```

    ```bash
    help                           This help.
    sql                            SQLcl shell as APEX ADMIN user
    sql-schema                     SQLcl shell as SCHEMA user
    wallet                         Get the Database wallet
    clean-wallets                  remove the wallets
    tf-apply                       Run the terraform stack
    tf-destroy                     Destroy the terraform stack
    create-apex-admin              Create the APEX admin user
    delete-apex-admin              Delete the APEX admin user
    create-cloud-creds             Create default cloud credential for the APEX ADMIN user to use datapump to Object Storage
    create-schema                  Create schema
    delete-schema                  Delete schema
    create-ws                      Create schema, workspace, add schema to workspace and create workspace admin user
    delete-ws                      Delete workspace and its users
    export-app                     Export the Apex App. Specify ID=<app_id>
    import-app                     Import the Apex App. Specify ID=<app_id> NEWID=<new_app_id> (defaults to ID)
    changelog                      Generate a new Change Log for the schema
    update-schema                  Apply the Change Log to the schema
    snapshot                       Create a new change Log, and export the app. Specify ID=<app_id>
    update                         Apply the Change Log & import the app. Specify ID=<app_id> NEWID=<new_app_id> (defaults to ID)
    rollback                       Rollback changes. Specify ID=<app_id> NEWID=<new_app_id>
    init                           Deploy the database(s) and setup all the defined environments
    test                           Test (WIP)
    ```

    Many of these functions are sub-function of the main functions described here, giving you more granularity to manipulate specific objects.

    The main commands we will use are:

    - `init`: initiallize the whole environment (`tf-apply` + `wallet` + `create-schema` + `create-ws` applied to each environment)
    - `snapshot ID=\<app_id\>`: to take a snapshot of the state of the application (`changelog` + `export-app`)
    - `update ID=\<app_id\>`: to update the app (`update-schema` + `import-app`)

    The other commands can be used to create additional environments (`create-schema`, `create-ws`) and manually perform specific tasks (`wallet`,`clean-wallets` to get and clean an environment database wallet)

2. With this tool, you can create additional environments, by creating new workspaces and/or schemas.

  *Remember that DB change tracking is per SCHEMA, and application change tracking is per application, so if you decide to create multiple applications in the same schema, make sure the applications are always deployed together otherwise one application schema change may cause issues in the other application.*

  *The preferred way to use multiple applications is to create a schema per application, and then grouping those schemas into a workspace.*



## Acknowledgements

 - **Author** - Emmanuel Leroy, Vanitha Subramanyam, March 2021
 - **Last Updated By/Date** - Emmanuel Leroy, Vanitha Subramanyam, March 2021
