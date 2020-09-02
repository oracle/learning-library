![](../../../../images/banner_ASO.PNG)

# [Lab] TDE - View Software Keystore

To view the software keystore you first need to have a keystore. Follow the labs in [Create_Software_Keystore](../Create_Software_Keystore/README.md) for instructions.
.<br><br>

- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/View_Software_Keystore

- Once you have a keystore, you can run either of these scripts.<br>
You will notice there are multiple copies of the `ewallet.p12` file.<br>
Every time you make a change, including create or rekey, the `ewallet.p12` file is backed up.<br>
You will also see the contents of the wallet file by using `orapki`

    - View the OS files related to the keystore

            ./01_view_wallet_on_os.sh

      ![](../images/TDE_008.PNG)

    - View the keystore data in the database

            ./02_view_wallet_in_db.sh

      ![](../images/TDE_009.PNG)

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
