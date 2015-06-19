##Statistical Inference Final Project

##Set environment
setwd("C:/Users/User/Desktop/Statistical Inference/")
library(knitr)
library(plotrix)

# set the random seed
set.seed(999)

# set the experiment values
lambda <- 0.2 ##Parameter of exponential distribution
n <- 40 ##Number of exponentials for each simulation
N <- 1000 ##Number of simulation

# prepare the device for a 2*1 plot
# All plotting is clipped to the device region
par(mfrow = c(2,1), xpd=NA)

# generate the random variables for these n values
meanValue <- NULL
meanStd <-NULL

for (i in 1:N){
  
  ##Calculate mean and std of sample means for each simulation
  expo <- rexp(n, lambda)
  mean <- mean(expo)
  std <- sd(expo)
  meanValue <- c(meanValue, mean)
  meanStd <- c(meanStd, std)
  
} ##End for

##Plot histogram of frequency and probability density
expoHistFreq <- hist(meanValue, freq=TRUE, xlim=c(2,8), 
                     main=paste("Histogram of",N,"simulations", xlab="Values"))
expoHistProb <- hist(meanValue, freq=FALSE, xlim=c(2,8), ylim=c(0,0.55), breaks=25, 
                     main=paste("Probability density of",N,"simulations"), xlab="Values")
lines(density(meanValue), col="steelblue") ##Simulated Gaussian probability density curve

##Sample mean and sample variance
meanSample <- mean(meanValue)
stdSample <- sd(meanValue)

##Theoretical mean and theoretical variance
meanThy <- 1/lambda
stdThy <- 1/lambda

##Plot and compare sample mean with theoretical mean
par(mfrow = c(1,1))
expoHistProb <- hist(meanValue, freq=FALSE, xlim=c(2,8), ylim=c(0,0.55), breaks=25, 
                     main=paste("Probability density of",N,"simulations"), xlab="Values")
abline(v=meanSample, col="blue", lwd=3, lty=2) ##Plot sample mean
abline(v=meanThy, col="red", lwd=3, lty=9) ##Plot theoretical mean

##Plot theoretical normal distribution density curve
x <- seq(min(meanValue), max(meanValue)) 
curve(dnorm(x, mean=meanSample, sd=stdSample), 
      col="gray", lwd=3, lty=3, add=TRUE)
legend('topright', c(paste("Sample mean", meanSample), paste("Theoretical mean", meanThy), "Normal distrubution curve"), 
       lty=1, col=c('blue', 'red', "gray"), bty='n', cex=.75)

##Compare sample variance and theoretical variance
stdSample ##stdSample=stdThy/sqrt(n)
stdThy

##Q-Q plot of mean values to show normality
qqnorm(meanValue)
qqline(meanValue)
