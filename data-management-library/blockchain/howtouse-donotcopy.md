# Workshop with a single set of labs

## Instructions

1. Open the workshop-single-sets template in Atom or Visual Studio Code using workshop-single
2. Start atom-live-server (Atom) or live-server (Visual Studio Code)
3. Look at workshop-single/product-solution-short-name/workshops//freetier

## Folder Structure

In this example, the goal is to create several "children" workshops from one longer "parent" workshop. The children are made up of parts from the parent.

sample-workshop/
        -- individual labs

        provision/
        setup/
        dataload/
        query/
        analyze/
        visualize
        introduction/
          introduction.md       -- description of the everything workshop

    workshops/
       freetier/                -- freetier version of the workshop
        index.html
        manifest.json
       livelabs/                -- livelabs version of the workshop
        index.html
        manifest.json


### FreeTier vs LiveLabs

* "FreeTier" - includes Free Trials, Paid Accounts and for some workshops, Always Free accounts (brown button)
* "LiveLabs" - these are workshops that use Oracle provided tenancies (green button)

### About the Workshop

The workshop includes all 6 of the individual labs in a single sequence.

The folder structure includes a Introduction "lab" that describes the workshop as a complete set of 6 labs. Note: you may not need to have a different introduction for each of the parent and child versions of the workshops, this is illustrative only.

Look at the product-name-workshop/freetier folder and look at the manifest.json file to see the structure.

The Prerequisite "lab" is the first lab in a common folder three levels up:

  ```
  "filename": "../../../common/prerequisite-freetier/prerequisite-freetier.md"
  ```

Labs that are common across all workshops are linked using an absolute path, for example:

```
"filename": "https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/cloud-login-livelabs2.md"
```

The labs are located three levels up, for example:

  ```
  "filename": "../../../provision/provision.md"
  ```

### For example

This [APEX Workshop](https://oracle.github.io/learning-library/developer-library/apex/spreadsheet/workshops/freetier/) is a good example a workshop with a single set of labs: [https://github.com/oracle/learning-library/tree/master/developer-library/apex/spreadsheet](https://github.com/oracle/learning-library/tree/master/developer-library/apex/spreadsheet).


### More information

* [Creating the Structure of Markdown Labs](https://confluence.oraclecorp.com/confluence/display/DCS/Creating+the+Structure+of+Markdown+Labs)
* [See an working example on GitHub](https://github.com/oracle/learning-library/tree/master/data-management-library/autonomous-database/shared)
