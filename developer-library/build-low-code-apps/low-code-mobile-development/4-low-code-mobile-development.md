# Low Code, Microservice Mobile Development

## Before You Begin

### Introduction

In this lab you will use Oracle Visual Builder which is a cloud-based software development Platform as a Service (PaaS) and a hosted environment for your application development infrastructure. It provides an open-source standards-based solution to develop, collaborate on, and deploy applications within Oracle Cloud. You will build on the previous labs using the REST points exposed by the AlphaOffice application to OKE in Lab 300.

Estimated time: 45 minutes

### Objectives
- Create a Mobile Application.
- Access the REST services you deployed in Lab 300 on OKE.
- Deploy the mobile application to your phone (Android based).

### Prerequisites
- Successful completion of Lab 3 and creation of a REST service for products.

### Required Artifacts
- Use Chrome browser works best in it

*In addition to the workshop*, feel free to watch the walkthrough companion video by clicking on the following image:
[](youtube:X-B180moN-k)

## **STEP 1**: Configure Visual Builder Studio to create Mobile App

1. Click on the hamburger menu on top left , hover on **Platform Services**, and then click on **Developer**

    ![](images/step1/1.png " ")

2. Once the instance is ready open the instance by clicking on hamburger menu and then click on **Access Service Instance**

    ![](images/step1/2.png " ")

3. Click on hamburger menu, select your **Project** from the **Organization** and then click on **Environments**.

    ![](images/step1/3.png " ")

4. Click on **Create Enviornment**.
  
    ![](images/step1/4.png " ")

5. Give the name of Enviornment,such as appDevApp.
  
    ![](images/step1/5.png " ")

6. Click on **Add** to select the VBCS instance
        
    ![](images/step1/6.png " ")

7. Make sure Visual Builder is selected and then chose your Visual builder instance and then click **Add**
  
    ![](images/step1/7.png " ")

8. It will take few seconds for enviornment to get ready, once it is ready click on **Designer** tab

    ![](images/step1/8.png " ")

9. Click on **Create Workspace**

    ![](images/step1/9.png " ")

10. Select **New Visual Application**, enter a **Name**, check **Scratch repository**, select **appDevApp** for the Developement environment and click **Create Workspace**.

    ![](images/step1/10.png " ")

11. An initial page will show. Now you will begin to create the components used in the application.

    ![](images/step1/11.png " ")

## **STEP 2**: Create Service Connections

Service Connections are REST endpoints pointing to various services. In this step you will reference REST endpoints from the application deployment you created in Lab 300. We will create endpoints for GET, GET/{id}, POST.

1. Click on the **Service Connections** icon and then click **+** button to add new connection.

    ![](images/step2/1.png " ")

2. Select **Define by Endpoint**
  
    ![](images/step2/3.png " ")

3. Leave the Method as **GET**. From Lab 300 **Copy and Paste the URL** used to test the REST endpoint that retrieved all of the Product Catalog records. 

    **Note:**  In this example:  `http://150.136.0.174:8080/product/list` into the URL field. Leave the Action Hint at **Get Many**:

    ![](images/step2/4.png " ")

4. Click **Next**.

5. Select the **Test** tab and click **Send**. The request should return all of the records (shown in the Response). If successful, click the **Save as Example Response** button.

    ![](images/step2/5.png " ")

6. Click **Create**.

    ![](images/step2/6.png " ")

7. Click the **Endpoints** tab to see the created GET. Click **+ Endpoint** to add another.

    ![](images/step2/7.png " ")

8. Create another **GET** method with the PATH having a **suffix** of **/{id}**. Set the Action Hint dropdown to **Get One**.

    ![](images/step2/8.png " ")

9.  Click the **Test** tab. For the URL Parameter enter **1027**. Click **Send**. One record is returned with the PRODUCT_ID of `1027`. If successfull, Click the **Save as Example Response** button.

    ![](images/step2/9.png " ")

10. Click **Add**.

    ![](images/step2/10.png " ")

11. Create one more REST Endpoint for request info.
 
    ![](images/step2/1.png " ")

12. Select **Define by Endpoint**
  
    ![](images/step2/3.png " ")

13. Select **POST as method** and give the URL ending with **/user/request** and in Action Hint select **Create**, click **Next**.

    ![](images/step2/11.png " ")

14. Click on **Test** tab and copy the following JSON payload in body.

    ```
    <copy>
    {
      "request": {
        "product_id": "1040",
        "first_name": "ABC",
        "last_name": "XYZ",
        "email_address": "test @gmail.com ",
        "phone_number": "431 - 232 - 2212 ",
        "comments": "need more information regarding product 1027"
      }
    }
    </copy>
    ```

15. Click on Send button and if the response is 200, click on **Save as Example Request** and **Save as Example Response**. Click **Create**
   
    ![](images/step2/12.png " ")


## **STEP 3**: Import Mobile Application

