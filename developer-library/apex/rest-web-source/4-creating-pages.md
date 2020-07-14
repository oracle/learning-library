# Module 4 - Defining Pages 

In this module, you will learn how to utilize Web Source modules as the basis for creating reports and forms within the application. 

### **Part 1** – Use the Create Page Wizard

1. Return to the Application Home Page.     
    Click **Create Page**
    
    On the Create a Page dialog, click **Report**

    ![](images/4/create-rpt.png)

2. On the Create Page dialog, click **Report and Form**  

    ![](images/4/rpt-with-form.png)

3. In the Create Report with Form dialog, for Page Attributes, enter the following:
    - Report Page Name - enter **Employees**
    - Form Page Name - enter **Maintain Employee**
    - Form Page Mode - click **Modal Dialog**
    - Breadcrumb - select **Breadcrumb**
    
    Click **Next**

    ![](images/4/set-page.png)

4. On the Navigation Menu dialog, click **Create a new navigation menu entry**.     
    Click **Next**

    ![](images/4/set-nav.png)

5. On the Data Source dialog, enter the following:
    - Data Source - click **Web Source**
    - Web Source Module - select **REST EMP Source**
    
    Click **Next**

    ![](images/4/set-data-source.png)

6. On the Form Page dialog, for Primary Key Column, select **EMPNO (Number)**.      
    Click **Create** 

    ![](images/4/set-pk.png)

### **Part 2** – Improve the Report
The default column order will not be optimal when the page is generated. You can readily reorder the columns and save the report layout.

1. From Page Designer, click **Save and Run**  

    ![](images/4/go-runtime.png)

2. On the Login Page, enter your user credentials.

3. Review the Employees

    ![](images/4/runtime.png)

4. On the Employees report page, click **Actions**, click **Columns**  

    ![](images/4/go-columns.png)

5. On the Select Columns dialog, shuffle the columns such that EMPNO, ENAME, and DEPTNO are the
first three columns, by selecting the columns and using the **Top** arrow.      
    Click **Apply**  

    ![](images/4/set-columns.png)

6. You need to save the report layout so that it displays this way for all users.

    Click **Actions**, select **Report**, click **Save Report**  

    ![](images/4/go-save.png)

7. On the Save Report dialog, for Save (Only displayed for developers), select **As Default Report Settings**  

    ![](images/4/set-save.png)

8. On the Save Default Report dialog, click **Apply**

    ![](images/4/save-primary.png)

### **Part 3** – Update the Form Page
The form page for editing records also needs some improvement.

1. Click the edit icon on a row.
    The Form Page is displayed

    In the Developer Toolbar, click **Edit Page 5**.     
    Page Designer will be displayed for the current page.

    ![](images/4/go-pd.png)

    *{Note: The Developer Toolbar is only displayed when you run apps from App Builder, so is never visible to end users}*

2. The Employee Number (EMPNO) item is currently hidden, as it is defined as the primary key for the table. However, users should be able to enter a value when inserting a record.

    Within Page Designer, in the Rendering tab (left pane), click item **P5_EMPNO**

    In the Property Editor (right pane), enter the following:
    
    - Identification > Type - select **Number Field**
    - Label > Label - enter **Employee Number**

    ![](images/4/set-empno.png)

3. Employee Number should only be entered and should not be updated, as it is the primary key for the table. Therefore, you should make the item read only if displaying an existing record.

    In the Property Editor (right pane), with **P5_EMPNO** selected, enter the following:
    - Read Only > Type - select **Item is NOT NULL**
    - Read Only > Item - select **P5_EMPNO**

    ![](images/4/set-empno-ro.png)
    
4. The Job and Name items are currently defined as a Textarea, yet neither will be that large a value. Therefore, they should be changed to be a Text Field.

    In the Rendering tab (left pane), click item **P5_JOB**.        
    Hold the {Control} Key and click **P5_NAME**.
    
    In the Property Editor (right pane), for Identification > Type, select **Text Field**

    ![](images/4/set-job-name.png)

5. The order of the items should be improved. This can easily be achieved by dragging and dropping items in either the Rendering tree or the Layout.

    In the Rendering tree, click item **P5_ENAME**.      
    Drag **P5_ENAME** up to be under **P5_EMPNO**.  

    ![](images/4/drag-name.png)
    
6. In the Rendering tab (left pane), click item **P5_DEPTNO**.      
    Drag **P5_DEPTNO** up to be under **P5_ENAME**.
    
7. The Commission (COMM) item should be placed on the same line as Salary (SAL).

    In Layout (middle pane), select **P5_COMM**.        
    Drag it up next to **P5_SAL**   
    *{Note: Do not drop the item until a large dark yellow box appears to the right of the existing items.}*

    In the Toolbar, click **Save**

    ![](images/4/drag-comm.png)

### **Part 4** – Insert a Record

1. Navigate back to the Runtime environment
2. Refresh the browser
3. On the Employees report page, click **Create**

    On the Maintain Employee page, enter the following:
    
    - Employee Number - enter **1234**
    - Ename - enter **PETERS**
    - Deptno - enter **10**
    - Job - enter **SALESMAN**
    - Mgr - enter **7839**
    - Sal - enter **1500**
    - Comm - enter **500**
    - Hiredate - select any date
    
    Click **Create**

    ![](images/4/insert.png)

4. On the Employees report page, find the new record.

    ![](images/4/show-insert.png)

### **Part 5** – Update a Record

1. On the Employees report page, find **BLAKE**, and click the edit icon.

    On the Maintain Employee dialog, update the following:
    
    - Deptno - enter **40**
    - Sal, enter **3500** 

    Click **Apply Changes**

    ![](images/4/update.png)

2. On the Employees report page, review WARD.

    ![](images/4/show-update.png)

### **Part 6** – Delete a Record

1. On the Employees report page, find **TURNER**, and click the edit icon.

    On the Maintain Employee dialog, click **Delete**.
    On the delete confirmation dialog, click **Ok**.

    ![](images/4/delete.png)

2. On the Employees report page, review the records to ensure TURNER is no longer visible.

    ![](images/4/show-delete.png)

### **Summary**
This completes Module 4. You now know how to utilize a REST endpoint to develop a report and form to allow full CRUD operations. [Click here to navigate to Module 5](5-defining-lov.md)
