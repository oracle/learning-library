#Oraobjstore Journey

library(devtools)

install_github("brianmacdonald-ml/oraobjectstore",FORCE=TRUE)
library(oraobjectstore)



my_credentials <- oos_authenticate("YOUR_IDENTITY_DOMAIN","YOUR_ID","YOUR_PWD")

oos_ls(my_credentials,"BAM")

my_data <- oos_get_file(my_credentials,"BAM","iris.csv")
dim(my_data)
head(my_data)

iris.lm <- lm(Petal.Width ~ Petal.Length, data=my_data)
summary(iris.lm)

my_iris <- predict(iris.lm,newdata=my_data)
head(my_iris)

my_iris <- cbind(my_data,my_iris)
dim(my_iris)
head(my_iris)

write.csv(my_iris,"my_iris.csv",row.names=FALSE)
oos_upload_file(my_credentials,"BAM","/home/oracle", "my_iris.csv")


my_files <- oos_ls(my_credentials,"BAM")
my_files$name



oos_rm(my_credentials,"BAM","my_iris.csv")
oos_ls(my_credentials,"BAM")
