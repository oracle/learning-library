**Update Customer**

* **URL**

  /customers/:id

* **Method:**

  `PUT`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

`{
     "LAST_NAME": string 
 }`

* **Success Response:**

  * **Code:** 200 <br />

* * **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** ` {'message':'Customer does not exist'}`