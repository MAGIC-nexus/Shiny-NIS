function(input, output) {
  
  #PieChart
  output$PiePlot <- renderPlot({


df <- filter(data,data$Scenario == input$scenario & data$Period == input$period & data$Level == input$level & data$Interface == input$interface)
plt <- ggplot (df, aes( x = "" ,  y = Value, fill = Processor)) +geom_bar(width = 1, stat = "identity") 
pie <- plt + coord_polar("y", start=0)
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
  
  }