#Testing server functions
rm(list = ls())
setwd("~/Documentos/shiny-NIS")
library(dplyr)
library(ggplot2)
library(stringr)
library(rlist)
library(dplyr)
library(tidyr)
library("collapsibletree")
library("readxl")

data <- read_excel("OUTPUTS/flow_graph_solution.xlsx")
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

##### 
# PIE CHART BY LEVELS (¿CHANGE TO BY PROCESSORS?)

# Inputs  
SCENARIO <- Scenarios[1]
PERIOD<- Periods[length(Periods)]
LEVEL <- Level[3]
INTERFACE <- Interfaces[2]

# filter and chart
df <- filter(data,data$Scenario == SCENARIO & data$Period == PERIOD & data$Level == LEVEL & data$Interface == INTERFACE)
plt <- ggplot (df, aes( x = "" ,  y = Value, fill = Processor)) +geom_bar(width = 1, stat = "identity") 
pie <- plt + coord_polar("y", start=0)
pie

##### 
# EUM

# Inputs

POPULATION <- 1200000
FUNDINTERFACE <- FundInterfaces[1]
FLOWINTERFACES <- FlowInterfaces[1:6]
SCENARIO <- Scenarios[1]
PERIOD<- Periods[length(Periods)]
LEVEL <- Level[3]
SCOPE <- Scopes[1]
SYSTEM<- Systems[1]

# table
df <- filter(data, data$Scenario == SCENARIO, data$Scope == SCOPE, data$System == SYSTEM, data$Period == PERIOD)
eumflow <- filter(df, Interface %in% FLOWINTERFACES)


eumfund <- filter(df, df$Interface == FUNDINTERFACE)

eum <- meuerge(x = eumflow,y = eumfund, by = "Processor")
eum$Valueeum <- eum$Value.x/eum$Value.y
eum$Valuepop<-eum$Value.x/POPULATION

eum$InterfaceUnit<-paste(paste(eum$Interface.x,eum$Interface.y,sep = "/"),paste(eum$Unit.x,eum$Unit.y,sep = "/"),sep=" ")
eumInterface <- eum%>%select(Level.x,Processor, Valueeum,InterfaceUnit)%>% spread(InterfaceUnit,Valueeum)



eumpop<-eum%>%select(Processor, Valuepop, Interface.x)%>% spread(Interface.x,Valuepop)
colnamesEumpop<-paste(colnames(eumpop)[-1], "cap", sep = "/")
eumpop<-`colnames<-`(eumpop,c("Processor",colnamesEumpop))

# eum <- tibble::rowid_to_column(eum, "ID")
totalEUM<-merge(eumpop, eumInterface, by = "Processor")
eumInterface
eumpop
View(totalEUM)


#Tree
SCOPE <- "Total"
PERIOD<- 2017

datafilter<-filter(data,data$Scope == SCOPE,data$Period == PERIOD)
tree<-datafilter%>%separate(Processor,c(Level), sep= "\\.")
collapsibleTree(df = tree, c(Level), fill = "green",width = 800,zoomable = FALSE)










