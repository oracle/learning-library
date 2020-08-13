# Introduction

## Create an Oracle Database in a Docker Container on Oracle Cloud

Welcome to the Oracle Database Docker Workshop. Using Docker build files for Oracle Database provided on GitHub, you can containerize an application - in this case, an instance of Oracle Database.

### Objectives

- Sign up for an Oracle Free Trial account and sign in to your account
- Create a set of SSH keys
- Create a Virtual Cloud Network (VCN) instance
- Create an Oracle Cloud compute instance
- Set up Docker on the Cloud compute instance
- Build an Oracle Database Docker image
- Start the Oracle Database in a Docker container
- Add an Ingress rule to the VCN
- Connect to the Database in the container
- Manage your Docker container

Each of the labs is 5 -10 minutes in length, so you will be up and running in no time.

*Note 1: You will need a Free Trial or an existing Oracle Cloud account for this workshop (Not all services in this workshop are Always Free services)*

### About Docker

Docker is an open source container designed to separate an application from its host environment. Unlike virtual machines, which encapsulate the application and its operating system, Docker containers have much lighter weight. A Docker engine is required to run a Docker container. Docker engines are available for Windows and Linux platforms, including Oracle Linux. When you build a Docker image, it contains all of the code necessary for the application, including application code, runtime, system tools, libraries, and settings. This means you can create and test an application in one environment - for example, your Windows PC and deploy it to the cloud. In addition, there are pre-built Oracle images available on [Docker Hub](https://hub.docker.com/u/oracle/), so you can start with an existing image quickly.

### **Let's Get Started!**

- Click on **Lab 1** from the menu on the right. If you already have an Oracle Cloud account, click on **[Lab 2: Create SSH Keys](?lab=lab-2-create-ssh-keys)**.

- If the menu is not displayed, you can open by clicking the menu button (![Menu icon](./images/MenuButton.png)) at the top right of the page.

### Learn More

- [Docker](https://www.docker.com/)
- [Oracle Database Documentation](https://docs.oracle.com/en/database/index.html)
- [Oracle Technology Network](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
