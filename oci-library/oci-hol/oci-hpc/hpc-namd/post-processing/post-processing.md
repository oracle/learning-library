# Post-processing

## Introduction
In this lab, you will use Visual Molecular Dynamics (VMD) software to analyze the models for post-processing.

Estimated Lab Time: 5 minutes

## **STEP**: Post-processing

1. For post-processsing, you can use Visual Molecular Dynamics (VMD) software to analyze the models. Run the following commands to configure VMD:

    ```
    <copy>
    ./configure
    cd src
    sudo make install
    </copy>
    ```

2. If you are using vnc, launch vncserver and create a vnc password as follows:

    ```
    <copy>
    sudo systemctl start vncserver@:1.service
    sudo systemctl enable vncserver@:1.service
    vncserver
    vncpasswd
    </copy>
    ```

3. Start up a vnc connection using localhost:5901 (ensure tunneling is configured), and run the following commands to start up VMD:

    ```
    <copy>
    vmd
    </copy>
    ```

4. Open the apoa1 and stmv pdb files in /mnt/block/work/NAMD_models and start playing with your models.

## Acknowledgements
* **Author** - High Performance Compute Team
* **Contributors** -  Chris Iwicki, Harrison Dvoor, Gloria Lee, Selene Song, Bre Mendonca, Samrat Khosla
* **Last Updated By/Date** - Samrat Khosla, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/high-performance-computing-hpc). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.