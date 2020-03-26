# Designing an API
Using Oracle Apiary which is a part of Oracle API Platform Cloud Service, you can design an API using either API Blueprint or Swagger/OpenAPI.  This tutorial walks through the design process and also provides a pre-created API Blueprint to accelerate the creation of the serviceTickets API.   

## Before you begin

- You need to have an account on Apiary.  You can sign up for a free developer account at http://apiary.io

## Creating the API Design
### Log into Apiary
Point your browser to http://apiary.io and sign in.  You may see the sample API that was created when you signed up.
### Create a new API Project
Click on the project name in the upper-left side and select *Create New API Project*
### Name your new API Project
You can call the API _ticketService_ to follow along with the demo scenario, but really you are free to choose whatever name you like.  Just remember your choice as the guides will refer to it as _ticketService_! 
  1. You can leave this as a Personal API
  2. If you are a member of an Apiary team, you have the option of making the API private.
  3. You can choose API Blueprint or Swagger.  For this example, API Blueprint is used.

  You will find that the API was created with the "Polls" API created as a template.  This is just to provide you with guidance to help jump-start your work.
  
> Use the [ticketService API Blueprint](./ticketService.apib) as your reference.  Rather than type everything by hand, you can open it in an editor, copy it and past it over the "Polls" sample in the Apiary editor

This tutorial will not walk through each step of the API Blueprint, but take some time to compare the API Blueprint on the left-hand side with the automatically generated documentation on the right.  You can try changing some of the blueprint to see the changes reflected on the right.

Make sure to click *Save*

#### Learn more
The Apiary design editor provides a rich experience for designing, collaborating and understanding the contract for an API.  Learn more with the following resource(s):
  * [Apiary Editor](https://help.apiary.io/tools/apiary-editor/)
  * [Interactive Documentation](https://help.apiary.io/tools/interactive-documentation/)

## Use the Mock Server to prototype your design
When you create your design in Apiary, you get interactive documentation automatically generated, but there is also a mock server that is created for you!  The mock server helps you to prototype your design by a working end-point that you can use.
> Reminder: Make sure you have saved your design

Every time you click *Save*, Apiary generates a mock-server based on your design.  Using your interactive documentation, you can now test the design.

### Test in the Apiary Console
  1. Under the *Tickets Collection* in the interactive documentation, click the *List All Tickets*
  2. The code example should be selected.  Make sure *Mock Server* is selected, and choose the Language of your choice.  
    _You may switch between the different languages to see examples of how to call the API._  
  3. After reviewing, click the *Try* button
  4. You will see options to set various parameters and headers, etc, but in this case just confirm that *Mock Server* is selected and click the *Call Resource* button.
  5. After the resource executes, scroll down to review the response from the mock server.
  
#### Extra Credit
  Use your favorite REST client to call the mock server end-point that displays in the Example and Console windows
#### Learn more
The Apiary Mock Server is a powerful feature that allows your team to test the API design in order to make sure  the correct API is being developed at all times.  Learn more with the following resource(s):
  * [Mock Server](https://help.apiary.io/tools/mock-server/)

## Conclusion
In this tutorial you learned the following:
  * How to design an API in Oracle Apiary
  * How Interactive Documentation is produced from the API design
  * How to use the Mock Server that is automatically generated from the API design

