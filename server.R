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


function(input, output) {
  


  #PieChart Level
  output$PiePlot <- renderPlot({
    
    
    #TODO  % Value
    df <- filter(data,data$Scenario == input$scenario & data$Period == input$period & data$Level == input$level & data$Interface == input$interface, data$Scope == input$scope)
    df$per<-round(df$Value/sum(df$Value)*100, digits = 3)
    df$names_per <-paste(df$Processor,df$per,"%", sep = " ")
    plt <- ggplot (df, aes( x = "" ,  y = Value, fill = names_per)) + geom_bar(width = 1, stat = "identity")
    pie <- plt + coord_polar("y", start=0)
    pie

  })



  #PieChart System
  output$PiePlotSystem <- renderPlot({
    #TODO  % Values
    df <- filter(data,data$Scenario == input$scenario2 & data$Period == input$period2  & data$Interface == input$interface2, data$Scope == input$scope2)
    plt <- ggplot (df, aes( x = "" ,  y = Value, fill = System)) + geom_bar(width = 1, stat = "identity")
    pie <- plt + coord_polar("y", start=0)
    pie

  })

  #PieChart Processors
  output$PiePlotProcessors <- renderPlot({

    #TODO  % Values
    df <- filter(data,data$Scenario == input$scenario3 &  data$Period == input$period3  &  data$Interface == input$interface3, data$Scope == input$scope3)
    df <- filter(df, Processor %in% input$ProcessorsChoice, )
    df$per<-round(df$Value/sum(df$Value)*100, digits = 3)
    df$names_per <-paste(df$Processor,df$per,"%", sep = " ")
    plt <- ggplot (df, aes( x = "" ,  y = Value, fill = names_per)) + geom_bar(width = 1, stat = "identity")
    pie <- plt + coord_polar("y", start=0)
    pie


  })




  # #BarChart
  #
  # output$BarPlot <- renderPlot({
  #
  #   df<-filter(LE,LE$Scenario == input$scenario & LE$Period == input$period & LE$Processor == input$processor)
  #   #remouving ".Input" ".Output" from interfaces
  #   xx = c(names(df[-c(1,2,3,4)]))
  #   x<-str_remove(xx,'.Output')
  #   x<-str_remove(x,'.Input')
  #   l<-x
  #   names(l)<-x
  #
  #
  #   if (input$log_10){
  #     y = log10(abs(as.numeric(df[1,-c(1,2,3,4)])))*(abs(as.numeric(df[1,-c(1,2,3,4)]))/as.numeric(df[1,-c(1,2,3,4)]))
  #   }
  #   else{
  #     y = as.numeric(df[1,-c(1,2,3,4)])
  #   }
  #
  #   bar <-data.frame(x,y)
  #   #ba   r<-filter(bar,bar$x %in% c(input$checkGroup))
  #
  #
  #   # Fill in the spot we created for a plot
  #
  #   p = ggplot(bar, aes(x,y)) +
  #     geom_bar(stat = "identity", aes(fill = x), legend = FALSE)
  #   p+theme(axis.text.x = element_text(size = 10, angle = 90))
  # })

  eum<-reactive({
    #renderTable({
    df<-filter(data,data$Scope == input$ScopeChoice, data$Scenario == input$ScenarioChoice , data$Period == input$PeriodChoice, data$System == input$SystemChoice)
    if (length(df$Conflict) != 0){
      df<-filter(df, df$Conflict != "Dismissed")
    }
    eumflow <- filter(df, Interface %in% input$show_Interfaces, )
    eumfund <- filter(df, df$Interface == input$FundInterface)

    eum <- merge(x = eumflow,y = eumfund, by = "Processor")
    eum$Valueeum <- eum$Value.x/eum$Value.y
    eum$Valuepop<-eum$Value.x/input$Population

    eum$InterfaceUnit<-paste(paste(eum$Interface.x,eum$Interface.y,sep = "/"),paste(eum$Unit.x,eum$Unit.y,sep = "/"),sep=" ")
    eumInterface <- eum%>%select(Level.x,Processor, Valueeum,InterfaceUnit)%>% spread(InterfaceUnit,Valueeum)
    eumInterface<-`colnames<-`(eumInterface,c("Level", colnames(eumInterface[-1])))



    eumpop<-eum%>%select(Processor, Valuepop, Interface.x)%>% spread(Interface.x,Valuepop)
    colnamesEumpop<-paste(colnames(eumpop)[-1], "cap", sep = "/")
    eumpop<-`colnames<-`(eumpop,c("Processor",colnamesEumpop))


    eum <- merge(eumpop,eumInterface, by = "Processor")

    #Merge fund column with unit
    eumfund$Interface_Unit<-paste(eumfund$Interface, eumfund$Unit, sep = " ")
    eum<-merge(eumfund%>%select(Processor,Interface_Unit,Value)%>%unique(),eum, by = "Processor")


    eum<-eum[order(eum$Level),]

  })



  output$eum<- DT::renderDataTable({
    #renderTable({
    # df<-filter(data,data$Scope == input$ScopeChoice, data$Scenario == input$ScenarioChoice , data$Period == input$PeriodChoice, data$System == input$SystemChoice)
    # if (length(df$Conflict) != 0){
    #   df<-filter(df, df$Conflict != "Dismissed")
    # }
    # eumflow <- filter(df, Interface %in% input$show_Interfaces, )
    # eumfund <- filter(df, df$Interface == input$FundInterface)
    #
    # eum <- merge(x = eumflow,y = eumfund, by = "Processor")
    # eum$Valueeum <- eum$Value.x/eum$Value.y
    # eum$Valuepop<-eum$Value.x/input$Population
    #
    # eum$InterfaceUnit<-paste(paste(eum$Interface.x,eum$Interface.y,sep = "/"),paste(eum$Unit.x,eum$Unit.y,sep = "/"),sep=" ")
    # eumInterface <- eum%>%select(Level.x,Processor, Valueeum,InterfaceUnit)%>% spread(InterfaceUnit,Valueeum)
    # eumInterface<-`colnames<-`(eumInterface,c("Level", colnames(eumInterface[-1])))
    #
    #
    #
    # eumpop<-eum%>%select(Processor, Valuepop, Interface.x)%>% spread(Interface.x,Valuepop)
    # colnamesEumpop<-paste(colnames(eumpop)[-1], "cap", sep = "/")
    # eumpop<-`colnames<-`(eumpop,c("Processor",colnamesEumpop))
    #
    #
    # eum <- merge(eumpop,eumInterface, by = "Processor")
    #
    # #Merge fund column with unit
    # eumfund$Interface_Unit<-paste(eumfund$Interface, eumfund$Unit, sep = " ")
    # eum<-merge(eumfund%>%select(Processor,Interface_Unit,Value)%>%unique(),eum, by = "Processor")
    #
    #
    # eum<-eum[order(eum$Level),]
    # #condformat(filter(eum, Level == i))%>% rule_fill_gradient(`EC/cap`)
    eum()
  })

  output$eum2<-  renderExcel({
    # df<-filter(data,data$Scope == input$ScopeChoice2, data$Scenario == input$ScenarioChoice2 , data$Period == input$PeriodChoice2, data$System == input$SystemChoice2)
    # if (length(df$Conflict) != 0){
    #   df<-filter(df, df$Conflict != "Dismissed")
    # }
    # eumflow <- filter(df, Interface %in% input$show_Interfaces2, )
    # eumfund <- filter(df, df$Interface == input$FundInterface2)
    #
    # eum <- merge(x = eumflow,y = eumfund, by = "Processor")
    # eum$Valueeum <- eum$Value.x/eum$Value.y
    # eum$Valuepop<-eum$Value.x/input$Population2
    #
    # eum$InterfaceUnit<-paste(paste(eum$Interface.x,eum$Interface.y,sep = "/"),paste(eum$Unit.x,eum$Unit.y,sep = "/"),sep=" ")
    # eumInterface <- eum%>%select(Level.x,Processor, Valueeum,InterfaceUnit)%>% spread(InterfaceUnit,Valueeum)
    # eumInterface<-`colnames<-`(eumInterface,c("Level", colnames(eumInterface[-1])))
    #
    #
    # eumpop<-eum%>%select(Processor, Valuepop, Interface.x)%>% spread(Interface.x,Valuepop)
    # colnamesEumpop<-paste(colnames(eumpop)[-1], "cap", sep = "/")
    # eumpop<-`colnames<-`(eumpop,c("Processor",colnamesEumpop))
    #
    #
    # eum2 <- merge(eumpop,eumInterface, by = "Processor")
    # eum2<-eum2[order(eum2$Level),]
    excelTable(data = eum())
    # eum
  })


  # output$boxplot <- renderPlot({
  #   # #renderTable({
  #   # df<-filter(data,data$Scope == input$ScopeChoice, data$Scenario == input$ScenarioChoice , data$Period == input$PeriodChoice, data$System == input$SystemChoice)
  #   # if (length(df$Conflict) != 0){
  #   #   df<-filter(df, df$Conflict != "Dismissed")
  #   # }
  #   # eumflow <- filter(df, Interface %in% input$show_Interfaces, )
  #   # eumfund <- filter(df, df$Interface == input$FundInterface)
  #   #
  #   # eum <- merge(x = eumflow,y = eumfund, by = "Processor")
  #   # eum$Valueeum <- eum$Value.x/eum$Value.y
  #   # eum$Valuepop<-eum$Value.x/input$Population
  #   #
  #   # eum$InterfaceUnit<-paste(paste(eum$Interface.x,eum$Interface.y,sep = "/"),paste(eum$Unit.x,eum$Unit.y,sep = "/"),sep=" ")
  #   # eumInterface <- eum%>%select(Level.x,Processor, Valueeum,InterfaceUnit)%>% spread(InterfaceUnit,Valueeum)
  #   # eumInterface<-`colnames<-`(eumInterface,c("Level", colnames(eumInterface[-1])))
  #   #
  #   #
  #   #
  #   # eumpop<-eum%>%select(Processor, Valuepop, Interface.x)%>% spread(Interface.x,Valuepop)
  #   # colnamesEumpop<-paste(colnames(eumpop)[-1], "cap", sep = "/")
  #   # eumpop<-`colnames<-`(eumpop,c("Processor",colnamesEumpop))
  #   #
  #   #
  #   # eum <- merge(eumpop,eumInterface, by = "Processor")
  #   #
  #   # #Merge fund column with unit
  #   # eumfund$Interface_Unit<-paste(eumfund$Interface, eumfund$Unit, sep = " ")
  #   # eum<-merge(eumfund%>%select(Processor,Interface_Unit,Value)%>%unique(),eum, by = "Processor")
  #
  #
  #   Indicators<<- a
  #   output<-paste(Indicatorshow,b,sep = " ")
  #   boxplot <- filter(eum, Processor %in% input$ProcessorsChoice, )
  #   bp<- ggplot(boxplot, aes(x = Processor, y = input$Indicatorshow)) + geom_boxplot()
  #   bp
  #
  # })



  output$Tree<-renderCollapsibleTree({
    datafilter<-filter(data,data$Scope == input$Scope2,data$Period == input$Period2)
    tree<-datafilter%>%separate(Processor,c(Level), sep= "\\.")
    collapsibleTree(df = tree, c(Level), fill = "green", width = 800)
  })



  output$TreeInterface<-renderCollapsibleTree({
    datafilter<-filter(data,data$Scope == input$Scope,data$Period == input$Period, data$Interface == input$Interface)
    tree<-datafilter%>%separate(Processor,c(Level), sep= "\\.")
    collapsibleTree(df = tree, c(Level),
                    fill = "green",
                    width = 800,
                    # TODO controlar que el componente agregue desde el último nivel o no. En este momento está agregando aunque se le da todos los valores.
                    # YA HE INTENTADO PONER aggfun = null PERO PARECE QUE SOLO ADMITE MEAN O SUM,,,, ESTO ES UN  PROBLEMA SOLO EN EL CASO DE CONFLICTO DE DATOS
                    # YA QUE EN ESTE CASO SOLO SE LE DA EL RESULTADO AGREGADO BOTTON UP....
                    zoomable = FALSE,
                    tooltip = TRUE,
                    attribute = "Value",
                    nodeSize = "Value")


  })
  output$Unit <- renderText({
    Unit<- paste("Unit",filter(data,data$Interface == input$Interface)$Unit[1],sep = "=")
  })


  }