setwd("~/Documentos/shiny-NIS")
library(dplyr)
library(ggplot2)
library(stringr)
library(rlist)
library("readxl")
#LE <- read.csv("OUTPUTS/local_eum.csv")
data <- read_excel("OUTPUTS/flow_graph_solution_biodiesel.xlsx")
Scenarios <- as.vector(unique(data$Scenario))
Periods<- as.vector(unique(data$Period))
Processors<- as.vector(unique(data$Processor))
Interfaces<- as.vector(unique(data$Interface))
Level <-as.vector(unique(data$Level))


for (i in names(LE)){
  if (grepl("Output",i,fixed = TRUE)){
    LE[i] = -LE[i]
  }
}

