![](../../../images/banner_NetEncrypt.PNG)

# [Lab] Native Network Encryption

In this lab we will use the **Native Network Encryption**.

- On your PC, open a **SSH session on DBSec-Lab VM** with your SSH Client

- Connect **as ORACLE** user

		sudo su - oracle

- Go to NNE directory

        cd $DBSEC_HOME/workshops/Database_Security_Labs/Network_Encryption/Native_Network_Encryption
        
- View your SQL*Net.ora file content

        ./01_view_sqlnet_ora.sh

    ![](images/NNE_001.PNG)
    
- Check if the network is already encrypted

        ./02_is_session_encrypted.sh

    ![](images/NNE_002.PNG)

- Run tcpdump on the traffic

        ./03_tcpdump_traffic.sh
    
    ![](images/NNE_003.PNG)

    ---
    **Note:** The output has been saved to tcpdump.pcap.  There are a lot of tools available to analyze pcap files. 
    
    ---
 
- Next, we will capture traffic across the wire for the Glassfish application.<br>
 Make sure you have a web browser window open to `http://<YOUR_DBSEC-LAB_VM_PUBLIC_IP>:8080/hr_prod_pdb1`
   
    - On your terminal windows, begin the capture script
 
            ./04_capture_empsearch_traffic.sh
    
    - On your Glassfish App, perform the the following steps:
        - Login to the HR Application as **hradmin** / **Oracle123**

            ![](images/NNE_009.PNG)

            ![](images/NNE_010.PNG)

        - Open **Search Employees**

            ![](images/NNE_011.PNG)

        - Click [**Search**]

            ![](images/NNE_012.PNG)

    - Go back to your terminal windows to see traffic content

        ![](images/NNE_004.PNG)

    - When you have seen the un-encrypted data, use `[Ctrl]+C` to stop the `04_capture_empsearch_traffic.sh` script

- Next, we will enable SQL*Net encryption with the `REQUESTED` value for `SQLNET.ENCRYPTION_SERVER`.<br>
To begin with, we use this option because it will allow non-encrypted connections to still connect. While this rarely has an impact, it is often important to do this so the change does not interfere with production systems that cannot encrypt between the client and the database. 

        ./05_request_nne.sh

    ![](images/NNE_005.PNG)

    ---
    **Note**: NNE stands for Native Network Encryption. The alternative is TLS certificates but those require user management and more configuration. 

    ---

- Now re-run the script to check if the session is encrypted. 

        ./06_is_session_encrypted.sh
    
    You should notice an additional line that says `AES256 Encryption service adapter for Linux`

    ![](images/NNE_006.PNG)

- Now re-run TCP Dump on the traffic

        ./07_tcpdump_traffic.sh

    ![](images/NNE_007.PNG)

    The `DEMO_HR_EMPLOYEES` table data is still queryable but when it shows up in tcpdump it shows up as 'junk' because the session is encrypted

- Now we will test the Glassfish application queries to see if they are encrypted
    - On your terminal window execute

            ./08_capture_empsearch_traffic.sh

    - In your browser, **logout and login** the Glassfish application at `http://<YOUR_DBSEC-LAB_VM_PUBLIC_IP>:8080/hr_prod_pdb1` to see what happens when we sniff this traffic

        ![](images/NNE_009.PNG)

        ![](images/NNE_010.PNG)

        ![](images/NNE_011.PNG)

        ![](images/NNE_012.PNG)

    - Now you can see that data is encrypted between our Glassfish application (JDBC Thin Client) and the database

        ![](images/NNE_008.PNG)

        ---
        **Note**: This works immediately (or after a refresh) because our Glassfish application creates a new connection for each query. A real application would probably need to be stopped and restarted to disconnect the existing application connections from the database.
    
        ---

    - When you have seen the encrypted data, use `[Ctrl]+C` to stop the `08_capture_empsearch_traffic.sh` script

- When you have completed the lab, you can return the Native Network Encryption to the default settings.

        ./09_remove_nne.sh

    ![](images/NNE_013.PNG)
<br>

---
**CONGRATULATIONS... YOU HAVE SUCCESSFULLY COMPLETED THIS EXCERCISE!**

---
Move up one [directory](../README.md)

Click to return [home](/README.md)
