**Delete Customer**

* **URL**

  /customers/:id

* **Method:**

  `DELETE`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

    None

* **Success Response:**

  * **Code:** 200 <br />

* * **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** ` {'message':'Customer does not exist'}`