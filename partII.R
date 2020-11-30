library(dplyr)
library(ggplot2)
c <- read.csv(file="output.csv")
summary(c)
# Aggregate the data
d_burg_ym <- filter(c,Year!=2020) %>% group_by(Year) %>% count(Month) %>% arrange()
#Burglary data for 2001 - 2019 by years with months summary
d_burg_ym
library(forecast)

# Plots 
d_burg_ym_ts <- ts(d_burg_ym,start = 2001,end = 2018,frequency = 12)
seasonplot(d_burg_ym_ts[,3],s = 12,col=rainbow(16), year.labels=TRUE,main = "Burglary rate by year and month")
ggseasonplot(d_burg_ym_ts[,3], polar=TRUE)
autoplot(d_burg_ym_ts[,3])
ggAcf(d_burg_ym_ts[,3])
d_burg_ym_ts[,3] %>% decompose %>% autoplot

# ARIMA Model
# ARIMA
fit.arima <- auto.arima(d_burg_ym_ts[,3])
fit.arima$coef
with(fit.arima,plot(fitted,residuals))
checkresiduals(fit.arima)
plot(forecast(fit.arima,h = 24))
acc.arima <- accuracy(fit.arima)
acc.arima


