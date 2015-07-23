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

# Design shiny server application
shinyServer(
  
  function(input, output) {
    
    #First generate time series plot of gold vs US Dollar
    #Then generate correlation coefficient of gold vs US Dollar
    #Use reactive mode that will re-execute automatically when changing input

    output$distPlot <- renderPlot({
      
      #Get input value
      plot_start <- input$plot_start
      plot_end  <- input$plot_end

      output$plot_start <- renderPrint(plot_start)
      output$plot_end <- renderPrint(plot_end)

      tsplot(plot_start, plot_end, "Combine")
    })
    
    output$distCorr <- renderPrint({
      tscorr(input$cor_start, input$cor_end)
    })
    
  })

