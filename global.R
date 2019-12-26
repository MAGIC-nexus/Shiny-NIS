  rm(list = ls())
  setwd("~/Documentos/shiny-NIS")
  library(dplyr)
  library(ggplot2)
  library(stringr)
  library(rlist)
  library(dplyr)
  library(tidyr)
  library("readxl")
  library("collapsibleTree")
  library(data.table)
  library(excelR)
  library("DT")


data <- read_excel("~/Documentos/Shiny/OUTPUTS/flow_graph_solution_Biodiesel_last.xlsx") #caso Biofuel versión de juan con jerarquía por sistemas
# data <- read_excel("~/Documentos/Shiny/OUTPUTS/flow_graph_solution_caso_materiales.xlsx") #caso Raul de Industrials solo año 2018 y paises be y at
# data <- read_excel("~/Documentos/Shiny/OUTPUTS/flow_graph_solution_GC.xlsx") #caso Violeta con jerarquía por fincas y jeararquía de interface type de agua.
data$Period<-as.numeric(data$Period)
Scenarios <- as.vector(unique(data$Scenario))
Periods<- as.vector(unique(data$Period))
Processors<- as.vector(unique(data$Processor))
Interfaces<- as.vector(unique(data$Interface))
Scopes<- as.vector(unique(data$Scope))
Level <-as.vector(unique(data$Level))
Systems<- as.vector (unique(data$System))
Subsystems<-as.vector(unique(data$Subsystem))
Flow<- filter(data, data$RoegenType == "flow" | data$RoegenType == "Flow")
Fund<- filter(data, data$RoegenType == "Fund" | data$RoegenType == "fund")
FlowInterfaces<- as.vector(unique(Flow$Interface))
FundInterfaces <- as.vector(unique(Fund$Interface))

  
  
  #Deprecated
# for (i in names(LE)){
#   if (grepl("Output",i,fixed = TRUE)){
#     LE[i] = -LE[i]
#   } 
# }
# 
# int <-  c("Chemical", "Crop")
# eumflow<-filter(data, Interface %in% int, data$Scope == "Internal", data$Period == 2017)
# eumfund<-filter(data, data$Interface == "Labour")
# 
# eum<-merge(x = eumflow,y = eumfund, by = "Processor")
# eum$Valueeum <- eum$Value.x/eum$Value.y
# eum$Valuepop<-eum$Value.x/500000
# eumInterface<-eum%>%select(Processor, Valueeum, Interface.x)
# eumInterface <- tibble::rowid_to_column(eumInterface, "ID")
# eumInterface%>%select(Processor,Valueeum, Interface.x)%>% spread(Interface.x,Valueeum)
# 
# eumPop<-eum%>%select(Processor, Valuepop, Interface.x)
# eumPop <- tibble::rowid_to_column(eumPop, "ID")
# eumPop<-eumPop%>%select(Processor,Valuepop, Interface.x)%>% spread(Interface.x,Valuepop)
# 
# 
# 
#   merge(eumpop,eum, by = Processor)
