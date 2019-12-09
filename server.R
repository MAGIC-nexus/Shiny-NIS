# library(magrittr)
# library(shinyjs)
# library(logging)
# 
# basicConfig()
# 
# options(shiny.error = function() { 
#   logging::logerror(sys.calls() %>% as.character %>% paste(collapse = ", ")) })
# 
# 
options(shiny.reactlog = TRUE)


function(input, output) {
  
  #PieChart
  output$PiePlot <- renderPlot({


    df <- filter(data,data$Scenario == input$scenario & data$Period == input$period & data$Level == input$level & data$Interface == input$interface)
    plt <- ggplot (df, aes( x = "" ,  y = Value, fill = Processor)) + geom_bar(width = 1, stat = "identity") 
    pie <- plt + coord_polar("y", start=0)
    cat("pie")
    pie
    

  })
  
  
  
  #BarChart
  
  output$BarPlot <- renderPlot({
    
    df<-filter(LE,LE$Scenario == input$scenario & LE$Period == input$period & LE$Processor == input$processor)
    #remouving ".Input" ".Output" from interfaces
    xx = c(names(df[-c(1,2,3,4)]))
    x<-str_remove(xx,'.Output')
    x<-str_remove(x,'.Input')
    l<-x
    names(l)<-x
    
    
    if (input$log_10){
      y = log10(abs(as.numeric(df[1,-c(1,2,3,4)])))*(abs(as.numeric(df[1,-c(1,2,3,4)]))/as.numeric(df[1,-c(1,2,3,4)]))
    }
    else{
      y = as.numeric(df[1,-c(1,2,3,4)])
    }
    
    bar <-data.frame(x,y)
    #ba   r<-filter(bar,bar$x %in% c(input$checkGroup))
    
    
    # Fill in the spot we created for a plot
    
    p = ggplot(bar, aes(x,y)) +
      geom_bar(stat = "identity", aes(fill = x), legend = FALSE)
    p+theme(axis.text.x = element_text(size = 10, angle = 90))
  })
  
  
  output$eum<- renderTable({
    df <- filter(data, data$Scenario == input$ScenarioChoice, data$Scope == input$ScopeChoice, data$System == input$SystemChoice, data$Period == input$PeriodChoice)
    eumflow <- filter(df, Interface %in% input$show_Interfaces, )
    eumfund <- filter(df, data$Interface == input$FundInterface)
    eum <- merge(x = eumflow,y = eumfund, by = "Processor")
    eum$Valueeum <- eum$Value.x/eum$Value.y
    eum$Valuepop<-eum$Value.x/input$Population
    eumInterface <- eum%>%select(Processor, Valueeum, Interface.x)%>% spread(Interface.x,Valueeum)
    #eumpop<-eum%>%select(Processor, Valuepop, Interface.x)%>% spread(Interface.x,Valuepop)
    # eum <- tibble::rowid_to_column(eum, "ID")
    # merge(eumpop,eum, by = Processor)
    eumInterface
    browser()
  })
  
  
  output$Tree<-renderCollapsibleTree({
    datafilter<-filter(data,data$Scope == input$Scope2,data$Period == input$Period2)
    tree<-datafilter%>%separate(Processor,c(Level), sep= "\\.")
    collapsibleTree(df = tree, c(Level), fill = "green", width = 800)
  })
  
  }