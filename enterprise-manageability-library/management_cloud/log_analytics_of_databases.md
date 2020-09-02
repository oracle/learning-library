![](media/rdwd-laheader.png)  

**DATABASE TROUBLESHOOTING & ROOT-CAUSE ANALYSIS using Log Analytics** 
================================================================

In these hands-on lab activities, learn how to troubleshoot issues by searching log files leveraging pre-built machine learning algorithms, in-context and interactive dashboards to quickly pin-point problem root-cause using Oracle Log Analytics.  

=============================================================

### Contents

**Lab Activity 1:** Analyzing Logs to Diagnose Database Issues

**Lab Activity 2:** Application Topology Approach to Locate Root Cause

**Lab Activity 3:** Use Machine Learning (Cluster and Cluster Compare) to Find Root
Cause

**Lab Activity 4:** Machine Learning (Link) Approach to Find Root Cause – (Optional)

<br>**Lab Activity 1: Analyzing Logs to Diagnose Database Issues**
======================================================================


User Persona: DBA, DevOps, ITOps
--------------------------------

**Scenario Details**

Users want to use OMC Log Analytics to troubleshoot database issues to find
possible root cases through logs. **Note** use Google Chrome to perform activities in this lab.

**Task**

Allowing users to get insight about their application by drilling down into
database logs and any host/infrastructure related logs

**Learner Goal**

You will learn how you can use Oracle Management Cloud Log Analytics to gain
visibility to your data

**Value Proposition**

Logs have very valuable information that would be important in troubleshooting
or finding a root cause

**Duration**: >10 mins as this lab can further cover  query language and comparions which are more than just click and go. 

**Log in to Oracle Cloud to perform this lab**

    https://omcdemo-omcinternal.management.us2.oraclecloud.com/emsaasui/emcpdfui/welcome.html 

    identity domain:    omcinternal


 ![](media/tradomcsignin.png)

1. Enter tenant: **omcinternal** and **Click** Go

![](media/tradomcusername.png)

2. Enter user name and password, **Click** Sign in. Logging in to Oracle Management Cloud, we can see all the different
integrated services on Oracle Management Cloud. We are going to start with a
dashboard that shows Oracle Database. From the Management Cloud home screen, find Dashboards tile or in the left navigation bar. **Click** on Dashboards.

![](media/f380c8f961cf6b7b1fc3fc9ecfe6b8e3.png)



 

4. Here we see
variety of dashboards. (built-in & custom ones).

![](media/90dde3ddef54e23765680268d4f06c76.png)

5. In the Oracle DB Common Issues widget on the top right, **Click** on open in log explorer highlighted arrow below. In this pre-built dashboard has been built a lot of useful out-of-the-box information about the database health and issues. There are many pre-built dashboards, all of which are easily customizable to meet your specific needs. Find the Oracle DB Common Issues widget in the top left and **Click** on highlighted arrow Oracle DB Common Issues 

![](media/4aa78e35bdcbeb8660800f1b1069587c.png)

6. In the Visualize menu, Change visualization to Records & View with histogram

![](media/f3bb88cd24b74ea7383c76ff019df984.png)



7.  Change the query to match the highlighted part. There are a lot of
“Connection Error” and “Hang” error in our DB logs and we are not interested in
those for now so we can exclude them from our search. 

    You can use the search command to eliminate specific logs we are not interested in. In the search field at the top, by….typing 'Entity Type' in ('Oracle Database Instance', 'Oracle Database') and 'Problem Priority' != null and Label not in (Hang, 'Connection Error') | timestats count by Label.  

    Note: the ? will provide search help. 

![](media/4245d0471c7651223946809e0083a406.png)

8.  **Click** on **Field Summary** tab above the histogram widget and hover your mouse on **Deadlock** . **Field Summary**
shows all the “Deadlock” logs are coming from entity “orcl_unit50222” on “ec2tdsgc”
host. This could be very useful informatio.

![](media/4d5fdee1ee0c7669751f4f9164b1cbe4.png)

9.  Now drill down into “Deadlock” logs by **Clicking** on “Deadlock” from
Field Summary Oracle deadlocks occur when one or more sessions attempt to
acquire a resource to a database object that is currently being held by a second
session, which is also attempting to acquire a resource held by the first
session. A DBA wants to make sure there are no Deadlock errors for any
applications and needs more information on specific error/issue

