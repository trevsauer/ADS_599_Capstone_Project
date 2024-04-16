getwd()

setwd('/Users/stephenreagin/Desktop/USD/ADS_599_Capstone_Project')

library(tidyverse)
library(fpp3)
library(forecast)
library(ggplot2)
#install.packages('vars')
library(vars)
#install.packages('sqldf')
#library(sqldf)

################################################################
# start with a dataframe for cluster labels
# and another for token frequencies (this may be split into multiple files
#                                     that need concatenation)
################################################################

df1 <- read.csv('notebooks/labels_df_no_numbers.csv')
moving_avg_df <- read.csv('notebooks/lemmatized_moving_avg_df.csv')

################################################################
################################################################


################################################################
################################################################
################################################################
# if this is your first time, 
# run this section of code to create a "seed" model
# and create a dataframe
################################################################
token_list <- df1[df1$k_cluster == 10,]$original_tokens
cluster_df <- moving_avg_df[, names(moving_avg_df) %in% token_list]
cluster_df$pub_date <- as.Date(moving_avg_df$ds)
cluster_tsibble <- as_tsibble(cluster_df, index='pub_date')
train_cluster_tsibble <- cluster_tsibble |> slice(0:(length(cluster_tsibble$pub_date)-392))
valid_cluster_tsibble <- cluster_tsibble |> slice(n()-391:0)
var_model <- VAR(y=train_cluster_tsibble[, !names(train_cluster_tsibble) %in% c('pub_date')], p = 1)
cluster_predict <- predict(var_model, n.ahead = 392)
LOC <- c(token_list)

temp_df <- data.frame(lapply(LOC, function(var_name) cluster_predict$fcst[[var_name]][, 'fcst']))
colnames(temp_df) <- token_list

my_df <- cbind(my_df, temp_df)
################################################################
################################################################


################################################################
################################################################
# otherwise pull in the previous results and start there
################################################################

my_df <- read.csv('notebooks/VAR_forecast_results.csv')

################################################################
################################################################




################################################################
################################################################
# LOOP THROUGH CLUSTERS AND RUN A VAR MODEL FOR EACH CLUSTER
################################################################
################################################################


#pulled out cluster 8 because of the word "function"
#pulled out cluster 31 because of the word "next"
#pulled out cluster 04 because of the word "excel" and other unknown reasons
#pulled out cluster 38 because of the word ""??? maybe duplicated :(
#pulled out cluster 29 because of the word ""
#pulled out cluster 22 because of the word ""
#pulled out cluster 10 because of the word ""
#for (i in c(12,8,31,29)){ 
#for (i in c(3, 35,47,45,49,20,15,39,26,21,5,48,41) {
#for (i in c(31,40,13,28,2,32,42,17,1,18,11,6,34,24)){
#for (i in c(19,46,30,36,33,37,38,44,7,14,16,29,9,22,10,0,38)){
#for (i in c(104, 204, 110, 210,125,225,325,127,227, 122, 222, 123,223,323)){
#still need cluster 43

for (i in c(143,243, 343)){
  start_time <- Sys.time()
  print(paste0("Start: ", i))
  
  tryCatch(
    {
    token_list <- df1[df1$k_cluster == i,]$original_tokens
    cluster_df <- moving_avg_df[, names(moving_avg_df) %in% token_list]
    cluster_df$pub_date <- as.Date(moving_avg_df$ds)
    cluster_tsibble <- as_tsibble(cluster_df, index='pub_date')
    train_cluster_tsibble <- cluster_tsibble |> slice(0:(length(cluster_tsibble$pub_date)-392))
    valid_cluster_tsibble <- cluster_tsibble |> slice(n()-391:0)
    
    var_model <- VAR(y=train_cluster_tsibble[, !names(train_cluster_tsibble) %in% c('pub_date')], p = 1)
    cluster_predict <- predict(var_model, n.ahead = 392)
    
    LOC <- c(token_list)
    temp_df <- data.frame(lapply(LOC, function(var_name) cluster_predict$fcst[[var_name]][, 'fcst']))
    colnames(temp_df) <- token_list
    my_df <- cbind(my_df, temp_df)
    },
    error = function(e) {
      print(paste0("Cluster ", i, "throws an error"))
    }
    
  )
  end_time <- Sys.time()
  print(paste0("Finish: ", (end_time - start_time)))
}


#check the dimensions
dim(my_df)

#save to CSV file
write.csv(my_df,'notebooks/VAR_forecast_results.csv')

