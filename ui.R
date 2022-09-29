library(shiny)
library(shinyWidgets)
library(plotly)
library(tidyverse)
library(tidyquant)

tickers <- c("^NDX","^GSPC","BTC-USD","DX-Y.NYB")

prices <- tq_get(tickers, 
                 get  = "stock.prices",
                 from = today()-months(12),
                 to   = today(),
                 complete_cases = F) %>%
  select(symbol,date,close)

shinyUI(
  fluidPage(
    
    # Title
    titlePanel("Market Indices"),
    
    # Sidebar 
    sidebarLayout(
      sidebarPanel(width = 3,
      radioButtons("index", label = h3("Index"), 
                          choices = list("NASDAQ" = tickers[1],
                                         "S&P500" = tickers[2], 
                                         "BITCOIN" = tickers[3],
                                         "USD Index" = tickers[4]),
                          selected=1
                        ),
      ),
      
      # Plot
      mainPanel(
        plotlyOutput("plot")
      )
    )
  )
  
)