![](../../../../images/banner_ASO.PNG)

# [Lab] TDE - Rekey the Master Key

--- 

You must create a master key for the container database before continuing. Each pluggable database must have their own master key as well (except for PDB$SEED). In this lab you will perform a rekey operation for the CDB and pluggable database, `PDB`.

Start this lab here:

    cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Rekey_Master_Key

To_rekey the container database TDE master key, run the following command:

    ./01_rekey_cdb_mkey.sh

To rekey a master key for the pluggable database, PDB1, run the following command:

    ./02_rekey_pdb_mkey.sh pdb1

If you want, you can do the same for PDB2.  This is not a requirement though. It might be helpful to show some databases with TDE and some without.

    ./02_rekey_pdb_mkey.sh pdb2

Now that you have a master key, you can begin encrypting tablespaces or column. 


---
Move up one [directory](../README.md)

Click to return [home](/README.md)
