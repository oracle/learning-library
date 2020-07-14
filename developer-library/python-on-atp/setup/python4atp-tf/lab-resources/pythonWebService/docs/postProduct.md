**Post Customer**

* **URL**

  /customers/:id

* **Method:**

  `POST`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

`               { 
                "PARENT_CATEGORY_ID": integer,
                "CATEGORY_ID": integer,
                "PRODUCT_NAME": string,
                "PRODUCT_STATUS": string,
                "COST_PRICE": float,
                "LIST_PRICE": float,
                "MIN_PRICE": float,
                "WARRANTY_PERIOD_MONTHS": integer,
                "EXTERNAL_URL": string,
                "ATTRIBUTE_CATEGORY": string,
                "ATTRIBUTE1": string ,
                "ATTRIBUTE2": string,
                "ATTRIBUTE3": string,
                "ATTRIBUTE4": string,
                "ATTRIBUTE5": string,
                "CREATED_BY": string,
                "CREATION_DATE": "date",
                "LAST_UPDATED_BY: string",
                "OBJECT_VERSION_ID": integer,
                "LAST_UPDATE_DATE": "date,
                "TWITTER_TAG": string
}
                `

* **Success Response:**

  * **Code:** 201 <br />

* * **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** ` {'message':'Customer does not exist'}`