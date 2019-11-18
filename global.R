setwd("~/Documentos/shiny-NIS")
library(dplyr)
library(ggplot2)
library(stringr)
library(rlist)
library(dplyr)
library(tidyr)
library("readxl")
#LE <- read.csv("OUTPUTS/local_eum.csv")
data <- read_excel("OUTPUTS/flow_graph_solution _Netherlandsv1.xlsx")
Scenarios <- as.vector(unique(data$Scenario))
Periods<- as.vector(unique(data$Period))
Processors<- as.vector(unique(data$Processor))
Interfaces<- as.vector(unique(data$Interface))
Scopes<- as.vector(unique(data$Scope))
Level <-as.vector(unique(data$Level))
Flow<- filter(data, data$RoegenType == "flow" | data$RoegenType == "Flow")
Fund<- filter(data, data$RoegenType == "Fund" | data$RoegenType == "fund")
FlowInterfaces<- as.vector(unique(Flow$Interface))
FundInterfaces <- as.vector(unique(Fund$Interface))

# 
# for (i in names(LE)){
#   if (grepl("Output",i,fixed = TRUE)){
#     LE[i] = -LE[i]
#   }
# }
# 
int <-  c("Chemical", "Crop")
eumflow<-filter(data, Interface %in% int)
                #data$Scope == "Internal", data$Period == 2017)
eumfund<-filter(data, data$Interface == "Labour")

eum<-merge(x = eumflow,y = eumfund, by = "Processor")
eum$Valueeum <- eum$Value.x/eum$Value.y
eum<-eum%>%select(Processor, Valueeum, Interface.x)
eum <- tibble::rowid_to_column(eum, "ID")
eum2<- eum%>% spread(Interface.x,Valueeum)
eum2
