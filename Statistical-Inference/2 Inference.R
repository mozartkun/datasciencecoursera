##Statistical Inference Final Project

##Set environment
setwd("C:/Users/User/Desktop/Statistical Inference/")
library(knitr)
library(datasets)
library(ggplot2)

##Load dataset
##ToothGrowth: The response is the length of odontoblasts (teeth) in each of 10 guinea pigs at each of three dose levels of Vitamin C (0.5, 1, and 2 mg) with each of two delivery methods (orange juice or ascorbic acid).
data(ToothGrowth)
head(ToothGrowth, 5)

##Preprocess dataset
dose <- ToothGrowth$dose
supp <- ToothGrowth$supp
len <- ToothGrowth$len ##tooth growth for comparison

##Summarize dataset
##len  numeric Tooth length
##supp factor  Supplement type (VC or OJ)
##dose numeric Dose in milligrams
summary(ToothGrowth)

##Exploratory analysis of dataset
##Relationship between dose and len
g1 <- ggplot(ToothGrowth, aes(x=dose, y=len, group=factor(supp)))
g1 <- g1 + geom_point(size=10, pch=21, fill="salmon", alpha=0.5)
g1

##Relationship between supp and len
g2 <- ggplot(ToothGrowth, aes(x=supp, y=len, group=factor(dose)))
g2 <- g2 + geom_point(size=10, pch=21, fill="salmon", alpha=0.5)
g2

##Use box plot to do exploratory analysis
b1 <- ggplot(ToothGrowth, aes(x =dose, y=len, fill=factor(dose))) 
b1 <- b1 + geom_boxplot() + guides(fill=FALSE) + facet_grid(. ~ supp)
b1

b2 <- ggplot(ToothGrowth, aes(x=supp, y=len, fill=factor(supp))) 
b2 <- b2 + geom_boxplot() + guides(fill=FALSE) + facet_grid(. ~ dose)
b2

##Split the data by dosages (0.5, 1, and 2 mg)
dose1 <- subset(ToothGrowth, dose==0.5)
dose2 <- subset(ToothGrowth, dose==1.0)
dose3 <- subset(ToothGrowth, dose==2.0)

##Split the data by supplement type (Vitamin C and Orange juice)
suppVC <- subset(ToothGrowth, supp=="VC")
suppOJ <- subset(ToothGrowth, supp=="OJ")

##T-test between supplement types (Independent/paird, (non)equal variance sample)
##Full sample
test0 <- t.test(len~supp, paired=TRUE, var.equal=TRUE, data=ToothGrowth)
test0$p.value
test0$conf[1:2]
##dose=0.5
test1 <- t.test(len~supp, paired=FALSE, var.equal=FALSE, data=dose1)
test1$p.value
test1$conf[1:2]
##dose=1.0
test2 <- t.test(len~supp, paired=FALSE, var.equal=FALSE, data=dose2)
test2$p.value
test2$conf[1:2]
##dose=2.0
test3 <- t.test(len~supp, paired=FALSE, var.equal=FALSE, data=dose3)
test3$p.value
test3$conf[1:2]

