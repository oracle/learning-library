# Unit 6: Managing and Customizing Interactive Reports

This exercise includes two hands-on-labs.

**HOL 6-1: Using an Interactive Report**: In this lab, you customize and use an interactive report as an end user.

**HOL 6-2: Customizing an Interactive Report as a Developer**: In this lab, as a developer, you customize an interactive report for your end users.

Both these hands-on-labs utilize the Hardware application that you created in HOL 5-2.


## HOL 6-1: Using an Interactive Report

1.  First, you run the Hardware application. To do this, navigate to **Application Builder**. In the report, click the **Run** button for **Hardware**.
    ![1a](images/hol06/image3.png)

2.  In the navigation menu, click **Hardware Interactive Report**.

3.  You do not want to display the Id and Form Factor columns in the report. Also, you want the Purchase Date column to display just before the Purchase Price column. Perform the following steps:


    a)  Click **Actions** and select **Columns**.
    ![1b](images/hol06/image4.png)

    b)  The Select Columns dialog appears. The columns on the right are displayed, and the columns on the left are hidden. Select **Id** and **Form Factor** in Display in Report group, and click the **Remove** icon.</br>
    ![1c](images/hol06/image5.png)

    c)  You can reorder the displayed columns using the arrows on the far right. Select **Purchase Date** in the Display in Report group, and click the **Down** arrow twice. Then, click **Apply**.</br>
    ![1d](images/hol06/image6.png)

    d)  The changes you made to the interactive report display are reflected now.</br>
    ![1e](images/hol06/image7.png)


4.  You want to create filters on the report. First, you want to filter the report to display rows which meet the criteria Purchase Price &gt;= 5330. Within these filtered results, you then create another filter to display rows with Cpu Type is Pentium III. Perform the following steps:


    a)  Click **Actions** and select **Filter**. </br>
    ![2a](images/hol06/image8.png)

    b)  For Filter Type, select **Column**.
    For Column, select **Purchase Price**, for Operator, select **&gt;=** and select **5330** from the Expression list.
    Notice that this list of values for Expression is determined automatically, based on all the values in the Purchase Price column.
    Then, click **Apply**.
    ![2b](images/hol06/image9.png)

    c)  The filter is applied now. You can have more than one filter on a report. If you decide that you want to disable a particular filter, you can click the check box to disable the filter.
    In this lab, you want to add another filter on the Cpu Type column.
    Click the **Actions** menu, and select **Filter**.
    ![2c](images/hol06/image10.png)

    d)  Select **Cpu Type** for Column, select **=** for Operator and select **Pentium III** from the Expression list.
    Click **Apply**.
    ![2d](images/hol06/image11.png)

    e)  Notice that two filters are applied now. The rows displayed are fewer now because they are only the rows that meet both the filter criteria. You can remove each filter by clicking the Remove Filter icon, next to the filter you want to remove.
    Click the **Remove Filter** icon next to both the filters.
    ![2e](images/hol06/image12.png)


5.  Both the filters are now removed, and you see that all the rows are displayed. You can also create a row filter.


	a)  Click **Actions**, and select **Filter**.
	    ![3a](images/hol06/image13.png)
	
	b)  You want to create a filter which selects a row when both the following conditions are true:
	    *Cpu Type = 'Pentium III'
	    Purchase Price &gt;= 5330*
	    Select **Row** for Filter Type.
	    Click **Cpu Type** under Columns and then click **=** from Functions / Operators. Enter **'Pentium III'**.
	    Click **AND** under Functions / Operators. Click **Purchase Price** under Columns and then click **&gt;=** under Functions / Operators. Enter **5330**.
	    Click **Apply**.
	    ![3b](images/hol06/image14.png)
	
	c)  The row filter is applied now. Click the Remove Filter icon to remove the filter.
	    ![3c](images/hol06/image15.png)