>   If you notice, the query at top is updated.

![](media/47eee94e1962a936ea016bca09f25da9.png)



10. If you **Click** on Log Source in the Search Fields menu, you will see we have identified “deadlock”
related logs coming from two log source types: “Alert logs” & “Trace logs”. Based on the specific time selected by default, there are about 36 (24 + 12)
events

![](media/d31ab25cfe5896b8f37569b8b812cf49.png)

11. Scroll down to select the highlighted trace log and **Click** apply. 

    Trace logs are very
informative with a lot of detail; however, it is not easy to read through all
those log events and find or compare exact details. Log Analytics provides a
very easy way to compare any two events. This comparison capability is very
powerful and helps you easily find differences in log events and get
 to the root cause. It might take half a day or more for a Devops or developer to get
to this stage and even if they get to this stage, they can easily miss the
difference between events.

![](media/217652a9d78df015fb1ac6c4a9df2587.png)

12. Select the second interesting log event to the compare list and **Click** on
Compare. There is another trace logs with a few seconds time difference.
Let’s compare them to see what has changed related to “deadlock” error

![](media/7e45371b3002cd0cab300c4a110a2687.png)

13. **Click** on Compare. By comparing these two selected logs, you can easily
compare all the changes/difference with different color-coding in a table format
to find the possible root-cause.

![](media/c8970ca718f986556f9d77a4a6289443.png)

![](media/a2680d388f54e67a4942d73d90d80e9b.png)

<br>**Lab Activity 2: Application Topology Approach to Locate Root Cause**
======================================================================

User Persona: DBA, DevOps, ITOps
--------------------------------

**Scenario Details**

So far, we drilled into a specific database issue by sorting and filtering logs to gather more context around the issue. To
expand our troubleshooting scenarios, this time we start from the topology
diagram

**Task**

Allowing users to understand the topology of their application and associations
between different entities or drill down into a specific entity or all
associated entities.

**Learner Goal**

You will learn how you can use Application Topology to gain visibility to your
data

**Value Proposition**

Application topology adds a huge value in troubleshooting scenarios since users
can understand how their applications work and be able to drill down into a
specific entity to get more insight from available data

**Duration**: 10 mins.

Click on Log Analytics from the home screen Let us log into Oracle
Management Cloud. Here we can see all the different integrated services on
Oracle Management Cloud. We’re going to start with Log Analytics

![](media/6984e5874b7813878335a77141ed09ed.png)

1. Type in the Global Content bar type Order App to get to the application  we  want to troubleshoot. Click
on Global Content bar and **Select** Order Application GC

![](media/cd8dab3a724bde35e969034c2e2c9b2b.png)

2. **Click** on the topology icon on far left top. **Click** on the timeline field top right, then custom then adjust date to: Feb 7th 12 am – Feb 8th 12 pm then **Click** apply. Under timeline field, **Click** medium to change topology map size. This time we start from
Application topology to see if we can quickly find any possible root cause. 

    The
application topology helps us to understand how different entities are connected
and we can easily filter down to data for a specific entities or entity
associations by just clicking on them. **Note**: Make sure you have selected Feb
7th 12 am – Feb 8th 12 pm

    Note: if you don't see the result (ORA-27091) when moving the timepicker to Feb 8th 12pm, try setting to Feb 9th 12pm next.


![](media/623f33bcb955dd3dbe586395f37b8148.png)

![](media/826e4b18206623f1817c96fb876c20c0.png)

3.  **Select** the database entity which is shown as red in the middle of the map. By selecting the red
database, we will add its entity to filter bar and show all the logs for that
specific entity from the Order App.

![](media/e82dc1809183136c39ad16549b67dfbb.png)

4.  **Select** the association line between the red database and its host. Let us
add the associated host log data with the red database by **Clicking** on the line.
If you notice another filter gets added to the filter bar

![](media/3362203315b0f882facb658319b94600.png)

­

5.  Use the visualize menu to change the visualization to “Record with Histogram” to see all the relevant
logs. Deselect topology view

![](media/2ff61df810bae89cdf2d30861a7409c1.png)

