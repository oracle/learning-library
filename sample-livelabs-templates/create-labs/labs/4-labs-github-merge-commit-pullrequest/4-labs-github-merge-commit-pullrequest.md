# Use GitHub Desktop to Commit to the GitHub Repository

## Introduction

As a best practice, merge your library everyday or whenever you start your GitHub Desktop application. Merge pulls all the commits (changes) from the [upstream/master repository (production)](https://github.com/oracle/learning-library), into your local filesystem clone (local machine). This keeps your local clone up-to-date with other people's work (commits) from the upstream/master. Next, you push the updated content from your clone into the origin of your clone, that is, your fork, to synchronize your clone with your fork. Merging also avoids the long time it could take to complete if you don't do that often.

### Objectives

* Commit your changes.
* Request for a review.
* Test your content.
* Create a Pull Request to upload your content to master.

### What Do You Need?
* Git Environment Setup
* GitHub Desktop client


This lab assumes that you have successfully completed **Lab 3: Using Atom Editor to Develop Content** in the **Contents** menu on the right.

## **Step 1:** Get Latest Updates from Production

Before you develop you should ensure you have the latest content from production to ensure you are developing off the latest code set.

1. Go to your personal github repo on the web and determine if your personal repo is behind the master.  If it is perform the following steps to sync.  This should be done before you commit.

  ![](./images/git-hub-sync-behind.png " ")

2. Start your **GitHub Desktop** client.  Go to **Branch** -> **Merge into Current Branch**.

  ![](./images/git-hub-merge-branch.png " ")

3. Select the branch upstream/master (there may be a number of branches, search until you see *upstream/master*). Press the **merge upstream/master into master** button.
   
  ![](./images/git-hub-merge-branch-2.png " ")

4. Press refresh on your personal github repo on the web, you should have no commits *behind* now, only *ahead*.

  ![](./images/git-hub-merge-ahead.png " ")


## **Step 2:** Commit your Changes in your Clone
When you create, delete, or modify assets in your clone (local copy), you should commit (save) those changes to your clone, and then push those changes from your clone to your fork. Then these changes get saved to your forked learning-library repository.

To commit your changes:
1. Start your **GitHub Desktop** client.
2. In the **Summary (required)** text box on the left (next to your picture), enter a summary of your changes. You can optionally add a more detailed description of your changes in the **Description** text box.

  ![](./images/git-hub-commit-to-master.png " ")

3. Click **Commit to master**. This saves your changes in your local clone. **Fetch Origin** changes to **Push Origin**.

4. Click **Push origin** (it should have an upward arrow with a number). This pushes the updated content from your clone into the origin of this clone, that is, your fork.

  ![](./images/git-hub-commit-push-origin.png " ")


## **Step 3:** Set Up GitHub Pages for your Fork to Test your Content

After you upload the content from your clone to your fork, request your review team members to review this content by providing them with access to your GitHub Pages site URL (or the URL of your forked repository).

The GitHub Web UI has a feature called as **Set Up GitHub Pages for Your Fork** to Test Your Content. This feature performs a dynamic conversion of the Markdown files (.md files you have developed using your Atom Editor) to HTML. You can preview your workshop and labs on your forked repository and provide this URL to your reviewers.

To publish your GitHub Pages site:
1. Login to [GitHub Web UI](http://github.com) using your GitHub account credentials, and then click your fork's link in the **Repositories** section to display your fork.

  ![](./images/git-hub-stage-git-hub-pages-repositories.png " ")

2. Click **Settings**.

   ![](./images/git-hub-stage-git-hub-pages-settings.png " ")

3. Click **Options** and scroll down to the **GitHub Pages** section.

  ![](./images/git-hub-stage-git-hub-pages-settings-theme.png " ")

4. Under **Source**, select **master** (if it's not already selected) from the drop-down list.
5. Under **Theme Chooser**, click **Change Theme** and select a theme of your choice.

  This may take a few minutes to complete. After the GitHub Pages are enabled, the message under **GitHub Pages** changes to **Your site  is published at https://achepuri.github.io/learning-library**
  ![](./images/git-hub-stage-git-hub-pages-settings-page-published.png " ")

## **Step 4:** Sharing your Workshop for Review
After you have successfully set up your GitHub pages, you can share your workshop for review.
To share and view your workshop:
1. In the browser, enter the URL of your GitHub Pages [https://achepuri.github.io/learning-library/](https://achepuri.github.io/learning-library/).
2. Append the URL with the details of your workshop.
    The complete URL will look similar to this: [https://achepuri.github.io/learning-library/sample-livelabs-templates/create-labs/labs/workshops/freetier/](https://achepuri.github.io/learning-library/sample-livelabs-templates/create-labs/labs/workshops/freetier/), which can be shared for review.

## **Step 5**: Create a Pull Request to Upload Your Content to the Master Repository

The **Pull Request** is a request that you send to the repository owners and code owners of the **oracle/learning-library** repository to approve and host your content on production **(upstream/master)** repository).

Note:  *Before executing a PR, make sure you have run Step 1 above and that your personal github repo on the web is not behind.*

**Note**: The owners can approve your request, ask for more information if required, or reject your request if your content does not meet the standards for Oracle GitHub.

To create a Pull Request:
1. In the **GitHub Desktop** client, select **Branch > Create pull request** to display a browser interface.

  ![](./images/git-hub-branch-pull-request.png " ")

2. Click **Create pull request** to display an **Open a pull request** page.

  ![](./images/git-hub-branch-browser-create-pull-request.png " ")

3. Enter the title for the pull request and include your LWMS ID (you can find that by visiting the [LWMS](http://bit.ly/oraclelivelabs)) in the title and then click **Create pull request**.
    ![](./images/git-hub-pull-request-title-comment.png " ")
  A status page is displayed indicating that you have created a pull request along with the request number (for example, #1770), that it is pending review, and that merging is blocked.

  When your pull request is approved, the page gets updated with information about your commits being approved and merged into the **upstream/master** repository (production).

  When the pull request is approved and merged into the **upstream/master** repository, two emails are sent to the e-mail account associated with your GitHub account.

  **Note**:
    * The first email notifies you that your pull request was approved (or rejected).
    * If your pull request was approved, then the second email notifies you that your pull request was merged into the **upstream/master** repository.  

  Your committed content is now visible to the public on the learning-library (upstream/master or production) repository.

## **Step 6**: Accessing your workshop in GitHub

After your pull request is complete, wait a few minutes and perform the steps below.  

1.  replace your GitHub pages site from Step 3 -> #5 with oracle.github.io.  This will take you to the full path of your workshop.  

  ![](./images/git-hub-stage-git-hub-pages-settings-page-published.png " ")

2. This workshop for example is located in the link below.

  https://github.com/oracle/learning-library/tree/master/sample-livelabs-templates/create-labs/labs/workshops/freetier

3. The published version becomes: 

  https://oracle.github.io/learning-library/sample-livelabs-templates/create-labs/labs/workshops/freetier

4.  Go into the LWMS (Oracle employees only - bit.ly/oraclelivelabs) and click edit your workshop.
5.  Go to the row for your workshop and change your workshop status to at least *Moving to GitHub* *Note: If your workshop is already in production you will need to contact livelabs-admin_us@oracle.com to edit it.* 
6.  Click on the ID for your workshop
7.  On the edit page, scroll down and update the **Production GitHub URL** update it to the new oracle.github.io address you identified in step 3. 
8.  Update your Development GithHub URL to your personal github pages address
9.  When you are finished with your workshop, set your workshop status to **Self QA**.
10. Questions?  Contact the email underneath Support Link.

**This concludes this lab. Please proceed to the next lab in the Contents menu.**

## Want to Learn More?

* [Using GitHub Desktop to merge, commit and make pull requests](https://otube.oracle.com/media/t/1_bxj0cfqf)
* [Use GitHub Desktop](https://confluence.oraclecorp.com/confluence/display/DBIDDP/Use+GitHub+Desktop)

## Acknowledgements

* **Author:**
    * Anuradha Chepuri, Principal User Assistance Developer, Oracle GoldenGate
* **Contributors:**
    * Lauran Serhal, Principal User Assistance Developer, Oracle Database and Big Data User Assistance
* **Reviewed by:**  
    * Aslam Khan, Senior User Assistance Manager, ODI, OGG, EDQ
    * Tom McGinn, Database and Database Cloud Service Senior Principal Product Manager, DB Development - Documentation
* **Last Updated By/Date:** Anuradha Chepuri, November 2020


