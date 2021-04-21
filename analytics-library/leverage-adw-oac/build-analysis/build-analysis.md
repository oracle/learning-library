# Building simple Interactive Analysis

## Introduction

In this lab, you will start creating your first simple interactive analysis, use filters, canvases and basically further investigate why we are losing customers from mobile phones.

_Estimated Lab Time_: 20 minutes

![Build Analysis](../build-analysis/images/build-analysis.png)

### Objectives

- Start your first simple interactive analysis

### Prerequisites

* An Oracle Cloud Free Tier or Paid account
* You should have completed  
    * Lab 1: Provisioning your Autonomous Database instance
    * Lab 2: Provisioning your Oracle Analytics Cloud instance
    * Lab 3: Connecting OAC to ADW and adjusting Data Set properties
    * Lab 5: Gaining Insights with Visual Data Dialog
    * Lab 6: Monitoring and Ad-hoc scaling up ADW activity for optimal OAC experience

## **STEP 1**: Start your first analysis

Lets Start from the previous project and clean up the report a bit.

1.  Remove **VALUE** from Grammar Pane Value (Y-Axis).  
Hover the mouse over the **VALUE** and click the 'x' sign.

    ![Remove Value](../build-analysis/images/remove-valuesmall.png)

2.  **Add Trend Line**.  
In the Properties Pane select the **Analytics** **icon** and double-click **Add Trend Line**.

    ![Add Trend Line](../build-analysis/images/add-trendlinesmall.png)

3.  **Rename** Canvas.  
Right-click the canvas tab and select  **Rename**.

    ![Rename Canvas](../build-analysis/images/rename-canvassmall.png)

4.  Rename the canvas as **Overview**.  
Type in **Overview** and Click on the 'blue' check mark.

    ![Rename Canvas](../build-analysis/images/canvas-overview.png)

5.  **Duplicate** Canvas.  
Right-click the canvas tab and select  **Duplicate**.  
This adds a copy of the selected canvas to the project’s row of canvas tabs.

    ![Duplicate Canvas](../build-analysis/images/duplicate-canvassmall.png)

6.  Lets filter on Mobile Phones.   
Right Click **Mobile Phones** Category and select **Keep Selected**.  
That keeps only the selected members and remove all others from the visualization and its linked visualizations.

    ![Keep Selected](../build-analysis/images/keepselected-mobilephone.png)

7.  Move **Channel** to Color.  
Drag **CHANNEL** from Trellis Rows section and Drop it to **Color** section.

    ![Channel to Color](../build-analysis/images/channeltocolorsmall.png)

8.  Lets **Remove** the trend line for the sake of simplicity.  
Go Analytics Property Pane > Trend and click x.

    ![Remove Trend Line](../build-analysis/images/remove-trend.png)

9.  Lets **Drill** on Direct Channel to SUB\_CATEGORY.  
Hover the mouse on Channel Direct
Right Click > **Drill to Attribute/Hierarchy** and select Data Elements > SUB\_CATEGORY.  
This Drill to [Attribute Name] to directly drill to a specific attribute within a visualization.

    ![Drill To](../build-analysis/images/channeldirect-drillto.png)  
    ![Drill To Subcategory](../build-analysis/images/channeldirect-drilltosubcategorysmall.png)

10.  Lets look at the results for 'Customers by Sales Week and Subcategory'.

     ![Customers by Sales Week and Subcategory](../build-analysis/images/channeldirect-drilltosubcategoryimg.png)

11.  Lets analyze customers across various sub categories and choose the **Create Best Visualization** option.  
Go to **Data Panel**,  Select **# Customers**, press CTRL key and Select  **SUB\_CATEGORY**; Right Click and select **Create Best Visualization**  
A visualization is automatically created on the canvas, and the best visualization type is selected based on the preconfigured logic. The selected data element is also positioned on a specific area of the Grammar Panel.

     ![Create Best Visualization](../build-analysis/images/createbestviz-customerssubcategory.png)

12.  The system decided that Bar Chart was the best viz type to visualize this information.

     ![Customers by Sales Week and Subcategory](../build-analysis/images/createbestviz-customerssubcategory2.png)

13.  Changing the chart type is very easy.  
Click on Grammar Pane Visualization type  and select **Donut** chart.

     ![Change Chart Type](../build-analysis/images/customerssubcategory-donut.png)

