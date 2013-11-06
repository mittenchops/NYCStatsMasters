#################################################
# PART I

# HOW TO GET HELP
?plot
??kolmogorov
vignette()

# USING PACKAGES
install.packages("quantmod", dep=T)
library(quantmod)

# GETTING DATA
iris
AirPassengers
beaver1
data()

# Other languages’ Data
library(xlsx)
library(foreign)

# MARKUP INTO R
library(XML)
url2 <- 'http://www.faa.gov/data_research/passengers_cargo/unruly_passengers/'
X <- readHTMLTable(url2, header=T, stringsAsFactors=FALSE)[[1]]
X

# OTHER DATA SOURCES
library(twitteR)
library(RNYTimes)
library(RClimate)
getSymbols("GOOG")

# searchTwitter('#ilovestatistics',n=10)[[2]] # this will only work if you have a twitter API key.

# BASICS
Person <- "Fred"
Person
0 == F
1+1
2*4
2^5
300 %% 21

# DATA TYPES
a <- c(1,2,3,4)
b <- matrix(c(1,2,3,4), nrow=2)
c <- list("a"="fred", "b"="bill")
d <- data.frame(b)

a # VECTOR
b # MATRIX
c # LIST (Note the key-value structure)
d # DATA FRAME

# CONVERSION AND COERCION
as.data.frame(a)
data.frame(a)
as.matrix(a, nrow=2)    # WATCH OUT
matrix(a, nrow=2)       # this instead

# VARIABLE INTERROGATION
Y <- runif(200)
str(Y)
head(Y) # GIVE ME THE FIRST 5
tail(Y) # GIVE ME THE LAST 5
dim(Y)  # NOPE! HE IS A VECTOR
length(Y)

#

# Using indexes
head(unemp)
unemp[unemp[4]>10,]
b
b[,1]  # ALL ROWS, FIRST COLUMN
b[2,]  # SECOND ROW, ALL COLUMNS
b[-1,] # ALL ROWS EXCEPT 1
b>3
GOOG[GOOG[,6]>1036.00,6]

# Use Names instead: $
name <- c("Fred", "Bill")
occupation <- c("Doctor", "Dancer")
people <- data.frame(name, occupation)

people

people$age <- 35
people

people[people$name=="Fred",]$age=40

XX <- 1
XX$name <- "Fred"
XX$occupation <- "Doctor"
XX$age <- 21

XX$name == XX[2]

# MAKING A FUNCTION
mult2 <- function(arg1,arg2){
z = arg1 * arg2
return(z)
}
mult2(2,10)


g <- function(x){x^2}
mylist <- c(1,2,3,4,5)
g(mylist)

#################################################
# PART II

# LETS LOAD SOME DATA
nyc <- c(33.4,33.3,33.1,33,32.9,32.8,32.7,32.6,32.5,32.4,32.4,32.3,32.3,32.3,32.3,32.2,32.2,32.3,32.3,32.3,32.3,32.4,32.4,32.5,32.5,32.6,32.7,32.8,32.9,33,33.1)
chi <- c(24.4,24.3,24.2,24.1,24,23.9,23.9,23.8,23.7,23.7,23.6,23.6,23.5,23.5,23.5,23.5,23.4,23.4,23.4,23.4,23.5,23.5,23.5,23.6,23.6,23.7,23.8,23.9,24,24.1,24.2)

# STATISTICAL TESTING
t.test(nyc,chi,paired=T)

# STATISTICAL TESTING
var(nyc)
var(chi)
var.test(nyc,chi)

# STATISTICAL TESTING
chisq.test(chi,nyc)

# LINEAR REGRESSION
head(cars)
fit <- lm(dist ~ speed, data=cars)
fit

# LOGISTIC REGRESSION
c2 <- cars
c2[,2] <- ifelse(c2[,2]>20,1,0)
head(c2)

lfit <- glm(dist ~ speed, data=c2, family=binomial)
lfit

# DIAGNOSTICS
summary(fit)

# TIME SERIES MODELING
library(XML)
url2 <- 'http://www.faa.gov/data_research/passengers_cargo/unruly_passengers/'
X <- readHTMLTable(url2, header=T, stringsAsFactors=FALSE)[[1]]
head(X)

# HERE'S HOW
library(XML)
library(forecast)
births <- read.csv(file='monthly-new-york-city-births.csv', header=T, col.names=c('month','births'))
fit <- auto.arima(as.vector(births[,2]))
fit

forecast(fit,10)
plot(forecast(fit,10))

#################################################
# PART III

# FIRST OFF
anscombe

# LINE GRAPH (BASE)
plot(lynx, type=“l”)

layout(1)
plot(lynx)
lines(lowess(lynx))

# HISTOGRAM (BASE)
X <- rnorm(100,50,10)
hist(X)

hist(X, breaks=20) # more bins

hist(X,freq=F)     # density instead of count

# GENERIC BAR GRAPH (BASE)
png("carcyl.png",width=800,height=400)
barplot(table(mtcars$cyl))
dev.off()

# BOX-AND-WHISKER (BASE)
boxplot(Sepal.Width ~ Species, data=iris)

# PANELS (BASE)
library(quantmod)
getSymbols("GM")
getSymbols("GOOG")
layout(matrix(c(1,2),2,1, byrow=T)
plot(GM)
plot(GOOG)

# PANELS (BASE) 2
layout(matrix(c(1,1,1,2,1,1,1,3),2,4,byrow=T))
plot(GOOG)      # 1
hist(X)         # 2
hist(X, freq=F) # 3

# LINEGRAPH (GGPLOT)
library(ggplot2)
lynxdf <- data.frame(year=as.numeric(time(lynx)), Y=coredata(lynx))
qplot(x=year, y=Y, data=lynxdf, geom="line")

# HISTOGRAM
DF <- data.frame(X)
ggplot(DF, aes(x=X)) + geom_histogram()

# GENERIC BAR GRAPH (GGPLOT)
# mtcars is already a data frame
ggplot(mtcars, aes(factor(cyl))) + geom_bar()

# BOX AND WHISKER (GGPLOT)
ggplot(iris, aes(Species, Sepal.Width)) + geom_boxplot()

# PANELS (GGPLOT)
library(grid)
library(gridExtra)
p1 <- qplot(rnorm(100,50,2))
p2 <- qplot(rnorm(100,50,2))
grid.arrange(p1,p2,ncol=1)

pushViewport(viewport(layout = grid.layout(2, 1)))
print(p1, vp=viewport(layout.pos.row = 1,layout.pos.col=1))
print(p2, vp=viewport(layout.pos.row = 2,layout.pos.col=1))

# THANKS!
savehistory('myfile.RHistory')
