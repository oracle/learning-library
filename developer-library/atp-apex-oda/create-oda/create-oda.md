# Create Oracle Digital Assistant

![Oracle Digital Assistant](./images/oda.png)

## Introduction

Oracle Digital Assistant is a platform that allows enterprises to create and deploy digital assistants for their users. With Oracle Digital Assistant, you create:

- **Digital assistants**, which are AI-driven interfaces that help users accomplish a variety of tasks in natural language conversations. For each digital assistant, you assemble one or more skills

- **Skills** (formerly known as chatbots), which are individual bots that are focused on specific types of tasks, such as tracking inventory, submitting time cards, and creating expense reports

You can add skills to digital assistants or deploy them to a channel on their own.

### Basic Concepts

Before you dive into digital assistant and skill development, here are some concepts you’ll want to get familiar with:

- **Intents**: Categories of actions or tasks users expect your skill to perform for them

- **Entities**: Variables that identify key pieces of information from user input that enable the skill to fulfill a task

Both intents and entities are common **Natural Language Processing (NLP)** concepts. NLP is the science of extracting the intention and relevant information from text.

- **Components**: Provide your skill with various functions so that it can respond to users. These can be generic functions like outputting text, or they can return information from a backend and perform custom logic

- **Dialog Flow**: The definition for the skill-user interaction. The dialog flow describes how your skill responds and behaves according to user input

- **Channels**: Digital assistants and skills aren’t apps that you download from an app marketplace, like iTunes. Instead, users access them through messaging platforms or through client messaging apps. Channels, which are platform-specific configurations, allow this access. A single digital assistant or skill can have several channels configured for it so that it can run on different services simultaneously

Watch our short video that explains Lab 3 - Create Oracle Digital Assistant, Lab 4 - Implement Custom Component and Lab 5 - Create Digital Assistant Skill:

[](youtube:kdvjXTMC-PI)

Estimated Lab Time: 10 minutes

Watch the video below for an overview of the Create Oracle Digital Assistant lab
[](youtube:-5m8CB3J9fs)

### Objectives

In this lab, you will:
-  Create and explore your Digital Assistant instance

### Prerequisites

- This lab assumes you have logged into your to Oracle Cloud account.

## **STEP 1**: Create a Digital Assistant instance

**Create** a Digital Assistant instance to start working with bots. You can find advance set up steps on the [official documentation](https://docs.oracle.com/en/cloud/paas/digital-assistant/use-chatbot/order-service-and-provision-instance.html#GUID-7E4F1CE5-FB40-45DF-B0F0-949289F5E184).

1. Go to the **Menu**, **Analytics & AI** and **Digital Assistant**:

    ![ODA Menu](./images/oda_1_1.png)

2. Click on **Create Digital Assistant Instance** button:

    ![ODA Menu](./images/oda_2.png)

    You will have the **root compartment** selected, or pick the one you want.

3. Fill the information as in the next image. Developer edition is perfect for this workshop and develop new **Digital Assistant** systems until you want to move to production.

    Finally click "**Create**" bottom:

    ![ODA Menu](./images/oda_3.png)

4. Wait for the instance to be "**Active**". The creation process will take a few minutes.
    Once the instance is **Active**, then on the instance menu, click on "**Service Console**":

    ![ODA Menu](./images/oda_4.png)

5. You will have to **Log-in** again with your **Account name**, **User** and **Password**.

    Ensure you are on the right **Tenancy** or **Account** and click **Continue**.

    ![ODA Log in](./images/oda-login-1-new.png)

    If not, click on **Change Tenant**, type your **Account Name** or **Tenancy** and click **Continue**.

    ![ODA Log in](./images/oda-tenancy-1.png)
    ![ODA Log in](./images/oda-tenancy-2.png)

6. Provide your **Username**, **Password** and click **Sign In** to visit **Oracle Digital Assistant Home** page.

    ![ODA Log in](./images/oda-login-2-new.png)

7. You will be on the Oracle Digital Assistant **Dashboard** where you can start building your bots.

    ![ODA Menu](./images/oda_5_new2.png)

## **STEP 2**: Explore your Digital Assistant

You can always **Watch Videos** on the **Learn** section at the bottom and explore the documentation of Oracle Digital Assistant by following the links on the dashboard.

Make sure you look around and feel familiar with the menus.

![ODA Menu](./images/oda_6_new2.png)

You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Victor Martin - Technology Product Strategy Manager, Priscila Iruela - Technology Product Strategy Director
- **Contributors** - Melanie Ashworth-March
- **Last Updated By/Date** - Anoosha Pilli, March 2021

