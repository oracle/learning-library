# Publish Custom Image to OCI Marketplace

## Introduction
This lab will show you how to create an OCI marketplace compute based artifact from your custom image, and use it to create a private listing on marketplace exclusively dedicated to your LiveLabs workshop.

### Objectives
- Create Marketplace Artifacts
- Create Marketplace Listing

### Prerequisites
This lab assumes you have completed:
- Lab: 7-labs-create-custom-image-for-marketplace

## **STEP 1**: Create Marketplace Artifacts   
At this point, it's assumed that the test instance created in the previous lab has been successfully validated and can be submitted to OCI marketplace. This also assume that you have the required access for OCI Partner Portal. Proceed to OCI console to perform the next steps

1. Launch your browser to OCI Marketplace Partner Portal, then navigate to *"Compute > Instances"*

    ```
    URL: <copy>https://partner.cloudmarketplace.oracle.com/partner/index.html</copy>
    ```

2. Click on the 3rd icon on the left to access the Artifacts section

    ![](./images/create-artifact-1.png " ")

3. Click on *"Create Artifacts"*

    ![](./images/create-artifact-2.png " ")

4. Select *"OCI Compute Image"* from the dropdown, fill in the name, click on the search icon to lookup the custom image you created in the prior step, and click *"Create"*

    ![](./images/create-artifact-3.png " ")

5. Select the tenant, region, and compartment where your custom image was created, and select that image. It's assumed here that your tenant has been properly configured for marketplace integration. If not, click **"?"** at the upper right-hand corner to access the help page.

    ![](./images/create-artifact-4.png " ")

6. Scroll-down and check to confirm to confirm as indicated

    ![](./images/create-artifact-5.png " ")

7. Scroll-up and click *"Create"*  

    ![](./images/create-artifact-6.png " ")

8. Monitor creation progress.   

    ![](./images/create-artifact-6.png " ")

    *Note:* It can take 5 hours or more for the process to complete successfully. Upon completion you will receive an email notification. In case of failure, reach out to *#oci_marketplace_users* Slack channel

9. Confirm successful creation when status changes to *"Available"*

    ![](./images/create-artifact-6.png " ")

## **STEP 2**: Create Marketplace Listing   
1. Click on the 2nd icon on the top left to access the Listings section

    ![](./images/create-listing-1.png " ")

2. Select *"OCI Application Listing"* and Click *"Create"*  

    ![](./images/create-listing-2.png " ")

3. Fill in the details as indicated for *"App Name"*, *"Headline"*, and *"Categories"*, Click on *"Pricing Information"* and Select **Free**, then Click on *"Save"*

    ![](./images/create-listing-3.png " ")
    ![](./images/create-listing-4.png " ")

4. Download and save [LiveLabs icon](https://cloudmarketplace.oracle.com/marketplace/content?contentId=95549453) to your local drive, then Click on *"Click to upload an icon"*, select the downloaded file, and click *"Upload"*

    ![](./images/create-listing-icon-1.png " ")
    ![](./images/create-listing-icon-2.png " ")
    ![](./images/create-listing-icon-3.png " ")
    ![](./images/create-listing-icon-4.png " ")

5. On the section labelled **"App by Oracle"**, Click on *"Edit"* and fill in the short and long descriptions

    ![](./images/create-listing-desc-1.png " ")
    ![](./images/create-listing-desc-2.png " ")

6. Click on  **"App Install Package"** tab, provide a version name/ID, and Click on *"Save"* to create the version

    ![](./images/create-listing-version-1.png " ")

7. Scroll-down to the **"Configure OCI Compute Image"** section and Click on *"Edit"*

    ![](./images/create-listing-version-2.png " ")

8. Click on the search icon, select the artifact you created in the previous step, click on *"Save"*, then click on the **"App Listing"** tab

    ![](./images/create-listing-version-3.png " ")
    ![](./images/create-listing-version-4.png " ")
    ![](./images/create-listing-version-5.png " ")

9. Click on *"Submit"*

    ![](./images/create-listing-submit-1.png " ")

10. Provide a comment indicating the private listing nature, select the checkmark to confirm as shown, Click on *"Submit"*

    ```
    <copy>To be listed privately and exclusively for LiveLabs Workshops Platform</copy>
    ```

    ![](./images/create-listing-submit-2.png " ")

11. Review and Click on *"OK"*

    ![](./images/create-listing-submit-3.png " ")

12. The Listing is now submitted and pending approval by the Marketplace Team. Once approved the three dots ***(...)*** next to your listing icon will change to a green checkmark

    ![](./images/create-listing-submit-4.png " ")

13. Once the listing has been approved, click on the hamburger menu on the far right and select *"Publish as Private"*

    ![](./images/create-listing-publish-1.png " ")

14. It will take a few hours for the listing to be propagated to all OCI regions. An email notification will be sent out to you and the private URL will be listed as shown below.

    ![](./images/create-listing-done-1.png " ")

15. Review your published listing by clicking on the hamburger menu, the selecting *"View Listing"*

    ![](./images/create-listing-done-2.png " ")
    ![](./images/create-listing-done-3.png " ")

16. With the image fully published and Available in all OCI regions, click on **"App Install Package"** tab, select the appropriate version, and collect the 3 key details needed for creating ORM stacks or to support a *"green button"* image configuration in LiveLabs Management System.

  - Listing Version
  - Listing OCID
  - Image OCID

    ![](./images/get-listing-details-1.png " ")
    ![](./images/get-listing-details-2.png " ")

**This concludes this lab.**

## Learn More
* [Oracle Cloud Marketplace Partner Portal Documentation](https://docs.oracle.com/en/cloud/marketplace/partner-portal/index.html)
* [Oracle Cloud Marketplace Partner Portal Videos](https://docs.oracle.com/en/cloud/marketplace/partner-portal/videos.html)


## Acknowledgements
* **Author** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, February 2021
* **Contributors** - - -
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, March 2021
