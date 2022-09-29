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

shinyServer(function(input, output) {
  
  observeEvent(input$index, {
    
    prices <- prices %>%
      filter(symbol %in% input$index)

    output$plot <- renderPlotly({
      print(
        ggplotly(prices %>%
                   ggplot(aes(date, close)) +
                   geom_line(size = 1, alpha = 1, col="red") +
                   theme_minimal(base_size=20) +
                   theme(axis.title=element_blank(),
                   plot.background = element_rect(fill = "white"),
                   legend.text = element_text(colour="black"))
        )
      )
    })
  })
})