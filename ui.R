# USER INTERFACE DEFINITION
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)

# Define UI for application that draws a histogram
#ui<-# table view of the generated distribution
shinyUI(navbarPage("PA Well picker", id = "nav", inverse = TRUE,
                   
                   
  #First tab with pie chart         
  tabPanel("Pie chart by level and Interface",
  
    #fluidPage(
        
      # Application title
      #titlePanel(),

        # Sidebar with a slider input for number of bins 
        sidebarLayout(
          sidebarPanel(
            selectInput("scenario", "Choose a Scenario:",
                        choices = Scenarios),
            selectInput("period", "Choose a Period:",
                        choices = Periods),
            selectInput("level", "Choose a level:",
                        choices = Level),
            selectInput("interface", "Choose an Interface:",
                        choices = Interfaces)
         
          ),
          mainPanel(
            plotOutput("PiePlot")
          )
        )
  ) 
  
    #end of Tab 1
  
  
    # Second TAB (NOT WORKING) 
    # ,tabPanel("Plot",
    #     # Sidebar with a slider input for number of bins 
    #     sidebarLayout(
    #       sidebarPanel(
    #         selectInput("scenario", "Choose a Scenario:",
    #                     choices = Scenarios),
    #         selectInput("period", "Choose a Period:",
    #                     choices = Periods),
    #         selectInput("processor", "Choose a Processor:",
    #                     choices = Processors),
    #         checkboxInput("log_10","apply log10 to data",
    #                       value = FALSE)
    #       ),
    #       
    #       #TODO l should be variable with the filter
    #       #     checkboxGroupInput("checkGroup", label = h3("Interfaces"),
    #       #                        choices = l,
    #       #                        selected = names(l))
    #       # ),
    #       
    #       
    #       # Create a spot for the barplot
    #       mainPanel(
    #         plotOutput("BarPlot")  
    #         )
    #       )
    #   )
    # End of Second tab  
  
  ,tabPanel("EUM",
            sidebarLayout(
              sidebarPanel(
                # TODO INTRODUCIR ESTA VARIABLE EN EL EUM
                numericInput("Population", "Population", 100000),
                selectInput("FundInterface", "Choose a Fund InterfaceType:",
                            choices = FundInterfaces),
                selectInput("ScopeChoice", "Choose a Scope:",
                            choices = Scopes),
                selectInput("ScenarioChoice", "Choose a Scenario:",
                            choices = Scenarios),
                selectInput("PeriodChoice", "Choose a Period:",
                            choices = Periods),
                selectInput("SystemChoice", "Choose a System:",
                            choices = Systems),
                checkboxGroupInput("show_Interfaces", "Choose a flow InterfaceType to show:",
                                   choiceNames = FlowInterfaces, choiceValues = FlowInterfaces, selected = "Biofuel")
              ),
              
              mainPanel(
                tableOutput("eum")
              )
            )
  ) #end second tab   
  # ,tabPanel("EUM2",
  #           sidebarLayout(
  #             sidebarPanel(
  #               # TODO INTRODUCIR ESTA VARIABLE EN EL EUM 
  #               #TODO utilizar fluid row https://shiny.rstudio.com/gallery/basic-datatable.html
  #               numericInput("Population", "Population", 100000),
  #               selectInput("FundInterface", "Choose a Fund InterfaceType:",
  #                           choices = FundInterfaces),
  #               selectInput("Scope", "Choose a Scope:",
  #                           choices = Scopes),
  #               selectInput("Period", "Choose a Period:",
  #                           choices = Periods),
  #               checkboxGroupInput("show_Interfaces", "Choose a flow InterfaceType to show:",
  #                                  choiceNames = FlowInterfaces, choiceValues = FlowInterfaces, selected = NULL)
  #             ),
  #             
  #             mainPanel(
  #               tableOutput("eum")
  #             )
  #           )
  # ) #end second tab
  # 
  # Third tab
  ,tabPanel("Tree",
            sidebarLayout(
              sidebarPanel(
                # TODO INTRODUCIR ESTA VARIABLE EN EL EUM
                #TODO utilizar fluid row https://shiny.rstudio.com/gallery/basic-datatable.html
                selectInput("Scope2", "Choose a Scope:",
                            choices = Scopes),
                selectInput("Period2", "Choose a Period:",
                            choices = Periods)
              ),

              mainPanel(
                collapsibleTreeOutput("Tree")
              )
            )
  ) #end Third tab
  
  )
)