6.  You want to sort the report on the Purchase Price column.


	a)  Select **Actions &gt; Data &gt; Sort**. </br>
	    ![4a](images/hol06/image16.png)
	
	b)  Select **Purchase Price** for Column and click **Apply**. </br>
	    ![4b](images/hol06/image17.png)
	
	c)  The report is now sorted in the ascending order of Purchase Price.
	    **Note**: The sort indicator is located next to the columns that are sorted.
	    The arrow indicates whether it is in ascending or descending order. To change the sort to descending order, you can click on the sort ascending icon in the header for Purchase Price and it will change to sort descending. </br>
	    ![4c](images/hol06/image18.png)


7.  Create an aggregation against the Purchase Price column. You want to display the sum of the purchase price.


	a)  Select **Actions &gt; Data &gt; Aggregate**. </br>
	    ![5a](images/hol06/image19.png)
	
	b)  In the Aggregate dialog, select **Sum** for Function, **Purchase Price** for Column. Click **Apply**.</br>
	    ![5b](images/hol06/image20.png)
	
	c)  The aggregate function is applied on the column. Notice that the sum of purchase price is displayed at the end of the report under the column.
	    ![5c](images/hol06/image21.png)
	


8.  In the report, you want to include purchase price calculated with tax. The computation you want to make is Purchase Price \* 1.05. You create a computed column in the interactive report.



	a)  Select **Actions &gt; Data &gt; Compute**. </br>
	    ![6a](images/hol06/image22.png)
	
	b)  The Compute dialog appears.
	    For Column Heading, enter **Price with Tax** and select **\$5,234.10** for Format Mask.
	    For Computation Expression, click **Purchase Price** under Columns. Click **\*1.05** under Keypad.
	    Click **Apply**.
	    ![6b](images/hol06/image23.png)
	
	c)  The new computed column Price with Tax now appears in the report.
	    ![6c](images/hol06/image24.png)


9.  Create a Control Break on the Cpu Type column.


	a)  Select **Actions &gt; Format &gt; Control Break**. </br>
	    ![7a](images/hol06/image25.png)
	
	b)  In the Control Break dialog, select **Cpu Type** for Column, and click **Apply**. </br>
	    ![7b](images/hol06/image26.png)
	
	c)  The control break is applied now. Notice that the aggregation that you created in a previous step appears at the end of each control break.
	    ![7c](images/hol06/image27.png)
	


10.  You want to highlight those rows with Price with Tax values less than \$2300. You add the highlighting to rows while continuing with the control break that you created in the previous step.



a)  Select **Actions &gt; Format &gt; Highlight**. </br>
    ![8a](images/hol06/image28.png)

b)  In the Highlight dialog, enter **Price with Tax less than \$2400** for Name.
    Select **yellow** for Background Color and **red** for Text Color.
    For Highlight Condition: Select **\*\*Price with Tax** column, and **&lt;** Operator. Enter **2400** for Expression.
    Click Apply.
    ![8b](images/hol06/image29.png)

c)  Notice that the rows that meet the condition are highlighted now.
    ![8c](images/hol06/image30.png)



11.  In your interactive report, you want to include a Chart to display the total Price with Tax for each Cpu Type. Your interactive report should include both the Report and Chart views to toggle.



a)  Select **Actions &gt; Chart**. </br>
    ![9a](images/hol06/image31.png)

b)  In the Chart dialog, select / enter the following:

-   Chart Type: **Horizontal Column**

-   Label: **Cpu Type**

-   Value: **\*\*Price with Tax**

-   Function: **Sum**

-   Axis Title for Label: **Cpu Type**

-   Axis Title for Value: **Price with Tax**

 Click **Apply**.
 ![9b](images/hol06/image32.png)

c)  The chart is created. Toggle between the View Chart and View Report.
    ![9c](images/hol06/image33.png)

d)  You want to remove the control break and the highlighting. Click the X icon for both the filters.
    ![9d](images/hol06/image34.png)


12.  Create a Group By report to display each Cpu Type with the total purchase price.


	
a)  Select **Actions &gt; Group By**.</br>
    ![10a](images/hol06/image35.png)

b)  In the Group By dialog enter / select:

-   Group By Column: **Cpu Type**

-   Function: **Sum**

-   Column: **Purchase Price**

