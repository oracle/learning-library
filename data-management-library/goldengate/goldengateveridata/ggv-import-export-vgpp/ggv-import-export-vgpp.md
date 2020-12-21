# Use the Oracle GoldenGate Veridata Command-line Utilities

## Introduction
This lab describes how to accomplish the following tasks using Oracle GoldenGate Veridata command-line utilities:
  + Create Oracle GoldenGate Veridata configuration using the Veridata GoldenGate Parameter Processing program from the Oracle GoldenGate parameter files.
  + Run the compare job using Vericom.

You can use Oracle GoldenGate Veridata to verify the data that is being replicated by Oracle GoldenGate. You can compare the data of source and target.

With the mapping information of source database (db) and target db in the GoldenGate parameter file, you can use the parameter file to create the Oracle GoldenGate Veridata configuration.

Use the Veridata GoldenGate parameter processing command line utility to create Veridata configuration.

Use the Import utility to import this configuration into Oracle GoldenGate Veridata and the Export utility to export this configuration from Oracle GoldenGate Veridata. Use Vericom to run the comparison job.

**Note**:  After you have completed lab 1: Install and Configure Oracle GoldenGate Veridata, the rest of the **labs are independent of each other**. You can complete labs 2 to 5 in any sequence you want to.
### What Do You Need?

