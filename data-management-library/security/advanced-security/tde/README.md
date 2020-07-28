![](../../../images/banner_ASO.PNG)

# Oracle Transparent Data Encryption (TDE)

Version tested in this lab: `Oracle DB 19.5`

- **Before you begin**<br>
In order to be able to restore your database to a point in time prior to enabling TDE, you have to run the [Allow DB Restore](Allow_DB_Restore/README.md) lab first to generate a backup of your database.

- Now, you must first run [Create software Keystore](Create_Software_Keystore/README.md) lab before any other lab

- Then run the [Create Master Key](Create_Master_Key/README.md) lab

- At any point you can view the contents of your software keystore or the metadata associated with your keys in the database using [View software Keystore](View_Software_Keystore/README.md)

- It is also recommended to [Create the Autologin Wallet](Create_Autologin_Wallet/README.md) at this point in time

- Next, you can [Encrypt an existing Tablespace](Encrypt_Existing_Tablespace/README.md)

- And follow by implementing the [Encrypt ALL new Tablespaces](Encrypt_All_New_Tablespaces/README.md) lab to encrypt any new tablespace created and encrypted with the DB default key set earlier

<!-- - You can [Convert_Existing_Encrypted_Tablespace](Convert_Encrypted_TBS/README.md) -->

- **Optional:** Now, for more expertise you can do next the [Oracle Key Vault](../../Key_Vault/README.md) labs

- Finally, if you wish to restore to the point in time prior to enabling TDE, follow the steps in [Restore_Before_TDE](Restore_Before_TDE/README.md) lab

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
