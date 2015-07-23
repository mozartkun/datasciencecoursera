#Developing Data Products: Course Project

##Introduction
This peer assessed assignment has two parts. First, you will create a Shiny application and deploy it on Rstudio's servers. Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.

##Executive Summary
Investors are often faced with one serious question: What should I invest? Most investors may choose gold or US dollars to preserve their asset value since these two commodities are most stable in intrinsic value. In fact, there is insteresting relationship between these two commodities. In most cases, when many investors are confident about US dollars, they will sell gold for dollars so that gold spot price drops and US dollar rises in exchange rate. On the contrary, when investors are not confident about US dollars (e.g. US monetary policy, financial crisis, etc.), they will purchase gold using dollars, so that US dollar devalues and gold stop price appreciates. Roughly speaking, the relationship between gold price and US dollar rate is assumed to be negative in most time periods. This course project aims to show this argument using basic plots and correlation tests. Results are presented with shiny app and R presenter. 

##Your Shiny Application
1. Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.

2. Deploy the application on Rstudio's shiny server

3. Share the application link by pasting it into the text box below

4. Share your server.R and ui.R code on github

The application must include the following:

1. Some form of input (widget: textbox, radio button, checkbox, ...)  
2. Some operation on the ui input in sever.R  
3. Some reactive output displayed as a result of server calculations  
4. You must also include enough documentation so that a novice user could use your application.  
5. The documentation should be at the Shiny website itself. Do not post to an external link.  

The Shiny application in question is entirely up to you. However, if you're having trouble coming up with ideas, you could start from the simple prediction algorithm done in class and build a new algorithm on one of the R datasets packages. Please make the package simple for the end user, so that they don't need a lot of your prerequisite knowledge to evaluate your application. You should emphasize a simple project given the short time frame.  

##Shiny Application for Course Project
In this project, result about gold price and US dollar rate is presented in shiny app "[golddollar.io]"(https://ximenglate.shinyapps.io/golddollar). In includes time series plot of price over time for both gold (denominated as dollars per ounce) and US dollars (denominated as relative index to base date 1997-01 which is set to 100). It also shows correlation test of gold price and US dollar rate. The choosen monthly time window is from 1995-01-01 to 2014-06-01. The shiny app provides sidebar, dropdown box and checkbox for users to change start date and end date. You can select different start date and end date to see different time series plot and correlation test results. Note that the start date you choose should not be later than end date, or errors and warnings will arise.

Data about gold spot price is found at [http://data.okfn.org/data/core/gold-prices](http://data.okfn.org/data/core/gold-prices). Data about US dollar rate is found at [https://research.stlouisfed.org/fred2/series/DTWEXB/downloaddata](https://research.stlouisfed.org/fred2/series/DTWEXB/downloaddata). You can export your own data file by yourself. 

There are several steps for users before enjoying this "golddollar" shiny app.
First, you can download all files from my github repo [https://github.com/ximenglate/datasciencecoursera/tree/master/Developing-Data-Products/golddollar](https://github.com/ximenglate/datasciencecoursera/tree/master/Developing-Data-Products/golddollar) and run codes in Rstudio:
```
library(shiny)
library(shinyapps)
runApp('golddollar')
```
Second, you can enter shiny app link [https://ximenglate.shinyapps.io/golddollar](https://ximenglate.shinyapps.io/golddollar) and enjoy this app. If you cannot enter, try "http" rather than "https".
