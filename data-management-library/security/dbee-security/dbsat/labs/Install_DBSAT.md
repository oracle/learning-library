![](../../../images/banner_DBSAT.PNG)

# [Lab] Installing DBSAT

Oracle Database Security Assessment Tool (DBSAT) zip file can be found at [Oracle Support Document 2138254.1](https://support.oracle.com/epmos/faces/DocumentDisplay?id=2138254.1)

---
**NOTE:** DBSAT has already been downloaded to DBSec-Lab VM

---


- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd $DBSEC_HOME/workshops/Database_Security_Labs/DBSAT

- Create a directory to install DBSAT

        mkdir dbsat22

- Unzip the tool to the dbsat22 directory

        unzip /u01/app/sources/dbsat-2.2.zip -d dbsat22

  ![](../images/DBSAT_000.PNG)

- DBSAT is now installed!
---
Move up one [directory](../README.md)

Click to return [home](/README.md)
