# Workshop with common labs

## Instructions

1. Open the workshop-multiple template in Atom or Visual Studio Code using workshop-multiple
2. Start atom-live-server (Atom) or live-server (Visual Studio Code)
3. Look at workshop-with-commons/product-solution-short-name/workshops/everything-workshop-name/freetier
4. In another tab, open workshop-with-commons/product-solution-short-name/workshops/just-query-workshop-name
5. In a third tab, open workshop-with-commons/product-solution-short-name/workshops/just-visualization-workshop-name
6. We precreated 7 folders.  A workshop is created out of multiple labs.  
7. Make sure you stick to all lower case and dashes for spaces
8. Make sure you watch this [video](https://otube.oracle.com/media/1_ucr6grc6) for how to do Self QA of a workshop.  These are the standards that need to be met before going to production.  (It's short don't worry!)
9. Download our [QA Feedback doc](https://confluence.oraclecorp.com/confluence/download/attachments/1966947336/LiveLabs-QA-Feedback-Form-v2.docx?version=2&modificationDate=1598913736000&api=v2) as well.  We find workshops get in production quicker when you know what's needed to move to production up front and you use the skeleton.

PS  You do not need a Readme.md.  Readme's exist only at the top library levels. We direct all traffic to LiveLabs since we can't track usage on GitHub.  Do not create any direct links to GitHub, your workshop may be super popular but we can't track it so no one will know.

## Folder Structure

In this example, the goal is to create several "children" workshops from one longer "parent" workshop. The children are made up of parts from the parent.

workshop-multiple/

    product-solution-short-name/

        -- individual labs

        provision/
        setup/
        dataload/
        query/
        analyze/
        visualize

    workshops/
      everything-workshop-name/      -- contains one of the prerequisites and all 6 individual labs
        introduction/
          introduction.md            -- description of the everything workshop
       freetier/                     -- freetier URL endpoint of the workshop
        index.html
        manifest.json
       livelabs/
      just-query-workshop-name/      -- contains one pre-req + labs 1 - 4 of the individual labs
      just-visualize-workshop-name/  -- contains one pre-req + labs 1 - 3, and lab 6

### FreeTier vs LiveLabs

* "FreeTier" - includes Free Trials, Paid Accounts and for some workshops, Always Free accounts.
* "LiveLabs" - these are workshops that use Oracle provided tenancies

### The everything-workshop

The "everything" workshop covers all 6 of the individual labs in this sequence.

The folder structure includes a Introduction "lab" that describes the workshop as a complete set of 6 labs. Note: you may not need to have a different introduction for each of the parent and child versions of the workshops, this is illustrative only.

Look at the everything-workshop/freetier folder and look at the manifest.json file to see the structure.

The Prerequisite "lab" is common to all three workshop types, and is in a common folder three levels up:

  ```
  "filename": "../../../common/prerequisite-freetier/prerequisite-freetier.md"
  ```

The labs are located three levels up, for example:

  ```
  "filename": "../../../provision/provision.md"
  ```

### The just-query and just-visualize workshops

These two workshops are "children" or subsets of the full workshop. One covers just enough content to introduce queries as the last lab, and the second just enough content to get to the visualize lab.

Read through the manifest.json file in the just-visualize-workshop and compare it to the manifest.json file of the everything-workshop.

You'll note that Lab 6 of the everything workshop is now Lab 4 in the just-visualize workshop.

### For example

* The [https://github.com/oracle/learning-library/tree/master/data-management-library/autonomous-database/shared] folder is a good example of a workshop with shared labs in several offerings.
* [The full set of 10 ADB labs](https://oracle.github.io/learning-library/data-management-library/autonomous-database/shared/workshops/freetier-indepth/)
* [A "quick start" version with the first 6 labs](https://oracle.github.io/learning-library/data-management-library/autonomous-database/shared/workshops/freetier-overview/)
* [A workshop that just covers provisioning](https://oracle.github.io/learning-library/data-management-library/autonomous-database/shared/workshops/provision/freetier/)
* [A workshop that covers just what is required to visualize data](https://oracle.github.io/learning-library/data-management-library/autonomous-database/shared/workshops/visualizations/freetier)

### More information

* [Creating the Structure of Markdown Labs](https://confluence.oraclecorp.com/confluence/display/DCS/Creating+the+Structure+of+Markdown+Labs)
* [See a working example on GitHub](https://github.com/oracle/learning-library/tree/master/data-management-library/autonomous-database/shared)

## Adding Support Forum

Copy the following section.  Replace the general support link with the support link for your workshop category.  We have a number of pre-created forums, click edit on your workshop to see if your workshop fits into any of the existing forums.  If not, submit a comment on your workshop to request to have one added.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