-   Label: **Total Price**

-   Format Mask: **\$5,234.10**

   Select the **Sum** check box and click **Apply**.
  ![10b](images/hol06/image36.png)

c)  The Group By report is created. You also see the sum of the purchase price. Notice that the icon for View Group By is also added.
    ![10c](images/hol06/image37.png)

d)  Click the **X** to the right of Edit Group By to remove the filter.



13.  You want to display the count of each Cpu Type that are available with each department. The results should be in a crosstab format. Create a Pivot Report.



a)  Click **Actions &gt; Pivot**.</br>
    ![11a](images/hol06/image38.png)

b)  In the Pivot dialog enter / select:

-   Pivot Column: **Cpu Type**

-   Row Column: **Department Id**

-   Functions: **Count**

-   Column: **Cpu Type**

  Click **Apply**.

  ![11b](images/hol06/image39.png)

c)  The Pivot report is displayed and a View Pivot icon is created.
    ![11c](images/hol06/image40.png)



14.  You want to save the report with all the customization.



a)  Select **Actions &gt; Report &gt; Save Report**.</br>
    ![12a](images/hol06/image41.png)

b)  Enter **My Report** for Name and click **Apply**.



15.  A drop down list automatically appears with the report you just created being selected. You can view the default primary report.
    You want to reset the Primary Report back to the default settings and remove any customizations that you have made so far.


a)  Select **Primary Report** from the Reports drop down list. The primary report is now displayed. You can make any changes to this report and it will not be reflected in the 'My Report' private report you just created. </br>

b)  Select **Actions &gt; Reset**.</br>
    ![13a](images/hol06/image42.png)

c)  In the Reset dialog, click **Apply**.</br>
    ![13b](images/hol06/image43.png)

d)  From the Reports drop down list, select **My Report**.
    ![13c](images/hol06/image44.png)



16.  You want to download the customized report as a CSV.


a)  Select **Actions &gt; Download**. </br>
    ![14a](images/hol06/image45.png)

b)  In the Download dialog, select **CSV**.</br>
    ![14b](images/hol06/image46.png)

c)  The report is now downloaded as a CSV. </br>
    ![14c](images/hol06/image47.png)



17.  You want to make some more customization to your interactive report. From the Reports drop down list, select **Primary Report**.
     ![16a](images/hol06/image48.png)

18.  To customize the report, you now use the column heading menu instead of using the Actions menu. The report is currently sorted in ascending order of Purchase Price. You want to the report to be sorted in the descending order of Department Id.


	
a)  Click the **Department Id** header and select **Sort Descending**.
    ![17a](images/hol06/image49.png)

b)  The report is now sorted in the descending order of Department Id.
    ![17b](images/hol06/image50.png)



19.  You do not want the Id and Form Factor columns in the report.


a)  Click the **Id** header and select **Hide Column**.</br>
    ![18a](images/hol06/image51.png)

b)  Click the **Form Factor** header and select **Hide Column**.</br>
    ![18b](images/hol06/image52.png)

c)  Your report now looks like:
    ![18c](images/hol06/image53.png)


20.  Create a control break on the Department Id.

a)  Click the **Department Id** header and select **Control Break**.</br>
    ![19a](images/hol06/image54.png)

b)  The control break is now applied.
    ![19b](images/hol06/image55.png)


21.  You want to save the customizations made from step 18 through 20. You save the report as a Named Report.


a)  Select **Actions &gt; Report &gt; Save Report**.

b)  The Save Report dialog appears. For Save, select **As Named Report** and enter **Departments Hardware Report** for Name. Click **Apply**.
    ![20a](images/hol06/image56.png)

c)  The report is saved and is now available in the Reports drop down list.
    ![20b](images/hol06/image57.png)



22.  You want to reset the primary report to default settings now.

a)  From the Reports down list, select **Primary Report**.

b)  Select **Actions &gt; Report &gt; Reset**.

c)  In the Reset dialog, click **Apply**.

d)  The primary report is now restored to default settings. The customizations you made to your private reports are available.
    ![21](images/hol06/image58.png)