14.  Move **SUB_CATEGORY** from **Category** section to **Color** section.

     ![Subcategory to Color](../build-analysis/images/customerssubcategory-donut2.png)

15. Chart properties can be modified here.  
Go to **Property Pane**, **Values** tab and change **Data Labels** from Percent to **Percent**, **Value** and **Label**.

     ![Change Data Labels](../build-analysis/images/customerssubcategory-donut3.png)

16.  **Change** Visualization from Donut to **Treemap**.  
Click on Grammar Pane Visualization type  and select **Treemap** chart.

     ![Treemap](../build-analysis/images/customerssubcategory-treemap.png)

17.  Remove legend from the Treemap Visualization.  
Go **Property Pane**, click **General** tab, **Legend** element and select **None**.

     ![Legend None](../build-analysis/images/change-legendtonone.png)

18.  Change back to **Donut**.
Click on Grammar Pane Visualization type  and select **Donut** chart again.
     ![Donut](../build-analysis/images/customerssubcategory-donut4.png)  
     > notice there is no legend displayed this time

19. Use a **Visualization** **as a Filter**.  
You can configure a visualization to filter other visualizations on the canvas.  
Select Donut visualization, Right Click and select **Use as Filter**.
     ![Use as Filter](../build-analysis/images/customerssubcategory-donut-useasfilter.png)

20. Experiment with Visualization as a Filter.  
Click on a different slice of the Donut visualization and notice the change in the first visualization.
     ![Use as Filter](../build-analysis/images/customerssubcategory-donut-useasfilter2.png)

21. Remove Use as Filter.  
Select the Donut Visualization, Right Click and deselect **Use as Filter**.
     ![Remove Use as Filter](../build-analysis/images/remove-useasfilter.png)

22. Delete **CHANNEL** Filter.  
Go to the **Filter Menu**, hover over CHANNEL, Click on the small down arrow and Select **Delete**.
     ![Donut](../build-analysis/images/remove-channelfilter.png)

23.  Rename the canvas as **Phones**.  
Type in **Phones** and Click on the 'blue' check mark.

     ![Rename Canvas](../build-analysis/images/rename-canvasphones.png)![Rename Canvas](../build-analysis/images/rename-canvasphones2.png)

24.  **Duplicate** Canvas.  
Right-click the canvas tab and select  **Duplicate**.  
This adds a copy of the selected canvas to the project’s row of canvas tabs.

     ![Duplicate Canvas](../build-analysis/images/duplicate-canvassmall.png)

25. Remove Use as Filter.  
Select the Donut Visualization, Right Click and deselect **Use as Filter**.
     ![Remove Use as Filter](../build-analysis/images/remove-useasfilter.png)

26. Lets filter out the data to those sub categories where we are losing maximum customers - iPhones and Android phones.  
Select **SUB_CATEGORY** from Data Pane and Drag and Drop it to **Filter area** .
     ![Filter Subcategory](../build-analysis/images/filter-subcategory.png)

27. Select Android Phone and iOS Phones.  
Click **Android Phone** and **iOS Phones** (they will be moved to **Selections** tab). Click anywhere in Filter area.

     ![Filter Phones](../build-analysis/images/filter-subcategoryandroidios.png)

28. Filter **CHANNEL**.  
Go to Data Pane, select **CHANNEL** and drop it to Filter area.
     ![Filter Channel](../build-analysis/images/filter-channel.png)

29. Select **Direct** Channel.  
Click **Direct** (there will be moved to **Selections** tab). Click anywhere in Filter area..
     ![Filter Direct](../build-analysis/images/filter-channeldirect.png)

30. Delete **CHANNEL** Filter.  
Go to the **Filter Menu**, hover over CHANNEL, Click on the small down arrow and Select **Delete**.
     ![Donut](../build-analysis/images/remove-channelfilter.png)


You have just finished learning how to create your first analysis, use filters and building new canvases by reusing the previous content.

You may now [proceed to the next lab](#next)

## Want to Learn More?

* Free [Udemy: Modern Data Visualization with Oracle Analytics Cloud](https://www.udemy.com/augmented-analytics/), Section 2: Build Your First Data Visualization Project with Oracle Analytics

## **Acknowledgements**

- **Author** - Lucian Dinescu, Product Strategy, Analytics
- **Contributors** -
- **Reviewed by** - Shiva Oleti, Product Strategy, Analytics
- **Last Updated By/Date** - Lucian Dinescu, April 2021