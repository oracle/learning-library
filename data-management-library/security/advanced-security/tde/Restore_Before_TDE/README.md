![](../../../../images/banner_ASO.PNG)

# [Lab] TDE - Restore Before TDE

Only if you have followed the steps in [Allow_DB_Restore](../Allow_DB_Restore/README.md) you can run the following steps to restore this DB to it's state before implementing TDE.


- Open a SSH session on your DBSec-Lab VM as Oracle User

        sudo su - oracle

- Go to the scripts directory

        cd /home/oracle/DBSecLab/workshops/Database_Security_Labs/Advanced_Security/TDE/Restore_Before_TDE
    
- First, execute this script to restore the pfile

        ./01_restore_init_parameters.sh

- Second, restore the database (this may take some time)

        ./02_restore_db.sh

- Third, delete the associated wallet files

        ./03_delete_wallet_files.sh

- Finally, start the container and pluggable databases

        ./04_start_db.sh

- This should have restored your database to it's pre-TDE state

- Verify the initialization parameters don't say anything about TDE

        ./05_check_init_params.sh

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
