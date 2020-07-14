# Oracle Wercker CI Service

## Introduction

There are many tools available for automating CI/CD workflows and pipelines, including hosted solutions such as Cloudbees and Atlassian Bamboo (CI services), and on-premise software such as Jenkins and Teamcity (CI servers).

>**Note** : Workflow/pipeline model requires an Agile methodology where you always have a working release/version of your software product in production, and only apply small changes to it that can be individually tested and deployed.

Wercker is the CI service we will use in this workshop. Wercker empowers organizations and their development teams to achieve continuous integration and continuous delivery (CI/CD) goals with micro-services and Docker. We will create on Wercker an Application having one Workflow with two Pipelines.

Open [https://app.wercker.com](https://app.wercker.com) and login with your GitHub account. 

## Step 1: Add Application

Click the **+** sign next to profile icon 👤 on upper right corner, and **Add Application**.

- Select SCM: GutHub
- Select Repository: [Your Username]/orcl-ws-cicd
- Setup SSH key: wercker will check out the code without using an SSH key

Create.

Wercker uses a **wercker.yml** file to define the Steps required to execute automation tasks for your application, along with the Pipelines that group them. 

## Step 2: Create Wercker.YML

Create a wercker.yml file.

````
gedit wercker.yml
````

Add the following lines to your wercker.yml file:

````
build:
    box: python:3.7
    steps:

    # Step 1: create virtual enviroment and install dependencies
    - script:
        name: install dependencies
        code: |
            python3 -m venv orclvenv
            . orclvenv/bin/activate
            pip install -r requirements.pip
    # Step 2: run linter and tests
    - script:
        name: run tests
        code: |
            . orclvenv/bin/activate
            flake8 --exclude=orclvenv* --statistics
            pytest -v --cov=promotion
````

This wercker.yml defines a build pipeline that executes two steps: first creates the virtual environment with required dependencies, and second runs the automated tests.

This build is done on a [Docker](https://hub.docker.com/) box called [python](https://hub.docker.com/_/python), which is the official image for this programming language. We are using the simple tag 3.7 to specify the exact configuration. This image uses **Debian GNU/Linux 10 (buster)** OS, this is important to know when you need to customize the box, as we will do later in this lab.

Commit and push wercker.yml to the master branch.

````
git add wercker.yml
git commit -a -m "Add wercker.yml build pipeline"
git push
````

Wercker automates the buid, and as soon as we commit our changes to the central repository, Wercker runs the pipeline automatically. 

You can review the build on Wercker console under [Your Username]/orcl-ws-cicd > **Runs**. Click on the **build** pipeline to see all the steps. Click on **run tests** step to see the execution details. You should see the same results as when the pytest tool was executed locally on the development machine.

## Step 3: Enhance Application Code

Next step is to add a new feature to the application. We will first add a unit test without writing the function. Writing a failing test first and then adding the code to pass the test is called Test Driven Development (TDD). Add the following code to the end of **test_promotion.py**:

````

    def test_decrease(self):
        assert 970 == promotion.decrease(1150, 180)
````

As soon as we commit and push these changes to the code repository, a new build is triggered by Wercker.

````
git commit -a -m "Add unit test for new feature"
git push
````

Review the build results on Wercker console. Step **run tests** fails with this error:

````
...
E       AttributeError: module 'promotion' has no attribute 'decrease'
...
````

This shows that continuous integration works, and makes our application development safe, by automatically testing the code.

Add the missing function in file **promotion.py**. Remember to leave two blank rows before function definition, and no blank rows at the end of the file.

````


def decrease(salary, amount):
    return salary - amount
````

Commit and push the changes.

````
git commit -a -m "Add new feature"
git push
````

Review the build results on Wercker console. If you followed this guide, the build is successful.

## Step 4: Create Web Service

We want our application to be used as a web service, available online. For this purpose we will use [Bottle](https://bottlepy.org), a Web Server Gateway Interface (WSGI) micro web-framework for the Python programming language. It is designed to be fast, simple and lightweight, and is distributed as a single file module with no dependencies other than the Python Standard Library. 

Install Bottle, and update the requirements list.

````
pip install -U bottle
pip freeze > requirements.pip
````

Update promotion.py file and make sure it looks like the following code:


````
"""
Simple Python application to show CI/CD capabilities.
"""

from bottle import Bottle, run

app = Bottle()


@app.route('/addition/<salary>/<amount>')
def addition(salary, amount):
    return salary + amount


@app.route('/increment/<salary>/<percentage>')
def increment(salary, percentage):
    return salary * (1 + percentage/100)


@app.route('/decrease/<salary>/<amount>')
def decrease(salary, amount):
    return salary - amount


if __name__ == '__main__':
    run(app, host='0.0.0.0', port=8080)
````

The first two lines we added import Bottle library and define our application. On top of every function we have, we added a routing, a function call based on a URL. Every routing may have parameters, or not. Our routings have two parameters. At the end of the file we added a '\_\_main__' section, is the name of the scope in which top-level code executes. This is where we run the web service application server, a built-in HTTP development server that comes with Bottle.

Commit and push the changes to the master branch.

````
git commit -a -m "Convert application to web service"
git push
````

View the continuous integration pipeline executing the automated build on Wercker console. It succeeds. However, the coverage has dropped to 90%, because we don't test the code we added to convert it to a web service.

````
----------- coverage: platform linux, python 3.7.7-final-0 -----------
Name           Stmts   Miss  Cover
----------------------------------
promotion.py      10      1    90%
````

We can test a web application using pytest by checking the content of the response body, the status (has to be "200 OK" for success), or the status code (has to be 200 for success). For these tests we need [WebTest](https://pypi.org/project/WebTest/), a library for testing WSGI-based web applications

````
pip install -U webtest
pip freeze > requirements.pip
````

Now we can add some unit tests for the web service in test_promotion.py. This is the result:

````
"""
Unit tests for simple Python application
"""

import promotion
import pytest
from webtest import TestApp


class TestPromotion:

    def test_addition(self):
        assert 1200 == promotion.addition(1150, 50)

    def test_increment(self):
        assert 1250 == promotion.increment(1000, 25)

    def test_decrease(self):
        assert 970 == promotion.decrease(1150, 180)


@pytest.fixture
def application():
    test_app = TestApp(promotion.app)
    return test_app


def test_response_shold_be_ok(application):
    response = application.get('/addition/1000/200')
    assert response.status == "200 OK"


def test_addition(application):
    response = application.get('/addition/1000/200')
    assert b'1200' == response.body
````

Commit and push the changes to the master branch on code repository.

````
git commit -a -m "Add unit tests for web service"
git push
````

The build fails with the following error:

````
...
test_promotion.py::test_addition FAILED
...
        response = application.get('/addition/1000/200')
>       assert b'1200' == response.body
E       AssertionError: assert b'1200' == b'1000200'
...
````

Our web service application addition feature returns 1000200 instead of 1200 when it performs 1000 + 200 operation. As you already have guessed, this happens because it uses string operands and not integers. We need to add some code to our application for the correct conversion.

Modify the code and add the data type conversions:

````
@app.route('/addition/<salary>/<amount>')
def addition(salary, amount):
    return str(int(salary) + int(amount))


@app.route('/increment/<salary>/<percentage>')
def increment(salary, percentage):
    return str(int(salary) * (1 + int(percentage)/100))


@app.route('/decrease/<salary>/<amount>')
def decrease(salary, amount):
    return str(int(salary) - int(amount))
````

````
git commit -a -m "Add data type conversions"
git push
````

Now it fails again, with the error:

````
E       AssertionError: assert 1200 == '1200'
````

Our web application returns string values now. In Python, when you compare an integer with a string, they don't match. We need to fix the unit tests in test_promotion.py.

````
    def test_addition(self):
        assert '1200' == promotion.addition(1150, 50)

    def test_increment(self):
        assert '1250.0' == promotion.increment(1000, 25)

    def test_decrease(self):
        assert '970' == promotion.decrease(1150, 180)
````

````
git commit -a -m "Fix unit tests with correct data types"
git push
````

Verify this build is successful. We are still not covering all functions with a unit test, but this is fine for now, you get the idea.

## Step 5: Test Web Application Locally

We can test the web service Python application locally on the development machine. In order to use the browser from our computer, we need another port forwarding tunnel added to our SSH connection. This requires to close our current connection, and reconnect.

Now we are working in a Python virtual environment called **orclvenv**. To exit it, run:

````
deactivate
````

To close our session on the development machine as **oracle** user, type:

````
exit
````

And finally, close our session on the development machine as **opc** user:

````
exit
````

Reconnect to the development machine. This is the SSH connection command for Mac/Linux. It creates three port forwarding tunnels on port 3389, 8080, and 8001. Port 8080 is used to test the Python web service, and port 8001 will be used later in the workshop for Kubernetes Dashboard. 

````
ssh -C -i id_rsa -L 3389:localhost:3389 -L 8080:localhost:8080 -L 8001:localhost:8001 opc@[Compute Public IP]
````

>**Important Note** : Our project is developed in a Python virtual environment **orclvenv**, as **oracle** user, in folder **/home/oracle/orcl-ws-cicd**. Every time you connect to the development machine, you need to run these commands so you can continue working on this application.

````
sudo su - oracle
cd ~/orcl-ws-cicd
. ./orclvenv/bin/activate
````

Your Linux terminal should look like this:

````
(orclvenv) [oracle@[Your Initials]-vm orcl-ws-cicd]$ ls
kubernetes_deployment.yml.template  orclvenv      __pycache__  requirements.pip   wercker.yml
kubernetes_service.yml.template     promotion.py  README.md    test_promotion.py
````

Now we can test the web service.

````
python3 promotion.py 
Bottle v0.12.18 server starting up (using WSGIRefServer())...
Listening on http://0.0.0.0:8080/
Hit Ctrl-C to quit.
````

Use the web browser on your laptop to open [http://localhost:8080/addition/1000/200](http://localhost:8080/addition/1000/200). The response is '1200'. Congratulations! Your Python web micro service application is running. Press Ctrl-C to stop the application.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, Principal Product Manager, DB Product Management, May 2020

See an issue? Please open up a request [here](https://github.com/oracle/learning-library/issues). Please include the workshop name and lab in your request.

