library(XML)
library(xts)
library(forecast)
library(ggplot2)

# BIRTHS
births <- read.csv(file='monthly-new-york-city-births.csv', header=T, col.names=c('month','births'))
fit <- auto.arima(as.vector(births[,2]))
png(file='births.png',width=1000, height=500)
plot(forecast(fit,10), main='Monthly births in New York City starting in 1946')  #standard plot
dev.off()
#Series: as.vector(births[, 2]) 
#ARIMA(4,1,3)                    
#
#Coefficients:
#         ar1     ar2      ar3      ar4      ma1     ma2     ma3
#      0.4918  0.6102  -0.2806  -0.5472  -1.2276  0.0361  0.5153
#s.e.  0.1142  0.1140   0.0560   0.0877   0.1165  0.2000  0.1115
#
#sigma^2 estimated as 1.187:  log likelihood=-251.26
#AIC=518.39   AICc=519.3   BIC=543.33

# UNRULY PASSENGERS
url2 <- 'http://www.faa.gov/data_research/passengers_cargo/unruly_passengers/'
X <- readHTMLTable(url2, header=T, stringsAsFactors=FALSE)[[1]]
unruliness <- as.xts(as.numeric(X[-19,2]), order.by = as.Date(X[-19,1], format="%Y"))

nobs <- length(unruliness[,1])
fit <- auto.arima(as.vector(unruliness), xreg=1:nobs-1, ic="bic") # (1,0,0)
fore <- predict(fit, 10, newxreg=(nobs+1):(nobs+10))
#Series: as.vector(unruliness) 
#ARIMA(1,0,0) with non-zero mean 
#
#Coefficients:
#         ar1  intercept  1:nobs - 1
#      0.7464   212.4001     -2.5713
#s.e.  0.1579    55.9264      4.9262
#
#sigma^2 estimated as 1669:  log likelihood=-92.73
#AIC=193.45   AICc=196.53   BIC=197.01

#fit <- auto.arima(as.vector(unruliness)) # (0,1,0) random walk
#fore <- predict(fit, 10)

# Prettier graph
dates <- seq(index(last(unruliness)), by="year", length.out=11)
pred <- xts(fore$pred,dates[-1])
uconf <- xts((fore$pred + 1.96*fore$se),dates[-1])
lconf <- xts((fore$pred - 1.96*fore$se),dates[-1])

yvars <- merge(unruliness,pred,uconf,lconf)
yvars[length(unruliness),] <- coredata(last(unruliness)) # link to now.

plotdat <- data.frame(
  Series = as.numeric(yvars[,1]),
  Forecast = as.numeric(yvars[,2]),
  LowerBound = as.numeric(yvars[,3]),
  UpperBound = as.numeric(yvars[,4]),
  date = index(yvars))

f1 <- ggplot(plotdat, aes(x=date) ) +
    geom_line(aes(y = Series), size=1.1, colour="black") +
    theme_bw() +
    geom_smooth(aes(y = Forecast, ymin = LowerBound, ymax = UpperBound), stat="identity", alpha=0.20) +
    geom_line(aes(y = Forecast), colour="red", size=0.90) +
    geom_line(aes(y = LowerBound), colour="red", size=0.25, linetype="longdash") +
    geom_line(aes(y = UpperBound), colour="red", size=0.25, linetype="longdash") +
    opts(title="FAA's Count of Unruly Passengers")
print(f1)
ggsave('unruly-fcast.png', width=6.5, height=2.75, plot=f1, dpi=90)

f2 <- ggplot(plotdat, aes(x=date) ) +
    geom_line(aes(y = Series), size=1.1, colour="black") +
    theme_bw() +
    opts(title="FAA's Count of Unruly Passengers")
print(f2)
ggsave('unruly.png', width=6.5, height=2.75, plot=f2, dpi=90)
