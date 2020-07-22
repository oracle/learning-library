![](../../../images/banner_DV.PNG)

# [Lab] Enabling DB Vault

Enable Database Vault in the container and `PDB1` pluggable database.

- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd $DBSEC_HOME/workshops/Database_Security_Labs/Database_Vault/Enable_Database_Vault

- Start by enabling Database Vault in the container database.

        ./01_config_enable_dv_on_cdb.sh

    ![](../images/DV_001.PNG)

    ---
    **Note**: To enable DB Vault, database will be rebooted!

    ---
    
- Next, enable it on the pluggable database. For now, just enable it on pdb1.

        ./02_config_enable_dv_on_pdb.sh pdb1
    
    Now you will see a status like this:

    ![](../images/DV_002.PNG)
    
- Now, Database Vault is enabled in the container database as well as `PDB1`!<br>
<br>&nbsp;

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
