![](../../../../images/banner_ASO.PNG)

# [Lab] TDE - Encrypt Existing Tablespace

The easiest way to get started is to encrypt the `EMPLOYEESEARCH_DATA` tablespace.

- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Encrypt_Existing_Tablespace

- First, use the Linux command, strings, to view the data in the data file.<br>
This is an operating system command that bypasses the database to view the data. This is called a 'side-channel attack' because the database is unaware of it.

        ./01_Search_Strings_Plain_Text.sh  

    ![](../images/TDE_015.PNG)

- Second, encrypt the data by encrypting the entire tablespace:

        ./02_Encrypt_Tablespace.sh

    ![](../images/TDE_016.PNG)

- And finally, try the side-channel attack again

        ./03_Search_Strings_Encrypted.sh

    ![](../images/TDE_017.PNG)

- You will see that all of the data is now encrypted!

---
**Note:** This lab has been executed against the pluggable database, PDB1.<br>
You can repeat this, manually, or by using Enterprise Manager, for PDB2 if you want more practice.

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
