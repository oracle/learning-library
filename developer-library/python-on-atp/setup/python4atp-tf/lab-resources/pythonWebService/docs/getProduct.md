**Show Customer**
----
  Returns json data about a single customer.

* **URL**

  /customers/:id

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

  None

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** 
    ```{
    "ATTRIBUTE1": "None",
    "ATTRIBUTE2": "None",
    "ATTRIBUTE3": "None",
    "ATTRIBUTE4": "None",
    "ATTRIBUTE5": "None",
    "ATTRIBUTE_CATEGORY": "None",
    "CATEGORY_ID": "1011",
    "COST_PRICE": "3.19",
    "CREATED_BY": "0",
    "CREATION_DATE": "2014-01-10",
    "EXTERNAL_URL": "https://objectstorage.us-ashburn-1.oraclecloud.com/p/V_9hOWx0e80XXBgLoSIrc3Zwv-FJ_DOYBlO594cebc8/n/natdcshjumpstartprod/b/AlphaOffice-images/o/1039-Write-Crayola_Markers.jpg",
    "LAST_UPDATED_BY": "0",
    "LAST_UPDATE_DATE": "2014-01-10",
    "LIST_PRICE": "10.0",
    "MIN_PRICE": "2.99",
    "OBJECT_VERSION_ID": "1",
    "PARENT_CATEGORY_ID": "1002",
    "PRODUCT_ID": "1039",
    "PRODUCT_NAME": "Crayola Original Markers - Broad Line, Classic Colors",
    "PRODUCT_STATUS": "AVAILABLE",
    "TWITTER_TAG": "Crayola",
    "WARRANTY_PERIOD_MONTHS": "6"
}```

 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** ` {'message':'Customer does not exist'}`

