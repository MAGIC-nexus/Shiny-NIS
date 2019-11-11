library(dplyr)
library(ggplot2)
library(stringr)

library("readxl")
data <- read_excel("OUTPUTS/flow_graph_solution_biodiesel.xlsx")

function(input, output) {
  
  output$BarPlot <- renderPlot({


df <- filter(data,data$Scenario == input$scenario & data$Period == input$period & data$Level == input$level,, data$Interface == input$interface)
plt <- ggplot (df, aes( x = "" ,  y = Value, fill = Processor)) +geom_bar(width = 1, stat = "identity") 
pie <- plt + coord_polar("y", start=0)

})}