## HOL 6-2: Customizing an Interactive Report as a Developer

In this lab, you edit an interactive report in page designer and customize it for end users.

1.  First, view the interactive report in page designer. In the Developer Toolbar, click **Edit Page 2**.
    ![22a](images/hol06/image59.png)

2.  You do not want the Id and Form Factor columns to be displayed in the interactive report for end users. Modify the report source query.



	a)  In the page designer, under **Rendering &gt; Regions**, select **Hardware Interactive Report**. In the property editor, locate **Source &gt; SQL Query**.
	    ![22b](images/hol06/image60.png)
	
	b)  Copy and paste the following SQL in to SQL Query.
	
	 
	      select SERIAL,
    	  
    	  CPU_TYPE,
    	  
    	  CPU_SPEED,
    	  
    	  PURCHASE_DATE,
    	  
    	  BRAND,
    	  
    	  MODEL,
    	  
    	  PURCHASE_PRICE,
    	  
    	  DEPARTMENT_ID
    	  
    	  from HARDWARE
    	  
	
	c)  Click **Save**. Then, click **Save and Run Page**.
	
	d)  Your interactive report now looks like:
	    ![22c](images/hol06/image61.png)



3.  When the end users click an edit icon for a specified row, they should be directed to a page which shows the column values for that row. The interactive report currently does not have a link column. Modify your interactive report to have a link to single row view.


	a)  Under Rendering, navigate to **Hardware Interactive Report** and select **Attributes**. </br>
	    ![23a](images/hol06/image62.png)
	
	b)  The attributes are now listed in the property editor. Under Link, for Link Column, select **Link to Single Row View**. Click **Save**. Then, click **Save and Run Page.** </br>
	    ![23b](images/hol06/image63.png)
	
	c)  In the report, click the edit icon (pencil) for any row.
	    ![23c](images/hol06/image64.png)
	
	d)  The single row view is displayed. Click **Report View** button to return to the report.
	    ![23d](images/hol06/image65.png)



4.  The current pagination type of the interactive report is Row Ranges X to Y. You want this to be changed for the end users’ display of the report.
    Under Rendering, navigate to **Hardware Interactive Report** and select **Attributes**.
    In the property editor, locate **Pagination**. 
    For Type, select **Row Ranges X to Y of Z**. </br>
    ![24](images/hol06/image66.png)

5.  You want to customize the display of Search Bar. End users should be able to select the display of desired number of rows per page.
    
    In the property editor, locate Search Bar. For Rows Per Page Selector, select **Yes**.
    Enter **10** for Maximum Rows Per Page. </br>
    ![24a](images/hol06/image67.png)


6.  Currently your interactive report allows end users to save the report as private. However, you also want to make sure that they can save a report as public. Enable this option in the Actions menu.
    In the property editor, locate **Actions Menu**. For Save Public Report, select **Yes**. </br>
    ![24b](images/hol06/image68.png)

7.  You want to disable the Email and RTF formats in the Download option of the Actions menu.
    In the property editor, navigate to **Download**. Deselect **Email** and **RTF** download formats. </br>
    ![24c](images/hol06/image69.png)

8.  Now that you finished the customization for end users, click **Save**. Then, click **Save and Run Page**.

9.  Notice that the row selector and the new pagination type are available on the report.
    ![24d](images/hol06/image70.png)

10.  Select **Actions &gt; Report &gt; Save Report**.

11.  The Save Report dialog displays. Notice that the Public check box is now available.
    For Save, select **As Named Report**, enter **Departments Public Report** for Name. Select the **Public** check box and click **Apply**.
    ![24f](images/hol06/image71.png)

12.  This report is now saved as a public report and is available in the Reports drop down list.
    ![24g](images/hol06/image72.png)

13. Click **Actions &gt; Download**.

14. Notice that the Email and RTF formats are no longer available. Click **Cancel**. </br>
    ![24i](images/hol06/image73.png)

15. From the Reports drop down list, select **Primary Report**.


----------

![Snap3.jpeg](images/hol06/image74.png)
