##Developing Data Products: Course Project
##Subtitle: Which investment is better? US dollar or Gold
##https://archive.ics.uci.edu/ml/datasets/Predict+keywords+activities+in+a+online+social+media

##Data source:
##Gold price: http://data.okfn.org/data/core/gold-prices
##US Dollar rate/index: https://research.stlouisfed.org/fred2/series/DTWEXB/downloaddata

##Price charge unit:
##Gold price: US dollar per ounce
##US dollar rate/index: Relative index to Jan-1997(=100)

#setwd("C:/Users/User/Desktop/Developing Data Products/Course Project/")
library(shiny)
library(ggplot2)
library(pxR)

source("./helper/dataclean.R")

#Design UI for shiny application
shinyUI(fluidPage(
  
  #Main shiny application title
  titlePanel("Which to Invest: Gold or US Dollar"),
  
  # Sidebar with a slider input
  sidebarLayout(
    sidebarPanel(
      
      ##Profile image
      img(src="profile.jpg", height=300, width=573),
      
      br(),
      br(),
      
      ##Description
      p("Compare performance of gold with US dollar and obtain their correlation over time 
         by specifiying start date and end date in the drop down box. 
         You can also use check box to change the date."),
      p("Gold price is calculated as how many US dollars per ounce. US dollars rate is
         calculated as relative index to 1997-01(=100)"),
      
#      sliderInput(inputId="start",
#                  label="Start Date:",
#                  min=as.Date("1995-01-01", format="%Y-%m-%d"),
#                  max=as.Date("2014-06-01", format="%Y-%m-%d"),
#                  value=as.Date("1995-01-01", format="%Y-%m-%d")),
      
#      sliderInput(inputId="end",
#                  label="End Date:",
#                  min=as.Date("1995-01-01", format="%Y-%m-%d"),
#                  max=as.Date("2014-06-01", format="%Y-%m-%d"),
#                  value=as.Date("2014-06-01", format="%Y-%m-%d")),

      p("Select start date and end date for time series plot. "),
      p("Remember start date should not be later than end date. "),

      dateInput(inputId="plot_start",
                label="Start Date:",
                value=as.Date("1995-01-01"),
                min=as.Date("1995-01-01", format="%Y-%m-%d"),
                max=as.Date("2014-06-01", format="%Y-%m-%d")),

      dateInput(inputId="plot_end",
                label="End Date:",
                value=as.Date("2014-06-01"),
                min=as.Date("1995-01-01", format="%Y-%m-%d"),
                max=as.Date("2014-06-01", format="%Y-%m-%d")),
      
      p("Select start date and end date for correlation test. "),
      p("Remember start date should not be later than end date. "),
      
      selectInput(inputId="cor_start",
                  label="Start Date:",
                  choices=datetime,
                  #selected=as.Date("1995-01-01", format="%Y-%m-%d")
                  selected="1995-01-01"
                  ),
      
      selectInput(inputId="cor_end",
                  label="End Date:",
                  choices=datetime,
                  #selected=as.Date("2014-06-01", format="%Y-%m-%d")
                  selected="2014-06-01"
                  ),
      

      ##Data source      
      p("Data obtained from: ",
        a("Gold; ", 
          href="http://data.okfn.org/data/core/gold-prices"),
        a("US Dollar.",
          href="https://research.stlouisfed.org/fred2/series/DTWEXB/downloaddata")
        )

      
      ),
    
    # Show time series plot and correlation on the right side
    mainPanel(
      h3("Which to Invest: Gold or US Dollar?"),
      plotOutput("distPlot"),
      
      h3("What is correlation between Gold and US Dollar price?"),
      verbatimTextOutput("distCorr")
      

    )
  )
))

