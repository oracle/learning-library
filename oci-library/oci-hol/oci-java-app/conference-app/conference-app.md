# The Conference Application

## Introduction

This simple application is themed around 'conferences', it provides a simple REST endpoint that lists speakers and a basic web user interface.

⚠️ For the sake of brevity and clarity, this application takes some shortcuts and does not necessarily implement all the best practices recommended for an application that would go into production. Typically, you would have to think about concerns such as security, synchronization, testing, data validation, availability, scaling, etc. none of which are relevant in the context of today's lab!

Estimated Lab Time: 5 minutes

### Objectives
- Clone and build a Helidon application that will be used to test some of the recent Java features.

## **STEP 1**: The Conference Application

The application is hosted on GitHub, just clone its repository:

```
cd ~
git clone https://github.com/delabassee/odl-java-hol.git
cd odl-java-hol
```


The repository has multiple branches

* `lab4` : starting point
* `lab5` : lab 6 starting point, including the lab 5 solution
* `lab6` : lab 7 starting point, including the lab 5 and 6 solution
* `lab7` : lab 8 starting point, including the lab 5 to 7 solutions
* `lab8` : lab 9 starting point, including the lab 5 to 8 solutions
* `lab9` : lab 10 starting point, including the lab 5 to 9 solutions
* `lab10` : all solutions from lab 5 to 10 included

💡 `lab10` is optional and does not require any code update so there's no solution for this lab.

Switch to the starting point:
```
git checkout lab4
```

Update the project's `pom.xml` to enable Preview Features as described in the previous section.

## **STEP 2**: Build and test the Application

By now, you should know how to build and test an Helidon application. 

Either using Maven:

```
mvn clean package
java --enable-preview -jar target/conference-app.jar
# When the app is not using any preview features… 
# java -jar target/conference-app.jar
```

or using the Helidon CLI devloop:

```
helidon dev --app-jvm-args "--enable-preview"
# When the app is not using any preview features… 
# helidon dev
```

The Conference application exposes simple REST endpoints to get speaker-related information.

* http://{public-ip}:8080/speakers ➞ Get all speakers
* http://{public-ip}:8080/speakers/company/{company} ➞ Get speakers for a given company
* http://{public-ip}:8080/speakers/lastname/{name} ➞ Get speaker by its lastname
* http://{public-ip}:8080/speakers/track/{track} ➞ Get speakers for a given track
* http://{public-ip}:8080/speakers/{id} ➞ Get speaker details for a given id

Once the application is running, you can test it. 

* http://{public_ip}:8080/speakers/lastname/goetz
* http://{public_ip}:8080/speakers/company/oracle
* http://{public_ip}:8080/speakers/track/db

## Lab Navigation & Tips

Here are some simple tips that might be useful in the course of this Lab.

* The left bar is used to navigate within the current exercise. The right bar is used to navigate between exercises. If it is too obtrusive, just hide it.

* To switch between branches, use `git branch checkout {target-branch}`, ex. `git checkout -f lab10`

* To list branches: `git branch -a`

* Any given branch contains the solutions of the preceding exercises. If you are lost just checkout the n+1 branch and check your code.

* You can also browse branches' content directly on [GitHub](https://github.com/delabassee/odl-java-hol/branches)

* During this lab, you will only do simple Java coding so you won't use a Java IDE. Instead, you will use the versatile `nano` text editor. Here are some of its important key shortcuts.

	* <kbd>Control</kbd> <kbd>x</kbd> : Exit
	* <kbd>Control</kbd> <kbd>o</kbd> : Save
	* <kbd>Control</kbd> <kbd>k</kbd> : Delete Line
	* <kbd>Control</kbd> <kbd>g</kbd> : Help
	* <kbd>Control</kbd> <kbd>y</kbd> : Page Up
	* <kbd>Control</kbd> <kbd>v</kbd> : Page Down

* It is recommended to use Firefox to test REST endpoints as it renders nicely the returned JSON payload. If you are comfortable with CLI, you can also use `curl` in combination with `jq` to format JSON responses.

* If you get errors while using Helidon's devloop, you might want to re-build the project using Maven to get additional details on those error(s).

* For brevity, packages will sometimes be omitted from code snippets, they are obviously required. If you are not sure, simply check the solution.

* To view files, you can use `bat` as it offers syntax highlighting.

* If you are using the Helidon `devloop`, make sure to enable preview features! `helidon dev --app-jvm-args "--enable-preview"`

*You can proceed to the next lab*

## Acknowledgements

 - **Author** - [David Delabassee](https://delabassee.com)
 - **Last updated By** - Kamryn Vinson, September 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
