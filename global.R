  rm(list = ls())
  #setwd("~/Documentos/shiny-NIS")
  library(shiny)
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
  library(flexdashboard)
  library("rpivotTable")

  
# old input format
# data$Period<-as.numeric(data$Period)
# Scenarios <- as.vector(unique(data$Scenario))
# Periods<- as.vector(unique(data$Period))
# Processors<- as.vector(unique(data$Processor))
# Interfaces<- as.vector(unique(data$Interface))
# Scopes<- as.vector(unique(data$Scope))
# Level <-as.vector(unique(data$Level))
# Systems<- as.vector (unique(data$System))
# Subsystems<-as.vector(unique(data$Subsystem))
# Flow<- filter(data, data$RoegenType == "flow" | data$RoegenType == "Flow")
# Fund<- filter(data, data$RoegenType == "Fund" | data$RoegenType == "fund")
# FlowInterfaces<- as.vector(unique(Flow$Interface))
# FundInterfaces <- as.vector(unique(Fund$Interface))
 
gg.gauge <- function(eum,breaks=values) {
  # rescale <- function(x) (x-min(x))/(max(x) - min(x)) * 100
  rescale <- function(x) x* 100
  require(ggplot2)
    get.poly <- function(a,b,l = l,r1=0.5,r2=1.0) {
    th.start <- pi*(1-a/l)
    th.end   <- pi*(1-b/l)
    th       <- seq(th.start,th.end,length=l)
    x        <- c(r1*cos(th),rev(r2*cos(th)))
    y        <- c(r1*sin(th),rev(r2*sin(th)))
    return(data.frame(x,y))
    }
  l <- breaks[length(breaks)]
  eumind<-(eum[setdiff(names(eum), "Processor")])
  pos<-round(as.vector(unlist(eumind)),digits = 6)
  posper<-rescale(pos)
  breaks<-rescale(breaks)
  g<- ggplot()+
    geom_polygon(data=get.poly(breaks[1],breaks[2],l=l),aes(x,y),fill="red")+
    geom_polygon(data=get.poly(breaks[2],breaks[3],l=l),aes(x,y),fill="gold")+
    geom_polygon(data=get.poly(breaks[3],breaks[4],l=l),aes(x,y),fill="forestgreen")
    for (b in posper){
      g<- g + geom_polygon(data=get.poly(b-l*0.005,b+l*0.005,0.02,l =l),aes(x,y))
    }
  g +
    # Breaks Label:
    # geom_text(data=as.data.frame(breaks), size=3, fontface="bold", vjust=0,
    #            aes(x=1.1*cos(pi*(1-breaks/l)),y=1.1*sin(pi*(1-breaks/l)),label=paste0(breaks,"%")))+
    # Indicators Label:
    geom_text(data=as.data.frame(posper), size=4, fontface="bold", vjust=0,
              aes(x=1.1*cos(pi*(1-posper/l)),y=1.1*sin(pi*(1-posper/l)),label=paste(eum$Processor,pos, sep = ":")))+
    # annotate("text",x=0,y=0,label=pos,vjust=0,size=8,fontface="bold")+
    coord_fixed()+
    theme_bw()+
    theme(axis.text=element_blank(),
          axis.title=element_blank(),
          axis.ticks=element_blank(),
          panel.grid=element_blank(),
          panel.border=element_blank())
}