6. **Click** on Error ID in the fields menu on the far left and **Select** “ora-27091” in the error ID menu and apply. It seems there are a few different errors we didn't
know about. As you saw with just three clicks, we could find these errors that
could be the root cause. Let’s **Select** “ora-27091” to see logs events with this
error.

![](media/8b57e736a199b59eb5f01be9d3928e90.png)

![](media/a559fab0343e9cc12e75097d7a3ad29b.png)

7. Now, lets create an alert to catch this error the next time it occurs.  To do that you would normally click on “Save” and check “Creat Alert Rule” and fill up the alert configuration based on your requirements. 

>   **Note: Do not save the alert, click cancel.** Let’s create an alert to
>   notify us if next time this error happened. Click on “Save” and check 

![](media/edd3b56a8d3ca46f7765ee3d7b314988.png)

![](media/bdbd1088efadc883e06c26cf0956e9ed.png)

<br>**Lab Activity 3: Use Machine Learning (Cluster and Cluster Compare) to Find Root Cause**
======================================================================


User Persona: DBA, DevOps, ITOps
--------------------------------

**Scenario Details**

In Activity 2, we drilled into database and host logs to find issues and get
additional context around issues. In this scenario, we take a different approach
and start from log clustering

**Task**

Log volume could be huge; we want to help our users to narrow down their log
events to a much smaller buckets based on similarity in their patterns. You can
help users to find potential issues and outlier OOTB without any pre knowledge
about their data

**Learner Goal**

You will learn how you can use Log Clustering to gain visibility to your data

**Value Proposition**

Log clustering is one of our differentiators compared to other products in the
market. Users can get insight from their data without need of any pre-knowledge
about their data in matter of seconds. Users can use cluster compare capability
to easily compare changes (clusters, potential issue, outliers & trends) based
on time and/or other filtering attributes. These are some of the use cases for
cluster compare:

**Use cases:**

What is different this week compared to last week

What is the difference between set of entity A and entity B

I know things were working fine for a giving week, what has changed this
        week

**Duration**: 15 mins

Go back to the Log Analytics home screen and make sure there is no filter selected and
replace the query with a wildcard asterisk “\*” ‘orderapp’ the select OrderApp

Use timeline menu to select custom and input Dec 1 to Dec 31


>   The only filter we need for this demo is “group: Order Application GC” since
>   we are only focusing on the Order App data. Please pay attention to how many
>   events we have for the Order App within that timeframe (Dec 1st – Dec 31st)
>   – it is million of events.

![](media/4ad4c98235dd2de239f6634276662ed7.png)



1. Run cluster command in the visualize menu under analyze section. From the visualize panel **Select** the Cluster
visualization. As you see, from millions of events, we are down to 773
clusters since there are so many events with the same pattern which get located
into the same cluster. Going through millions events is easier? or 1108
clusters?

![](media/6f510b21edfc46e01bc602904e796ad1.png)

![](media/19e1b9f2ef9473a4e448fcf6809a4ea1.png)

2. Switch to **Potential Issue** tab found above the histogram. Log Analytics automatically finds all potential issues
out of the box. These are events with different variants of severity like “Error”,
“Fault”, “Fatal”, “Warning” or set of terms that are semantically similar to
these.

![](media/cd12c7b4b4042b74d5fe39b73fdb95e5.png)

3. Switch to **Outliers** tab. We identify all events with 1 occurence and show
them in the **Outliers** tab. As shown below, by expanding one of the events you can
tell when exatelly the event occurred.

![](media/625c7d8c799032f11c82572555a2958a.png)

4. Switch to **Trends** tab. We monitor all log events and generate a trend graph
for each variant. The trend tab could be extremely valuable to users because
they can find correlations between events based on their trend occurrence across
multiple tiers. For instance, Let’s say a checkout transaction failed which
generated a bunch of error logs in application logs, most probably there are
other errors which got generated at the web server level in the same time range.
By going to the **Trends** tab users may be able to see these events next to each
other once they **Click** on Similar Trends.

![](media/db07333dbf330a25ccc64d79d9458121.png)

5. Narrow down number of events before applying clustering. You can narrow down data by adding a few filters before running the
clustering algorithm. For instance, in Activity 2 you selected the red database
and its associated host as filters and then started the troubleshooting
investigation. You can do the same here to focus only on those same two
entities and then run the cluster command to get more insight from data.

