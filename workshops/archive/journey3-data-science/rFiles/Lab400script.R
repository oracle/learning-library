#  This tutorial was built for BDCS-CE version 17.3.3-20 as part of the Data Science Acceleration User Journey
#  Questions and feedback about the tutorial: brian.macdonald@oracle.com

#  Set path for SPARK_HOME and load SparkR library

Sys.setenv(SPARK_HOME = "/usr/hdp/current/spark-client")
library(SparkR, lib.loc = "/usr/hdp/current/spark-client/R/lib")

#  Don't worry about the error messages in the following command.  
#  sparkR.session is trying to create a new SparkUI on parts that are already in use.  
#  It will eventually find a port that is not in use.
sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))

#  Example of R querying Hive
#  This example shows how to use R to query the bike_trips hive table via SparkR features.

#  Use SparkR to query a Hive table
results <- sql("SELECT * from bike_trips")
head(results)

#  let's see what kind of class our results are...
results
# It is a SparkDataFrame
   
#  Example of reading a CSV from Object Store

#  This example shows SparkR features to read a CSV from Object Store via Spark’s DataSources mechanisms
biketrips <- read.df("swift://journeyC.default/citibike/raw/201612-citibike-tripdata.csv", "csv", header = "true", inferSchema = "true", na.strings = "NA")
head(biketrips)
   
#  Example of making a R dataframe into a SparkSQL table

#  Here is an example of converting a R data.frame into a Spark DataFrame and registering it as a Spark SQL table. 
#  You can more examples like this here.
   
#  Load an R data frame
data(iris)
iris
   
#  SparkR code to register an R dataframe as a SparkSQL table
irisDF <- as.DataFrame(iris)
createOrReplaceTempView(irisDF,"iris")
irisDF
   
#  SparkSQL querying R data
head(sql("select * from iris"))
   
#  Machine Learning with R and Spark

#  This example shows running a Spark machine learning algorithm - Generalized Linear Model (glm).
#  We will use our citibike data and model tripduration based on age and gender.
#  SparkR code to build generalized linear model (GLM) of tripduration based on gender and age
ageGender  <- sql("SELECT tripduration, (2016-birthyear) age, gender from bike_trips")
training <- dropna(ageGender)
model <- glm(tripduration ~ age + gender,
             family = "gaussian", data = training)

#  The glm command will generate a few warnings that may affect perfromance of the models.  
#  We can ignore these messages for our data volumes.  
#  If we had larger data sets, we would want to make sure we resolved these warnings.

summary(model)
   
#  Check our predictions (not so good)
fitted <- predict(model, training)
createOrReplaceTempView(fitted,"fitted")
compare <- sql("select prediction, tripduration, age, gender from fitted")
head(compare)
   
#  SparkSQL to view predictions
head(sql("select prediction, tripduration, gender, age from fitted limit 100"),n=100)
   
#  Example of writing a DataFrame back to Object Store
#  The follow shows an example of writing a DataFrame back to the Object Store. 
#  We use the write.df method from SparkR. It supports multiple source types (csv, json, parquet, etc).
   
#  R code to write our predictions back to the Object Store
#  Since we know the resulting file is small, we will do a repartition command to force Spark to write the output as a single file.  
#  This is an optional step.
fitted_singlepartition <- repartition(fitted,1)
write.df(fitted_singlepartition, "swift://journeyC.default/citibike/results/201612-fitted-projections", source="csv", mode="overwrite")
   
#  Explore the contents of the Object Store
#  This command will show you the contents of the Object Store that were just written
system("hadoop fs -ls swift://journeyC.default/citibike/results/201612-fitted-projections")
   

