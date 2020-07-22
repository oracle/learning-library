# Workshop with common labs

## Instructions

1. Open the workshop-single-set-labs template in Atom or Visual Studio Code using workshop-single-set-labs
2. Start atom-live-server (Atom) or live-server (Visual Studio Code)
3. Look at workshop-with-common-labs/product-area/product-type/workshops/everything-workshop-name/freetier
4. In another tab, open workshop-with-common-labs/product-area/product-type/workshops/just-query-workshop-name
5. In a third tab, open workshop-with-common-labs/product-area/product-type/workshops/just-visualization-workshop-name

## Folder Structure

In this example, the goal is to create several "children" workshops from one longer "parent" workshop. The children are made up of parts from the parent.

workshop-with-shared-labs/
  product-area/
    product-type/

        -- individual labs

        provision-lab/
        setup-lab/
        dataload-lab/
        query-lab/
        analyze-lab/
        visualize-lab

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
  "filename": "../../../common/prerequisite-freetier-lab/prerequisite-freetier-lab.md"
  ```

The labs are located three levels up, for example:

  ```
  "filename": "../../../provision-lab/provision-lab.md"
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
* [See an working example on GitHub](https://github.com/oracle/learning-library/tree/master/data-management-library/autonomous-database/shared)