![](media/76dbee8329a5de4d646c6f69f8ee4c97.png)

6. Go back to Log Analysis home screen and make sure there is no filter already selected and
replace the query with an asterisk “\*”

    While we were using the Cluster capability as part of troubleshooting with  Machine Learning activity, there is another capability called “Cluster
Compare” to easily compare changes (clusters, potential issue, outliers &
trends) based on time and/or other filtering attributes. Assume we just had a
new release for our application “Order App” and we want to compare changes based
on the latest release data vs older data to find the potential root-cause.
Make sure the time picker and the log filters are matching to your
selection as shown below.

![](media/394702608b96f2ca9456e1e8d3651694.png)

7. Run “cluster” command. From the visualize panel **Select** the “Cluster”
visulization. As you see, we found 136 unique clusters from those \~62K events.
Also, we found 12 potential issue and 9 outliers

![](media/e2e625e2af8dca45039a631d8d9c0761.png)

8. **Select** Cluster Compare at the bottom of the visualize menu. Leave both the query and time as-is to compare events to previous release (1 day before). Since we are investigating an issue within our new application
release, we can take advantage of the cluster compare capability to compare changes
(clusters, potential issue, outliers & trends) based on time to our previous
release date. Cluster compare provides capability to change
baseline query and time range for any comparison. For this use case, make
sure you leave both the query and time as-is to compare events to previous
release (1 day before)

![](media/65377186b252fe10ad15fd34ac30334d.png)

9. Next **Click** Cluster Compare Results. As you see below, there are 88 common
clusters between these two release. There are 1 new potentional issue and 2 new
outliers found in this release.

![](media/18db602e6befc2a8555f3a59fd2cb856.png)

>   Cluster Compare Results. As mentioned above, there are 88 clusters common
>   between these two releases. In addition, there were more potentials issues
>   and outliers found in the previous release.

![](media/fc7c2c4f5cda6009513559d92176443e.png)

<br>**Lab Activity 4: Machine Learning (Link) Approach to Find Root Cause – (Optional)**
======================================================================



User Persona: AppOwner, DevOps, ITOps
-------------------------------------

**Scenario Details**

In Activity 3, we learned how to use “Cluster” capability to decrease number of
events in troubleshooting heavily and find potential issues and outlier’s
out-of-the-box. In this scenario, we continue our troubleshooting journey on how
to use “Link” capability.

**Learner Goal**

You will learn how you can use Link to connect event together and find anomalies

**Value Proposition**

Link is a very powerful capability as part of our machine learning capabilities
in LA. Users can link millions events together crossing multiple tiers.
Additionally, analyze those unique groups to find any potential
anomalies/outliers.

**Duration**: 5 mins

Return back to the Log Analytics home screen and make sure there is no filter selected and
replace the query with an asterisk “\*” to clear out any prior data and change the global time picker to the “last 24 hours”

![](media/3a5f8dd8d0d1e04ced2c70bd4a942f9e.png)

1. **Select** a specific log source. **Click** on log source from the field tab on
the left. Search for “EBS and **Select** “EBS concurrent request logs”

![](media/a4adddb2bfdd3bf45b4f461cb5894ce1.png)

2. **Click** on link visualization to link events together. Remove
Log source from “link by”, drag “request ID” instead. Also, remove the “classify"
part of the query. Once you run the query, it links events together based on
shared “Request ID” and automatically calculates “start time”, “end time” and
“group duration” for each group.

![](media/240f46a2807a013b3f1c39b1e548907b.png)

3. Build classify part of the link. As mentioned above, link created unique
groups that shared a common “Request ID”. Addtionally, link can analyze those
events to any find potential anomalies, but to make sense of the data you sometimes need to change the query and rename some fields. Therefore, we
have built a saved search to show how to analyze EBS events in terms of longer
“time taken” to finish than usual, “job status” and “time taken” for each
individual program and mark those events as an anomaly. To open the saved search
follow the steps below.

![](media/5c4b7f9b89d7b5553ece04b4fd6668e4.png)

![](media/70f9a0fba2f4a947254fc8f6491c2837.png)

And that concludes this lab. 

>   [Return back to top menu listing all available labs](../readme.md)