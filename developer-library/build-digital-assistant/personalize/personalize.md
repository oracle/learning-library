# Personalize Your Digital Assistant

## Introduction

Once you have created a digital assistant and added skills to it, you can customize some of the aspects of the digital assistant, such as the invocation name of the digital assistant’s skills and the language in the digital assistant’s help and exit intents.

Estimated Lab Time: 20 minutes


### Objectives

In this lab, you will:
* Change the Invocation Name
* Test the Invocation Name
* Customize the built-in system intents and the prompts
* Test the Utterances and Modified Prompt

## **STEP 1**: Change the Invocation Name

An important part of configuring any skill is coming up with a good invocation name, which is used in explicit invocation of the skill. Here are the steps to change the invocation name of recently added skill:

1. In your DA, select the Skills icon. ![](./images/add-skill-icon.png " ")
2. Select **Pizza Skill**.
3. Scroll down to the Interaction Model section of the page and change the **Invocation Name** to *Pizza King*.
4. Change the example utterance to *Order Pizza*.

## **STEP 2:** Test the Invocation Name

Now let’s try various invocation patterns and see whether and how the digital assistant responds:

1. Click the tester icon. ![](./images/test_button.png " ")
2. In the tester's **Message** field, type *Go to Pizza King to place my pizza order*, press Enter, and note the DA's response.
3. Click the **Reset** button.
4. Now try *Pizza King*.
5. Click **Reset**.
6. Now try *Pizza King to check my order*.
7. Click **Reset**.
8. Now try *I want a large meaty pizza from pizza king.*
9. Click **Reset**.
10. Now try *Can you use Pizza King to place an order.*
11. Click **Reset**.

## **STEP 3**: System Intents and Prompts
You can customize the built-in system intents and the prompts that are driven by them.

First, let's add some utterances to the built-in help intent:

1. In your DA, select the Intents icon. ![](./images/left_nav_intents.png " ")
2. Select the **help** intent.
3. In the Examples section, add the following utterances:
- Can someone help me
- What can you do
- What things do you do
- What can I ask you

The digital assistant comes with configurable prompts to respond to various types of user input. These prompts can be modified in the DA's configuration settings.

Let's modify the DA's help prompt:

1. In the DA, click the Settings icon and select the **Configurations** tab.
2. Scroll down to the Conversation Parameters section of the page.
3. Modify the value of **Digital Assistants Help Prompt** to *Welcome! I can do following things for you:*
4. Click the Train icon, click **Submit**, and then wait a few seconds for the training to complete.

## **STEP 4**: Test the Utterances and Modified Prompt

To see the new utterances and prompt in action:

1. Click the tester icon. ![](./images/test_button.png " ")
2. In the tester's **Message** field, type *Can someone help me*, press Enter, and note the DA's response.


You may proceed to the next lab.

## Acknowledgements
* **Author** - Marcie Samuelsen
* **Contributors** -  Kamryn Vinson
* **Last Updated By/Date** - Kamryn Vinson, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
