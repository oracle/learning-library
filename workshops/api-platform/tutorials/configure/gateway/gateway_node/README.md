# Installing a Gateway Node

> This tutorial is under construction

This tutorial shows you how you can download, install and configure a gateway node.

## Before you begin

### Required
- You have an API Platform environment.  See [environments](../../../environments/README.md) for details on procuring an API Platform environment.
- You have the following credentials
  - Username and password, for user(s) who have the *Gateway Manager* and *Gateway Runtime* Application role.  These are typically separate users as a best practice.
  - client_id and secret for the `APICSAuto_<domain>` application
- You can follow ../../users/entitle_users/README.md if you need to add users to the *Gateway Manager* and the *Gateway Runtime* application role
- You have a machine (Linux or Windows) or IaaS VM which you can use to install the Node

## Preparing your installation
Before you can begin installing and setting up the gateway node, you need to complete the following:
- Download the Gateway Installer.
  - Log into API Platform as a user with the *Gateway Manager* role.
  - Navigate to Gateways and choose the desired gateway, or create a gateway if one does not exist.
  - Select the *Nodes* side-tab and click "Download Gateway Installer"
- Open the Installation Wizard to create your gateway-props.json file
  - Review the settings and provide the required attributes.
    - Some settings will be pre-populated for you based on your instance
    - Some settings you will need to select based on the machine you are installing to such as the installation directory
      - Note: You will have the opportunity to edit and make changes to the file before installation
    - Some settings are optional and you can leave them blank
    - Once you are done, you can copy the syntax for running the installer and download the configuration file.
    - An [example file](./sample_gateway-props.json) is also provided
- Make sure your machine has an Oracle Java Development Kit (JDK) 8 or later installed.  **OpenJDK is not supported**
- Your JAVA_HOME environment should be set to the JDK directory
- Create any needed directory for your gateway installer and unzip the downloaded installer there
- Create the directory you specified as your node installation location if it does not yet exist

## Installing the node
To begin installation, enter the command you copied from the gateway configuration wizard.

The installer will ask you for inputs throughout the process.
Once the gateway has completed the installation and registration, log into API Platform as a user with the *Gateway Manager* role.
  - Navigate to Gateways, your gateway, gateway nodes and look for the node in *Requesting* status.
  - Approve the gateway node.

Your gateway is now ready for use!

## Next Steps
You can [configure the OAuth profile](../oauth/README.md) to create APIs that are protected by OAuth2



