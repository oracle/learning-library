![](images/500/500.JPG)  

# Lab: Event Hub Cloud Service with Big Data Cloud

## Introduction

In this lab, you will learn how to stream data into **Oracle Event Hub Cloud Service (OEHCS)** and process it with **Spark Streaming** on **Oracle Big Data Cloud**.  

Oracle Event Hub Cloud Service combines the open source technology Apache Kafka with unique innovations from Oracle to deliver a complete platform for working with streaming data.  Documentation for OEHCS can be found here: <http://docs.oracle.com/cloud/latest/event-hub-cloud/index.html>.  General info about Apache Kafka can be found here: <https://kafka.apache.org/>.

The integration between OEHCS and BDC leverages Spark Streaming to easily process the live streams of data from OEHCS.  In particular, while Spark Streaming can work with multiple types of sources, we will be using Spark Streaming's support for Kafka as OEHCS leverages Kafka internally.  Documentation about Spark Streaming can be found here: <http://spark.apache.org/docs/2.1.0/streaming-programming-guide.html>.  And the integration with Kafka here: <https://spark.apache.org/docs/2.1.0/streaming-kafka-integration.html>


## Objectives

- Learn how to setup OEHCS to communicate with BDC
- Learn how to create a topic in OEHCS
- Learn how to write a producer to stream data to OEHCS
- Learn how to consume data from OEHCS with Spark Streaming
- Learn how to use Spark SQL with streaming data
- Learn how to write streaming data to the Object Store
- Learn how to use streaming data to update a Live Map

## Required Artifacts

- A running BDC instance and Storage Cloud Object Store instance, created as per the instructions in Lab 100.  These instructions included the use of a special "bootstrap.sh" script which setup the BDC environment for this workshop.
- You completed Lab 200 Getting to know BDC, Lab 300 More BDC, and Lab 400 OEHCS Provisioning


# Connect to the BDC Console

## Steps

### **STEP 1**: Navigate/login to the Oracle Cloud My Services Dashboard  

![](images/200/Image200-01.png) 

### **STEP 2**: Navigate to the My Services page for your BDC cluster

![](images/200/Image200-02.png)  

### **STEP 3**: Launch the Big Data Cluster Console

![](images/200/Image200-03.png)  




# Work with OEHCS and Spark Streaming

## Open and run the "Tutorial 1 Working with OEHCS and Spark Streaming" Tutorial note in the notebook

### **STEP 1**: Click on the Notebook tab. Expand the Journeys folder.  Then expand the New Data Lake folder. Then expand the Streaming folder.

![](images/500/snap0013444.jpg) 

### **STEP 2**: Click on the "Tutorial 1 Working with OEHCS and Spark Streaming" Tutorial to open it. 

![](images/500/snap0012212.jpg) 

### **STEP 3**: Read and follow the instructions in the Tutorial

The paragraphs of the note are displayed. 

Please walk through the paragraphs one by one. Read through the content of the paragraphs as you get to them. There is much useful information in the paragraphs that is not reproduced into these instructions.

**Pay attention to the instructions in the Tutorial note.  They will ask you to do a few steps outside of the notebook.  These steps need to be completed for the remaining steps to work properly.**

![](images/500/snap0012214.jpg) 

**NOTE:** 
**1. Please add a new shell script after "Shell commands to setup the system Python environment and install Python kafka libraries" with the following code**
```sh
sudo /u01/bdcsce/usr/local/bin/pip install -r requirements.txt
```

**2. Add the following path before python in "Running the Kafka Producer Shell script"**
```sh
/u01/bdcsce/usr/local/bin/python ./tutorial_kafka.py citibike/201612-citibike-tripdata.csv 1 10 2016-12-01 06:00:00 2>&1
```

# Run the Citi Bike Live Map Demonstration

## Open and run the "Citi Bike Live Map with Spark Streaming" note in the notebook

### **STEP 1**: Click on the Notebook tab. Expand the Journeys folder.  Then expand the New Data Lake folder. Then expand the Streaming folder. Then expand the Demo folder.

![](images/500/snap0013445.jpg) 

### **STEP 2**: Click "Citi Bike Live Map with Spark Streaming" note to open it.  


![](images/500/snap0012014.jpg) 

### **STEP 3**: Read and follow the instructions in the Demonstration note.

The paragraphs of the note are displayed. 

Please walk through the paragraphs one by one. Read through the content of the paragraphs as you get to them. There is much useful information in the paragraphs that is not reproduced into these instructions.

![](images/500/DemoLiveMap.gif) 

**NOTE: Add the following path before python in "Producer for the Live Map"**
```sh
#The arguments are datafile TimeSpeedupFactor RecordsToProduce StartDate StartTime  

# for the more complex example, we are running a timespeedup factor of 5 to push data faster through the system

echo "The producer will loop through the datafile until it finds the selected StartDate.  This can take awhile depending on the date of the month you select."
echo "As an example, starting on the 5th can take 90 seconds before the first data is sent.  Starting on the 10th can take 3 minutes. Starting on the 20th can take 6 minutes.  Starting on the 30th can take 9 minutes."

#and I think zeppelin has a default timeout of 10 minutes before it will kill a running shell interpreter
#if you want to run this for a date in the end of the month, I suggest you make a new datafile that omits earlier data.
# Example to make a smaller file that starts with Dec 24th. (dec24th starts on the 1366742th line-- seen by looking at the file in vi)
# head -n 1  bikes/bike_events.csv > bikes/bike_events_startdec24.csv
# tail -n +1366742 bikes/bike_events.csv >> bikes/bike_events_startdec24.csv
# python ./citibike_kafka.py bikes/bike_events_startdec24.csv 20 300 2016-12-25 07:00:00 2>&1

echo ".."
echo ".."
echo "Launching Producer for 2016-12-01 07:00:00 with a time acceleration factor of 5"
/u01/bdcsce/usr/local/bin/python ./citibike_kafka.py citibike/bike_streaming_input.csv 5 400 2016-12-01 07:00:00 2>&1
echo "done"
```
# What you Learned

- Learned how to setup OEHCS to communicate with BDC
- Learned how to create a topic in OEHCS
- Learned how to write a producer to stream data to OEHCS
- Learned how to consume data from OEHCS with Spark Streaming
- Learned how to use Spark SQL with streaming data
- Learned how to write streaming data to the Object Store
- Learned how to use streaming data to update a Live Map

# Next Steps

- Experiment with your own data