1. First we will download the skeleton framework to create Mobile Application. Download from [here](https://objectstorage.us-ashburn-1.oraclecloud.com/n/natdcshjumpstartprod/b/spw-appDev-DevOps-files/o/alphaMobileAppSkeleton.zip)

2. Select the **Mobile Applications** icon on the left on side of the web page and then click **Upper Right-Hand menu** and select **Import**.

    ![](images/step3/1.png " ")

3. Drag the file which we just downloaded and then click **Import**

    ![](images/step3/2.png " ")

4. Click on Mobile Application and the select **main-start**

    ![](images/step3/3.png " ")

5. Make sure you are on  **Designer** tab and **Design** view. Here you will see the page. Currently is it blank.

    ![](images/step3/4.png " ")

6. Now drag and drop a **Heading** component right below the image field. Your screen should look like:

    ![](images/step3/5.png " ")

7. Your application should be in Design Mode:

    ![](images/step3/6.png " ")

8. Time to set some Properties. You can select the specific component who wish to set property values for by ether selecting from the Page Structure OR the display canvas. In some cases it will be easier to use one or the other...

9. Select the **Mobile Page Template** from the Page Structure pane and name it Products or Catalog anything you perefer. Which can be found under the **General** properties area on the right.
  
    ![](images/step3/7.png " ")

10. You'll notice the change does not take affect until you tab out of the Page Title field.

11. Click on the **Heading** field and set the text to:
  
    ```
    <copy>
    Products
    </copy>
    ```

12. ...leaving the Heading size to **H1**. You screen looks like:

    ![](images/step3/8.png " ")

13. Download a static image from here: [AlphaOffice Image](https://objectstorage.us-ashburn-1.oraclecloud.com/n/natdcshjumpstartprod/b/spw-appDev-DevOps-files/o/AlphaOfficeSupply.png). Click on this link and save the file locally.

14. Now, click on the **Image** component in the canvas and click the **Data** tab in the Properties section. 

    ![](images/step3/9.png " ")

15. Click on the **Drop an image here...** box and upload the static image; **AlphaOfficeSupply.PNG** you just downloaded:

    ![](images/step3/10.png " ")

16. The image is uploaded. If it doesn't display right away on the canvas click the **Refresh icon**.

    ![](images/step3/11.png " ")

17. Your screen should now look like:

    ![](images/step3/12.png " ")

## **STEP 4**: Configure Main page with all products information

1. Click on Variables and then click on **+Variable** to create new variable. Here we are creating variable to store all the product information we fetch from the rest endpoint. Give some meaningful name like getProducts and make sure type is **Service Data Provider** and then click **Create**

    ![](images/step4/1.png " ")

2. Once the variable is created on the left hand panel click **Select Endpoint**

    ![](images/step4/2.png " ")

3. Under Service Connections select the get /list which will fetch all the products.

    ![](images/step4/3.png " ")

4. We already imported a variable type with the application so we can click on **Use Existing Type** and  select **getProducts** and then click **Finish**.

    ![](images/step4/4.png " ")

5. Once endpoint is configured variable will look something as below image. We need to provide **Key Attributes** which is **product_id** in this variable.

    ![](images/step4/5.png " ")

6. Go to **Designer Tab** and here you can now see the products are displayed.

    ![](images/step4/6.png " ")


## **STEP 5**: Configure details page to show product details

1. In this step we are configuring product details page where we can see information of single product. For that we need to configure the page with REST Endpoint to fetch the single record.

2. Click on **main-get-id-detail** under pages Then click on **Actions** and lastly click on **loadGetidChain**

    ![](images/step5/1.png " ")

3. There click on **Call REST Endpoint** and finally click on **Select Endpoint**.

    ![](images/step5/2.png " ")

4. Click on **Service Connections** and select product endpoint with **get /{id}**. Click Select

    ![](images/step5/3.png " ")

5. Once endpoint is configured, you will see the details. Here we need to map Input Parameter ID which is tell our REST Endpoint which product we want information about.

6. Click on **Assign** button aligned with Input Paramaters

    ![](images/step5/4.png " ")

7. Drag getIdId from Sources to id in Target. Click **Save**
  
    ![](images/step5/5.gif " ")

8. At this point to test the application so far, click on Play button in Navigation Bar 

    ![](images/1.png " ")

## **STEP 6**: Configure request more info page to submit product information request

1. In this Step we will configure request more info page.

2. If you click on **main-request-info** and then **Actions** tab, click on **SubmitButtonActionChain**.

    ![](images/step6/1.png " ")

3. Click on **Call REST Endpoint** and then on right panel click **Select Endpoint**
  
    ![](images/step6/2.png " ")

4. Click on **Service Connections** and select **POST /request** endpoint.
  
    ![](images/step6/5.png " ")

5. Once endpoint is configured, we need to set the body for POST method. Under Parameters click **Assign**

    ![](images/step6/6.png " ")

6. Drag and drop contactDetails from Source to Body in Target. Click **Save**

    ![](images/step6/7.gif " ")


## **STEP 7**: Test

1. Now let's test the app to make sure everything works fine. Click on Play button in Navigation Bar 

    ![](images/1.png " ")

2. In Home page you should be able to see all the products. Click on any product to show the detail page.

    ![](images/step7/1.png " ")

3. You should be able to see the product details. Click on **Request More Info** button.
  
    ![](images/step7/2.png " ")

4. Fill out the form, we have First name and email markes as required if you try to submit it empty it will throw error. You can try leaving empty. Once form is filled click **Submit**

    ![](images/step7/3.png " ")

5. If the form is submitted successfully, we will get notification and it will navigate to previous page which is details page.
  
    ![](images/step7/4.png " ")

## **STEP 8**: Save the app using Git

- From the navigation bar, click on git master, and form dropdown select push.
    
    ![](images/step8/1.png " ")

- Write the commit message and then click on **Push to Git**

    ![](images/step8/2.png " ")

- To see the changes go back to your Visual Builder instance and click on Git in left panel. Make sure you selected appropriate git repository to see the changes you pushed.

    ![](images/step8/3.png " ")


**This completes the Lab!**

**You are ready to proceed to** *Lab 5*

## Acknowledgements

- **Authors/Contributors** - Varun Yadav
- **Last Updated By/Date** - October 22, 2020
- **Workshop Expiration Date** - May 31, 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.