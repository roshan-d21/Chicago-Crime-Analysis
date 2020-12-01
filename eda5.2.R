#install.packages("R.utils")

library("ggplot2")
library(dplyr)
library(tidyr)
library("R.utils")
library("data.table")
library("readr")
library(lubridate)


#Trimming down the dataset
df.name <- "Crimes_-_2001_to_Present.csv"
df<-fread(df.name)
allowed_years<-c("2005","2006","2007","2008","2009","2010","2011","2012","2018","2019","2020")


#df.arrested<- df[df$Year %in% allowed_years]
#df.arrested<- df[(df$Arrest == FALSE) & (df$Year %in% allowed_years) ]
#df.arrested<- df[(df$Arrest == FALSE) & (df$Year %in% allowed_years) & (df.arrested$`Primary Type` == "BURGLARY") ]
#df.arrested<- df[ (df$Year %in% allowed_years) & (df.arrested$`Primary Type` == "BURGLARY") ]
df.arrested<- df[ df$`Primary Type` == "BURGLARY" ]
#df.arrested<- df.arrested[ df.arrested$Year %in% allowed_years ]


#Splitting Date into Date and Time
df.arrested<- separate(
  df.arrested,
  Date,
  c("Date","Time"),
  sep = 11,
  remove = FALSE,
  convert = FALSE,
  extra = "warn",
  fill = "warn"
)
df.arrested$Date = gsub("/", "-", df.arrested$Date)
df.arrested$Date = gsub(" ", "", df.arrested$Date)

#Adding Week column
df.arrested$Week = lubridate::week(mdy(df.arrested$Date))


date_count<-setNames(data.frame(table(df.arrested$Date)),c("Date","Count"))
date_count<- separate(
  date_count,
  Date,
  c("garbage","Year"),
  sep = 6,
  remove = FALSE,
  convert = FALSE,
  extra = "warn",
  fill = "warn"
)
date_count$garbage<-NULL
date_count$Week = lubridate::week(mdy(date_count$Date))

dc<- date_count %>% group_by(Year,Week) %>% summarise(total = sum(Count))
x <- date_count %>% group_by(Year) %>% summarise(total = sum(Count))
dc %>%
  ggplot( aes(x=Week, y=total, group=Year, color=Year)) +
  geom_line()
