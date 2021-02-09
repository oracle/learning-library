# Introduction

Ever found yourself in a situation where you have an umbrella and no rain or late at night in a parking lot with no snowbrush because you were given what you consider to be misinformation? Are you tired of your local weatherman predicting the weather incorrectly and you want to do something about it? Well, this is a lab you may find value in. Today we are going to discuss and guide you through how to set up and run WRF on OCI infrastructure. I'll also provide a script just incase you want to run WRF without learning how to set it up.

Estimated lab time: 90 minutes

### About WRF

WRF is the abbreviation for The Weather Research and Forecasting Model. It is a mesoscale numerical weather prediction system designed for both atmospheric research and operational forecasting applications. WRF exists today do to a partnership that began in the late 90’s between the National Center for Atmospheric Research (NCAR), the National Oceanic and Atmospheric Administration (represented by the National Centers for Environmental Prediction (NCEP) and the Earth System Research Laboratory), the U.S. Air Force, the Naval Research Laboratory, the University of Oklahoma, and the Federal Aviation Administration (FAA). WRF is open-source and is available on github.
WRF allows researchers to simulate the weather using either real data that has been collected via observations and analyses or idealized atmospheric conditions. WRF provides operational forecasting a platform, where many contributors have helped to make advances in physics, numerics, and data assimilation. WRF is currently in operational use at NCEP and other forecasting centers internationally which is a pretty big deal. 

### Objectives

Topics covered in this lab:
* Downloading dependencies and WRF
* Compiling libraries for WRF/WPS
* Compiling WRF and WPS
* Creating WRF domain with Geogrid
* Downloading GFS data and running Ungrib and Metgrid
* Running WRF with real data


### Prerequisites

This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account

## Acknowledgements
* **Author** - Brian Bennett, Solution Engineer, Big Compute
* **Last Updated By/Date** - Brian Bennett, Big Compute, December 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.