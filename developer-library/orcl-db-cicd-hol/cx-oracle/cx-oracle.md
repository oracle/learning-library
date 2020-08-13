# Oracle Database for Python

## Introduction

Our application data in stored in an Oracle Database, that runs as a Database Cloud Service on a OCI Database System, and uses Multitenant Architecture (it's a Pluggable Database).

We want our Python web micro service to connect to our Oracle Database, retrieve information about the employees in Human Resources (HR) sample schema, and calculate a promotion or a salary increase.

## **Step 1:** Get Database Host and Service

Connect to the DB System you created on OCI, called [Your Initials]-DB. 

````
ssh -C -i ~/orcl-ws-cicd/keys/id_rsa opc@[DB System Public IP]
sudo su - oracle
````

Check the status of the listener. 

````
lsnrctl status
````
Save in your notes text file the complete name of the pluggable database service, it has this format (all small caps) - we will call it [PDB_service_name]:

````
pdb01.sub[Number].[Your Initials]vcn.oraclevcn.com
````

The complete name of the host server has the same format (all small caps) - we will call it [DB_system_host]:

````
[Your Initials]-host.sub[Number].[Your Initials]vcn.oraclevcn.com
````

## **Step 2:** Prepare Sample Schema and Data

Connect to the pluggable database and verify HR schema is available.

````
sqlplus sys/WelCom3#2020_@//[DB_system_host]/[PDB_service_name] as sysdba

select username from all_users where username = 'HR';

no rows selected
````

We need to install HR sample schema. Use the values from this example:

````
SQL> @?/demo/schema/human_resources/hr_main.sql

specify password for HR as parameter 1:
Enter value for 1: WelCom3#2020_

specify default tablespeace for HR as parameter 2:
Enter value for 2: USERS

specify temporary tablespace for HR as parameter 3:
Enter value for 3: TEMP

specify log path as parameter 4:
Enter value for 4: $ORACLE_HOME/demo/schema/log/
````

Test HR schema.

````
SQL> conn hr/WelCom3#2020_@//[DB_system_host]/[PDB_service_name]
Connected.
SQL> select table_name from user_tables;

TABLE_NAME
--------------------------------------------------------------------------------
REGIONS
COUNTRIES
LOCATIONS
DEPARTMENTS
JOBS
EMPLOYEES
JOB_HISTORY

7 rows selected.
````

## **Step 3:** Connect to Oracle Database from Python

Back on our development environment, let's connect our Python microservice to our Oracle Database. This enhancement requires [cx_Oracle](https://oracle.github.io/python-cx_Oracle/) extension module.

````
pip install cx_Oracle
pip freeze > requirements.pip
````

Edit promotion.py, and add a new line to import cx_Oracle extension module.

````
import cx_Oracle
````

Add a new function with routing to test the database connection.

````
@app.route('/conn')
def conn():
    return str(connection.version)
````

Finally, add the connection code to the '\_\_main__' section.

````
    DBUSER = 'hr'
    DBPASS = 'WelCom3#2020_'
    DBHOST = '[Your Initials]-host.sub[Number].[Your Initials]vcn.oraclevcn.com'
    DBSERV = 'pdb01.sub[Number].[Your Initials]vcn.oraclevcn.com'
    conn_string = DBUSER + '/' + DBPASS + '@//' + DBHOST + '/' + DBSERV
    connection = cx_Oracle.connect(conn_string)
    run(app, host='0.0.0.0', port=8080)
    connection.close()
````

Just a quick check, your promotion.py should look like this:

````
"""
Simple Python application to show CI/CD capabilities.
"""

from bottle import Bottle, run
import cx_Oracle

app = Bottle()


@app.route('/addition/<salary>/<amount>')
def addition(salary, amount):
    return str(int(salary) + int(amount))


@app.route('/increment/<salary>/<percentage>')
def increment(salary, percentage):
    return str(int(salary) * (1 + int(percentage)/100))


@app.route('/decrease/<salary>/<amount>')
def decrease(salary, amount):
    return str(int(salary) - int(amount))


@app.route('/conn')
def conn():
    return str(connection.version)


if __name__ == '__main__':
    DBUSER = 'hr'
    DBPASS = 'WelCom3#2020_' 
    DBHOST = '[Your Initials]-host.sub[Number].[Your Initials]vcn.oraclevcn.com'
    DBSERV = 'pdb01.sub[Number].[Your Initials]vcn.oraclevcn.com'
    conn_string = DBUSER + '/' + DBPASS + '@//' + DBHOST + '/' + DBSERV
    connection = cx_Oracle.connect(conn_string)
    run(app, host='0.0.0.0', port=8080)
    connection.close()
````

Commit and push the changes to the master branch on code repository.

````
git commit -a -m "Add database connection"
git push
````

Verify build is successful. Test your web microservice connects to your Oracle Database.

````
python3 promotion.py 
Traceback (most recent call last):
  File "promotion.py", line 37, in <module>
    connection = cx_Oracle.connect(conn_string)
cx_Oracle.DatabaseError: ORA-12170: TNS:Connect timeout occurred
````

Q: Why do you receive this error? 
A: Because you need to open port 1521 in your VCN. 

Q: Why does Wercker run the build successfully if the application returns an error?
A: Because we didn't build a test unit to verify the database connection. One reason to implement Test Driven Development (TDD) with CI/CD.

## **Step 4:** Open Ports and Test Database Connection

Access your VCN details in Oracle Cloud console. Click on hamburger menu ≡, then Networking > **Virtual Cloud Networks**.

Click **Security Lists** in the lower left menu, and **Default Security List for [Your Initials]-VCN** on the right side. Click **Add Ingress Rules**.

- Source CIDR: 0.0.0.0/0
- Destination Port Range: 1521
- Description: Allow database connection

Leave the default values for other controls. Click **Add Ingress Rules**. This rule gives access to the entire Internet to connect to our database, but for this lab it is fine, we want to keep it simple.

On our development environment, try again the application

````
python3 promotion.py 
Bottle v0.12.18 server starting up (using WSGIRefServer())...
Listening on http://0.0.0.0:8080/
Hit Ctrl-C to quit.
````

Use the web browser on your laptop to open [http://localhost:8080/conn](http://localhost:8080/conn). The response is '19.6.0.0.0'. Your Python web micro service application is connected to your Oracle Database. Press Ctrl-C to stop the application.

>**Note** : The response may be '19.6.0.0.0' or higher, depending on the version of Oracle Database you have on your Database Cloud Service instance. If this is the case, please consider your actual version for the rest of the workshop.

Edit test_promotion.py, and add a unit test for database connection. This is how it has to be:

````
"""
Unit tests for simple Python application
"""

import promotion
import pytest
from webtest import TestApp
import cx_Oracle


class TestPromotion:

    def test_addition(self):
        assert '1200' == promotion.addition(1150, 50)

    def test_increment(self):
        assert '1250.0' == promotion.increment(1000, 25)

    def test_decrease(self):
        assert '970' == promotion.decrease(1150, 180)


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


@pytest.fixture(scope='session')
def test_connection():
    DBUSER = 'hr'
    DBPASS = 'WelCom3#2020_'
    DBHOST = '[Your Initials]-host.sub[Number].[Your Initials]vcn.oraclevcn.com'
    DBSERV = 'pdb01.sub[Number].[Your Initials]vcn.oraclevcn.com'
    conn_string = DBUSER + '/' + DBPASS + '@//' + DBHOST + '/' + DBSERV
    connection = cx_Oracle.connect(conn_string)
    response = connection.version
    assert response == '19.6.0.0.0'
    connection.close()
````

We added a line at the top to import cx_Oracle extension module, and a fixture that will only be run once for the entire test session.

Commit and push the changes to the master branch on code repository.

````
git commit -a -m "Add database connection unit test"
git push
````

## **Step 5:** Oracle Instant Client on Docker Container

We have [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client.html) installed on the development machine, but not on the build environment. Remember, our development environment is the Compute Instance on OCI with **Oracle Linux Server 7.7**, based on Cloud Developer Image. Our build, and future deployment environment, is a Docker image with **Debian GNU/Linux 10 (buster)** with Python 3, we get from Docker Hub, called **python:3.7**.

We have to add in **wercker.yml** a new Step to prepare our build and future deployment environment with Oracle Instant Client. This new Step has to be executed before the automated tests:

````
build:
    box: python:3.7
    steps:

    # Step 1: create virtual environment and install dependencies
    - script:
        name: install dependencies
        code: |
            python3 -m venv orclvenv
            . orclvenv/bin/activate
            pip install -r requirements.pip
    # Step 2: install Oracle client basic lite
    - script:
        name: install oracle-instantclient19.6
        code: |
            echo "deb http://ftp.debian.org/debian experimental main" >> /etc/apt/sources.list
            apt-get update
            apt-get install -y alien
            apt-get install -y libaio1
            wget https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-basiclite-19.6.0.0.0-1.x86_64.rpm
            alien -i oracle-instantclient19.6-basiclite-19.6.0.0.0-1.x86_64.rpm
            export LD_LIBRARY_PATH=/usr/lib/oracle/19.6/client64/lib:$LD_LIBRARY_PATH
    # Step 3: run linter and tests
    - script:
        name: run tests
        code: |
            . orclvenv/bin/activate
            flake8 --exclude=orclvenv* --statistics
            pytest -v --cov=promotion
````

This step adds a new package repository, installs two required packages, Oracle Instant Client 19.6, and sets **LD_LIBRARY_PATH** environment variable.

Commit and push the changes.

````
git commit -a -m "Add Oracle Instant Client"
git push
````

## **Step 6:** Web Publish Employees Table

Now we can add new features to our HR application. First feature will list all employees, whit their salary and commission. Add this new function with routing in promotion.py. 

````
@app.route('/employees')
def emp():
    sql = '''select FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT,
                    SALARY * (1 + nvl(COMMISSION_PCT,0)) as "Total"
             from EMPLOYEES order by 1,2'''
    employees = '''<table border=1><tr><td>First Name</td><td>Last Name</td>
                   <td>Salary</td><td>Commission</td><td>Total</td></tr>'''
    cursor = connection.cursor()
    for res in cursor.execute(sql):
        employees += '<tr><td>' + res[0] + '</td><td>' + res[1] + '</td><td>' + str(res[2]) + '</td><td>' + str(res[3]) + '</td><td>' + str(res[4]) + '</td></tr>'
    employees += '</table>'
    return str(employees)
````

Test the web service locally, on the development environment.

````
python3 promotion.py 
Bottle v0.12.18 server starting up (using WSGIRefServer())...
Listening on http://0.0.0.0:8080/
Hit Ctrl-C to quit.
````

Use the web browser on your laptop to open [http://localhost:8080/employees](http://localhost:8080/employees). It shows a table with all employees in the HR schema. Hit Ctrl-C. Commit and push the changes.

````
git commit -a -m "Add new feature to list employees"
git push
````

Open Wercker console. Build pipeline returns and error:

````
./promotion.py:40:80: E501 line too long (162 > 79 characters)
````

By Python programming standards, all lines need to be under 80 characters. Our line number 40 has 162 characters. Change this new function with the following code, where that line is split in 3 separate lines:

````
@app.route('/employees')
def emp():
    sql = '''select FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT,
                    SALARY * (1 + nvl(COMMISSION_PCT,0)) as "Total"
             from EMPLOYEES order by 1,2'''
    employees = '''<table border=1><tr><td>First Name</td><td>Last Name</td>
                   <td>Salary</td><td>Commission</td><td>Total</td></tr>'''
    cursor = connection.cursor()
    for res in cursor.execute(sql):
        employees += '<tr><td>' + res[0] + '</td><td>' + res[1] + '</td><td>'
        employees += str(res[2]) + '</td><td>' + str(res[3]) + '</td><td>'
        employees += str(res[4]) + '</td></tr>'
    employees += '</table>'
    return str(employees)
````

Commit and push the changes.

````
git commit -a -m "Fix long line problem"
git push
````

## **Step 7:** Add New Features to Web Service

Add one more feature that calculates an increase to all employees salary with a percentage.

````
@app.route('/salary_increase/<percentage>')
def sal_inc(percentage):
    sql = '''select FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT,
                    SALARY * (1 + nvl(COMMISSION_PCT,0)) as "Total",
                    SALARY * (1 + ''' + percentage + '''/100) as "New Salary",
                    SALARY * (1 + ''' + percentage + '''/100) * (1 + nvl(COMMISSION_PCT,0)) as "New Total"
             from EMPLOYEES order by 1,2'''
    employees = '''<table border=1><tr><td>First Name</td><td>Last Name</td>
                   <td>Salary</td><td>Commission</td><td>Total</td>
                   <td>New Salary</td><td>New Total</td></tr>'''
    cursor = connection.cursor()
    for res in cursor.execute(sql):
        employees += '<tr><td>' + res[0] + '</td><td>' + res[1]
        employees += '</td><td>' + str(res[2]) + '</td><td>' + str(res[3])
        employees += '</td><td>' + str(res[4]) + '</td><td>' + str(res[5])
        employees += '</td><td>' + str(res[6]) + '</td></tr>'
    employees += '</table>'
    return str(employees)
````

And the final feature that adds a fixed values to the commission percentage to all employees.

````
@app.route('/add_commission/<value>')
def add_commp(value):
    sql = '''select FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT,
                    SALARY * (1 + nvl(COMMISSION_PCT,0)) as "Total",
                    nvl(COMMISSION_PCT,0) + ''' + value + ''' as "New Commission",
                    SALARY * (1 + nvl(COMMISSION_PCT,0) + ''' + value + ''') as "New Total"
             from EMPLOYEES order by 1,2'''
    employees = '''<table border=1><tr><td>First Name</td><td>Last Name</td>
                   <td>Salary</td><td>Commission</td><td>Total</td>
                   <td>New Commission</td><td>New Total</td></tr>'''
    cursor = connection.cursor()
    for res in cursor.execute(sql):
        employees += '<tr><td>' + res[0] + '</td><td>' + res[1]
        employees += '</td><td>' + str(res[2]) + '</td><td>' + str(res[3])
        employees += '</td><td>' + str(res[4]) + '</td><td>' + str(res[5])
        employees += '</td><td>' + str(res[6]) + '</td></tr>'
    employees += '</table>'
    return str(employees)
````

Commit and push the changes.

````
git commit -a -m "Add final features"
git push
````

If all steps were followed correctly, this build is successful. We can test the application on the development environment now.

````
python3 promotion.py 
Bottle v0.12.18 server starting up (using WSGIRefServer())...
Listening on http://0.0.0.0:8080/
Hit Ctrl-C to quit.
````

In your browser open [http://localhost:8080/salary_increase/8](http://localhost:8080/salary_increase/8). It simulates a salary increase with 8% for all employees in our HR schema. Now open [http://localhost:8080/add_commission/.15](http://localhost:8080/add_commission/.15). This web service simulates adding 15% to the commission for all employees. 

Hit Ctrl-C to close the application.

In this lab, we were able to:

- Connect our Python microservice to Oracle Database
- Create unit test for database connection per CI/CD requirements
- Install Oracle Instant Client on deployment environment
- Enhance our HR application with new features

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, Principal Product Manager, DB Product Management, May 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.

