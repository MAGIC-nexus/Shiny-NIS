setwd("~/Documentos/shiny-NIS/BAR")
library(dplyr)
library(ggplot2)
library(stringr)
library(rlist)
LE <- read.csv("OUTPUTS/local_eum.csv")
Scenarios <- as.vector(unique(LE$Scenario))
Periods<- as.vector(unique(LE$Period))
Processors<- as.vector(unique(LE$Processor))


#LE.LOG <- cbind(LE[,1:4],log10(LE[,5:ncol(LE)]))

for (i in names(LE)){
  if (grepl("Output",i,fixed = TRUE)){
    LE[i] = -LE[i]
  }
}


