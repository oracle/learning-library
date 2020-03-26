###########################################

##    Connect to Oracle Object store

##############################################

library(httr)

# identity domain

identity_domain <- "Your_Domain"

#storegae cloud user name

user_id <- "cloud.admin"

#storage cloud user password

password <- "Your_Password"

# container and file name to be accessed

container <- "Journey3"

file_name <- "iris.csv" 

###########

#Build required urls and user id

storage_name <- paste("Storage-",identity_domain,sep="")


#storage cloud authentication URL of the form "https://identitydomain.storage.cloud.com"  replace identitydomain with your identty domain i.e.  a433433

# do not uinclude /auth/v1.0 do not include forward slash

url <-   paste("https://",identity_domain,".storage.oraclecloud.com",sep="")

user_id <- paste(storage_name,":",identity_domain,".",user_id,sep="")

auth_url <- paste(url,"/auth/v1.0",sep="")

fetch_url <- paste(url,"/v1/",storage_name,"/",container,"/",file_name,sep="")


#Get authentication token

auth_string <- httr::GET(url = auth_url, add_headers("X-Storage-User" = user_id, "X-Storage-Pass" = password)   , verbose())

auth_token <- auth_string$headers$`x-auth-token`


#Build Get for file

remote_file <- content(httr::GET(url = fetch_url, add_headers ( "X-Auth-Token" = auth_token)), as="text")

my_data <- read.csv(file = textConnection(remote_file))

my_data

################################################

# This uses spark 1.6.1

# https://spark.apache.org/docs/1.6.1/sparkr.html


#Regression model performance metrics function definitions

mape <- function(y, yhat){mean(abs((y - yhat)/y))}

rmse <- function(error){sqrt(mean(error^2))}



#load sparkR

library("SparkR", lib.loc="/u01/bdcsce/usr/hdp/2.4.2.0-258/spark/R/lib")

Sys.setenv(SPARK_HOME="/u01/bdcsce/usr/hdp/2.4.2.0-258/spark")



# initialize the Spark Context

sc <- sparkR.init()

sqlContext <- sparkRSQL.init(sc)



#drop column

#data  = my_data[-c(1)]

data = my_data


#rename columns

names(data) = c('sep_len', 'sep_w', 'pet_len', 'pet_w', 'class')



#randomly split data into 70% train and 30% test

test_index = base::sample((1:nrow(data)), trunc(length(1:nrow(data))/3))



#convert train and test dataframes into Spark Dataframes

train = createDataFrame(sqlContext, data[-test_index,])

test = createDataFrame(sqlContext, data[test_index,])



#build regression model

m <- glm(pet_len ~ ., data = train, family = "gaussian")



#summarize model

summary(m)



#Deploy model against out of sample test data and generate predictions

pred = predict(m, test)



#Using collect, convert, the spark dataframe back into an R dataframe

result = collect(select(pred,"label", "prediction"))



#calculate out of sample model performance metrics: RMSE (Root Mean Squared Error and MAPE Mean Absolute Percentage Error)

result_metrics = data.frame(rmse = rmse(result$prediction - result$label),
                            
                            mape = mape(result$label, result$prediction))



#show out of sample model performance metrics

result_metrics



#save performance metrics and fitted model

write.csv(result_metrics, "/home/rstudio/result_metrics.csv")

save(m, file = "/home/rstudio/fitted_model.RData")

#################

#write results and model back out to object store



httr::PUT(url = "https://gse00010212.storage.oraclecloud.com/v1/Storage-gse00010212/HA_test/iris_results.csv",
          
          add_headers( "X-Auth-Token" = auth_token),
          
          body = upload_file("/home/rstudio/result_metrics.csv"))



httr::PUT(url = "https://gse00010212.storage.oraclecloud.com/v1/Storage-gse00010212/HA_test/fitted_model.RData",
          
          add_headers( "X-Auth-Token" = auth_token),
          
          body = upload_file("/home/rstudio/fitted_model.RData"))



#############################

#stop the spark context

sparkR.stop()

########