+ **Linux or Windows. This lab describe the Linux command-line options.**
+ **Oracle Database 19c (19.3.0.0) or Microsoft SQL Server (for the repository)**
+ **Java 1.8 or higher**
+ **Oracle GoldenGate (OGG) Software located at: [Oracle GoldenGate Downloads](https://www.oracle.com/middleware/technologies/goldengate-downloads.html)**

## **Step 1:** Run the Veridata GoldenGate Parameter Processing from the Oracle GoldenGate Parameter File
Veridata GoldenGate Parameter Processing (VGPP) is a command-line tool that uses the map and table parameter of extract and replicat parameter files to create the Oracle GoldenGate Veridata configurations. An Oracle GoldenGate Veridata parameter file contains all of the information required to extract or apply replicated data. The data-propagated replication is controlled by settings in the Extract and Replicat parameter files. Typically, the Extract parameter file specifies the tables to be replicated, the Replicat parameter file controls column mapping and restricts the tables. The Veridata GoldenGate Parameter Processing command-line utility accepts one or two parameter files as input. One of the files must be a Replicat parameter file, and the other optional file must be an Extract parameter file.

To run the Veridata GoldenGate Parameter Processing:
1. Ensure that the parameter files you want to use are on the system where the Oracle GoldenGate Veridata is installed. If you need to copy the files from another system, then copy them as binary files, so that the `CHARSET` parameter is valid.
2. Run the command shell of the operating system.
3. Navigate to the `VERIDATA_DOMAIN_HOME/veridata/bin` directory.
4. Run the Veridata GoldenGate Parameter Processing as follows:

    `./veridata_param_process.sh -noscripting -wluser veridata -wlport 8830 /scratch/ggcore/dirprm/extract.prm /scratch/ggcore/dirprm/replicat.prm -p properties.txt -o output.xml`

    For more information about the optional operations, see [Running Veridata GoldenGate Parameter Processing](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdad/running-veridata-goldengate-parameter-processing.html#GUID-FB072DEF-F5D2-41B7-9D82-B638DCB227F9).

## **Step 2:** Use the Connection Tags Generated to Update the XML of Step 1
To use the connection tags generated to update the XML:
1. Ensure that the Oracle GoldenGate Veridata agent is running on the machine which you are using to compare the data.
2. To use the connection tags generated to update the `output.xml`, when the Veridata GoldenGate Parameter Processing is run, you can specify an optional property.
  This file contains information that is not available in the Oracle GoldenGate parameter file and is required to generate a valid Oracle GoldenGate Veridata comparison configuration.
  For more information about the optional parameters, see [Using the Property File](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdad/running-veridata-goldengate-parameter-processing.html#GUID-8DE97B47-8CEB-4DE1-933C-37E0EBD96F9D).

## **Step 3:** Run the Import Utility to Import the XML Created in Step 1
In addition to using the Oracle GoldenGate Veridata Web User Interface, you can use the import utility, provided with the Oracle GoldenGate Veridata installation, to define portions of your configuration.

The import utility allows you to configure database connections, comparison groups including compare pairs, comparison jobs, and profiles. It takes an XML document as input then creates comparison objects in Oracle GoldenGate Veridata. Typically, the XML document matches the inputs on the configuration pages in the user interface.

To run the Import utility:
1. Navigate to the `VERIDATA_DOMAIN_HOME/veridata/bin` directory.
2. Run the Import utility as follows:
    <pre>veridata_import[.sh | .bat] [-wlport portNo] -wluser commandlineUusername [-create | -update | -delete | -replace] output.xml</pre>

## **Step 4:** Run the Export Utility to Export any Existing Oracle GoldenGate Veridata Configuration Created in Veridata Web
In addition to using the Oracle GoldenGate Veridata Web User Interface, you can use the export utility, provided with the Oracle GoldenGate Veridata installation, to define portions of your configuration. The export utility helps you to either selectively or completely export the compare configuration data to an XML file. It can be used to export configurations from your current Veridata configuration or from other Veridata configurations using the `-repoUrl` option. Additionally, you can use it to export configurations between different Veridata repository types using the import functionality. For example, from a SQL Server configuration to an Oracle configuration.

To run the Export Utility:

1. In the Oracle GoldenGate Veridata installation location, go to the **DOMAIN_HOME/veridata/bin** directory.
2. Run the Export utility as follows:
    <pre>veridata_export[.sh | .bat] -export filePath -wluser commandlineusername [-wlport portNo] [–jobs jobName | - groups groupName | -connections connName | -profiles profileName | -all | -exportPassword] [[-repoUrl jdbc_url] [-u username>][-schema schema_name][-vdtPath VERIDATA_PRODUCT_HOME]]</pre>

    In this command:
      * **-wlport**: Represents the port for Oracle GoldenGate Veridata web server. The default value is 8830.
      * **-wluser**: Specifies a commandline user with the Oracle GoldenGate Veridata configuration privileges and command-line privileges.
    For more information about the optional operations, see [Using the Export Utility](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdad/using-veridata-import-and-export-utilities.html#GUID-65C89CAC-8AD3-4A46-99F4-2837E8C07A1C)

## **Step 5:** Run the Job Using Vericom
The Vericom command-line interface provides a tool for you to manage identities in the credential store and run comparisons. You can use the vericom tool to execute certain comparison tasks from the command shell of the operating system. The vericom tool runs the Oracle GoldenGate Veridata command-line interface and enables you to handle these activities with automated programs. You can easily use the Vericom tool without specifying the actual user name and password.

To run the Vericom tool:
1. Navigate to the **VERIDATA_DOMAIN_HOME/veridata/bin** directory.
2. Run the vericom tool as follows:
   `vericom{.bat|.sh} required_parameter [ optional_parameter ]`

## Want to Learn More?

* [Administering Oracle GoldenGate Veridata](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdad/introduction-oracle-goldengate-veridata.html#GUID-E34C2B1C-AA1D-4F62-BBB5-05AB6A913B40)
* [Using Oracle GoldenGate Veridata](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/intro-veridata.html#GUID-5E0D122D-913C-4307-97FB-DF815409FB14)
* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/index.html)

## Acknowledgements

* **Author:**
    + Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Reviewed by:**
    + Apeksha Polnaya, Senior Manager, Software Development, GoldenGate Development
    + Avinash Yadagere, Principal Member Technical Staff, GoldenGate Development
    + Uma Maheshwari Gopal, Principal Member of Technical Staff, Database Testing
    + Sukin Varghese, Senior Member of Technical staff, Database Testing

* **Last Updated By/Date:** Anuradha Chepuri, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
