# GitHub Code Repository

## Introduction

For this workshop we will use GitHub as a central code repository and version control system.

Navigate to [https://github.com](https://github.com/) and create an account.

Fork [vltabacaru/orcl-ws-cicd](https://github.com/vltabacaru/orcl-ws-cicd) project in your account. It creates a copy of this repository in your account [Your Username]/orcl-ws-cicd. In your repository, click on **Clone or download**, and copy the URL in your notes text file. It looks like https://github.com/[Your Username]/orcl-ws-cicd.git.

## **Step 1:** Remote Desktop vs. Command Line

Get the Public IP address of the Compute Instance from Oracle Cloud console, and save it in your notes text file.

Use id_rsa Private Key to connect to this Compute Public IP address. This is the development machine, and it will be used for the duration of this workshop.

This is the SSH connection command for Mac/Linux. As may notice, the SSH command creates a port forwarding tunnel on port 3389. 

ssh -C -i id_rsa -L 3389:localhost:3389 opc@[Compute Public IP]

On Windows machines, run Putty, and make sure you include the same port forward for 3389.

As **opc** user, create a script using vim editor.

````
vi xRDP_config.sh
````

Press **i** and paste the following lines:

````
#!/bin/bash

yum -y groupinstall "Server with GUI"

yum -y install xrdp tigervnc-server terminus-fonts terminus-fonts-console cabextract

yum -y localinstall https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

sed -i 's/max_bpp=24/max_bpp=128\nuse_compression=yes/g' /etc/xrdp/xrdp.ini

systemctl enable xrdp

firewall-cmd --permanent --add-port=3389/tcp

firewall-cmd --reload

chcon --type=bin_t /usr/sbin/xrdp
chcon --type=bin_t /usr/sbin/xrdp-sesman

systemctl start xrdp

echo -e "WelcomePTS#2019\nWelcomePTS#2019" | passwd oracle
````

Press **Esc**, **:wq Enter**, to save and close the file.

Run the following commands:

````
chmod a+x xRDP_config.sh
````

````
sudo ./xRDP_config.sh
````

When completed, this script installs and configures Remote Desktop on your Compute Instance for user **oracle** with password **WelcomePTS#2019**.

## **Step 2:** OCI CLI and Kubectl

**OCI CLI** is already installed on our development Compute Instance, we can check the version.

````
oci -v
2.6.11
````

It can be upgraded.

````
sudo pip3.6 install oci-cli --upgrade
````

Add Kubernetes yum repository to your list using the following command (copy and paste the entire block in the terminal).

````
sudo bash -c 'cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF'
````

Install **Kubectl** with the following command.

````
sudo yum install -y kubectl
````

Now OCI CLI and Kubectl are installed.

## **Step 3:** Git Client

GitHub uses Git version control systems (VCS) to handle the collaboration workflow. This allows developers to create a local copy of the project, makes changes, and merge them back into the central repository.

Check the Git client version.

````
git --version
git version 1.8.3.1
````

This Git is old, we need to update to a newer version (e.g. 2.26.0).

````
sudo yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker
````

````
sudo yum -y remove git
````

````
cd /usr/src
sudo wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.26.0.tar.gz
sudo tar xzf git-2.26.0.tar.gz 
````

````
cd git-2.26.0
sudo make prefix=/usr/local/git all
sudo make prefix=/usr/local/git install
sudo bash -c 'echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc'
sudo bash -c 'source /etc/bashrc'
````

````
cd ~
````

>**Important Note** : All exercises for this workshop have to be executed as **oracle** user.

You have two options, use the command line and **vim** editor, or use the Remote Desktop connection and **gedit** editor. 

1. If you know vim, please change all *gedit* commands with *vi*, and login as oracle user in the command line: 

````
sudo su - oracle
````

2. If you use the Remote Desktop, open a session to **localhost**, user **oracle** with password **WelcomePTS#2019**. Right-click and open a Terminal window.

Check the Git version.

````
git --version
git version 2.26.0
````

Config Git to save credentials for 8 hours.

````
git config --global credential.helper 'cache --timeout 28800'
````

## **Step 4:** Start Application Development

Make a local clone on the development machine of the GitHub repository you forked.

````
git clone https://github.com/[Your Username]/orcl-ws-cicd.git
````

````
cd orcl-ws-cicd

chmod 600 keys/*
````
This repository contains only three files, a readme, and two template files we will use for the deployment of our web service application.

````
ls
keys  kubernetes_deployment.yml.template  kubernetes_service.yml.template  README.md
````

Create Python virtual environment.

````
python3 -m venv orclvenv
````

Activate Python virtual environment.

````
. orclvenv/bin/activate
````

Create a new file called **promotion.py** 

````
gedit promotion.py
````

Write the following code:

````
"""
Simple Python application to show CI/CD capabilities.
"""

def addition(salary, amount):
    return salary + amount

def increment(salary, percentage):
    return salary * (1 + percentage/100)
````

Commit changes to central repository.

````
git add promotion.py
git commit -m "First two functions to calculate salary"
git push
````

If all is good, you should see promotion.py file in your forked repository at https://github.com/[Your Username]/orcl-ws-cicd. Refresh the page, and click on the file to see the contents.

## **Step 5:** Implement Automated Testing

For automated testing, we will use three Python tools:

1. flake8 (called linter) - used to check if the code conforms to the Python coding standards, and analyze code for potential errors;
2. pytest - a standard Python unit testing library designed to check a single unit of code (in our case a function);
3. pytest-cov - extension of pytest, that calculates the percentage of source code that is covered by unit tests.

We install these tools in our Python virtual environment.

````
pip install flake8 pytest pytest-cov
````

These packages will be required by other developers, so we need to share them on the central repository. Capture installed packages in a file requirements.pip.

````
pip freeze > requirements.pip
git add requirements.pip
git commit -a -m "Add requirements list"
git push
````

Run flake8 to analyze your code.

````
flake8 --exclude=orclvenv* --statistics
./promotion.py:5:1: E302 expected 2 blank lines, found 1
./promotion.py:8:1: E302 expected 2 blank lines, found 1
./promotion.py:10:1: W391 blank line at end of file
2     E302 expected 2 blank lines, found 1
1     W391 blank line at end of file
````

The response gives a list of issues that do not comply with Python programming standards, specifying the file name and line number of the occurrence. Python standards require two blank lines before a function definition, and no blank lines at the end of the file. Go ahead, fix the code, and test it again.

````
git commit -a -m "Automated test results fixed"
git push
````

Let's write unit tests for our code. Create a new file **test_promotion.py** with the following code:

````
"""
Unit tests for simple Python application
"""

import promotion


class TestPromotion:

    def test_addition(self):
        assert 1200 == promotion.addition(1150, 50)

    def test_increment(self):
        assert 1250 == promotion.increment(1000, 25)
````

Run pytest-cov to verify how much of your code is covered by unit tests, by using --cov flag with pytest. Pytest knows our file with the prefix test contains unit tests for our application. Same rules apply for class and method names inside the file.

````
pytest -v --cov=promotion

... 
collected 2 items  
 
test_promotion.py::TestPromotion::test_addition PASSED                [ 50%]
test_promotion.py::TestPromotion::test_increment PASSED               [100%]
...
Name           Stmts   Miss  Cover
----------------------------------
promotion.py       4      0   100%
````

In the response we can see our code is covered 100% by unit tests, this is the ideal development situation. Now we can commit the unit tests and push all code to the master branch.

````
git add test_promotion.py
git commit -a -m "Add automatic testing"
git push
````

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, Principal Product Manager, DB Product Management, May 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

