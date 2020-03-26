![](../common/images/customer.logo.png)
---
# ORACLE Cloud-Native DevOps workshop #

## Customization ##

This short tutorial shows how to customize the workshop content for personalized workshop delivery.

### Steps ###

#### Create own copy of the repository of workshop content ####

Open the browser and login to [https://github.com](https://github.com) In case you don't have an account you need to sign up for a new account.

Once you logged in click on top right corner into the context menu marked with sign "+" and select **Import repository**

In the field Old repository type: `https://github.com/nagypeter/learning-library.git` and in the Name field type e.g. `CUSTOMER_NAME-workshop`. Press the button **Begin import**

After the import is done your CaNDO repository is available at `https://github.com/YOUR_GITHUB_USERNAME/learning-library/tree/master/workshops/cloud-native-devops-workshop`.

#### Modify the content in personalized workshop ####

The easiest possibility to customize is available through deleting not needed content. So if you would like to deliver that content only with a subset of tutorials then modify the Table of Content file. To do so open your repository in the browser `https://github.com/YOUR_GITHUB_USERNAME/learning-library/tree/master/workshops/cloud-native-devops-workshop`.

Select the file **README.md**.

Click on the icon **Edit this file**.

You will open the metadata editor of table of the content. Customize it to your needs (for example by removing not needed tutorials). Click on **Commit changes** at the end.

We allow also to customize the tutorial and make it more personalized by modifying `cloud-native-devops-workshop/images/customer.logo.png` image. This image is presented on top of every tutorial page.
