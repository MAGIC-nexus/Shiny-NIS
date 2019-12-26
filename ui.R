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
#ui<-# table view of the generated dist ribution
shinyUI(navbarPage("MuSIASEM data visualizations", id = "nav", inverse = TRUE,
                   
     # New tab with pie chart Levels-Interfaces
  tabPanel("Pie chart by level and Interface",
    #fluidPage(

      # Application title
      #titlePanel(),

        # Sidebar with a slider input for number of bins
        sidebarLayout(
          sidebarPanel(
            selectInput("scenario", "Choose a Scenario:",
                        choices = Scenarios),
            selectInput("scope", "Choose a Scope:",
                        choices = Scopes),
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

    #end of Tab

  # New tab with pie chart Systems-Interfaces
  ,tabPanel("Pie chart by System and Interface",

           #fluidPage(

           # Application title
           #titlePanel(),

           # Sidebar with a slider input for number of bins
           sidebarLayout(
             sidebarPanel(
               selectInput("scenario2", "Choose a Scenario:",
                           choices = Scenarios),
               selectInput("scope2", "Choose a Scope:",
                           choices = Scopes),
               selectInput("period2", "Choose a Period:",
                           choices = Periods),
               selectInput("interface2", "Choose an Interface:",
                           choices = Interfaces)

             ),
             mainPanel(
               plotOutput("PiePlotSystem")
             )
           )
  )

  #end of Tab
  #
  #New tab with pie chart  Processots-Interfaces
  ,tabPanel("Pie chart by Processors and Interface",

            #fluidPage(

            # Application title
            #titlePanel(),

            # Sidebar with a slider input for number of bins
            sidebarLayout(
              sidebarPanel(

                selectInput("scenario3", "Choose a Scenario:",
                            choices = Scenarios),
                selectInput("scope3", "Choose a Scope:",
                            choices = Scopes),
                selectInput("period3", "Choose a Period:",
                            choices = Periods),
                selectInput("interface3", "Choose an Interface:",
                            choices = Interfaces),
                checkboxGroupInput("ProcessorsChoice", "Processors to compare:",
                                   choiceNames = Processors, choiceValues = Processors, selected = Processors[1])

              ),
              mainPanel(
                plotOutput("PiePlotProcessors")
              )
            )
  )

  # end of Tab




    # New tab Var Chart
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

  #New tab EUM
  #TODO use fluid row https://shiny.rstudio.com/gallery/basic-datatable.html
  ,tabPanel("EUM",
            sidebarLayout(
              sidebarPanel(
                numericInput("Population", "Population", 100000),
                selectInput("FundInterface", "Choose a Fund InterfaceType:",
                            choices = FundInterfaces,selected = FundInterfaces[1]),
                selectInput("ScopeChoice", "Choose a Scope:",
                            choices = Scopes, selected = Scopes[1]),
                selectInput("ScenarioChoice", "Choose a Scenario:",
                            choices = Scenarios),
                selectInput("PeriodChoice", "Choose a Period:",
                            choices = Periods, selected = Periods[length(Periods)]),
                selectInput("SystemChoice", "Choose a System:",
                            choices = Systems, selected = Systems[1]),
                checkboxGroupInput("show_Interfaces", "Choose a flow InterfaceType to show:",
                                   choiceNames = FlowInterfaces, choiceValues = FlowInterfaces, selected = Interfaces[1])
              ),

                mainPanel(
                  #tableOutput("eum")
                  DT::dataTableOutput("eum")
              )
            )
  ) #end tab


  #New tab EUM Excel
  ,tabPanel("EUM2",
            sidebarLayout(
              sidebarPanel(
                numericInput("Population2", "Population", 100000),
                selectInput("FundInterface2", "Choose a Fund InterfaceType:",
                            choices = FundInterfaces, selected = FundInterfaces[1]),
                selectInput("ScopeChoice2", "Choose a Scope:",
                            choices = Scopes, selected = Scopes[1]),
                selectInput("ScenarioChoice2", "Choose a Scenario:",
                            choices = Scenarios, selected = Scenarios[1]),
                selectInput("PeriodChoice2", "Choose a Period:",
                            choices = Periods, selected = Periods[length(Periods)]),
                selectInput("SystemChoice2", "Choose a System:",
                            choices = Systems, selected = Systems[1]),
                checkboxGroupInput("show_Interfaces2", "Choose a flow InterfaceType to show:",
                                   choiceNames = FlowInterfaces, choiceValues = FlowInterfaces, selected = Interfaces[1])
              ),

              mainPanel(
                excelOutput("eum2")
              )
            )
  ) #end tab

  #
  # ,tabPanel("boxplot",
  #           sidebarLayout(
  #             sidebarPanel(
  #               numericInput("Population", "Population", 100000),
  #               selectInput("FundInterface", "Choose a Fund InterfaceType:",
  #                           choices = FundInterfaces,selected = FundInterfaces[1]),
  #               selectInput("ScopeChoice", "Choose a Scope:",
  #                           choices = Scopes, selected = Scopes[1]),
  #               selectInput("ScenarioChoice", "Choose a Scenario:",
  #                           choices = Scenarios),
  #               selectInput("PeriodChoice", "Choose a Period:",
  #                           choices = Periods, selected = Periods[length(Periods)]),
  #               selectInput("SystemChoice", "Choose a System:",
  #                           choices = Systems, selected = Systems[1]),
  #               checkboxGroupInput("show_Interfaces", "Choose a flow InterfaceType to show:",
  #                                  choiceNames = FlowInterfaces, choiceValues = FlowInterfaces, selected = Interfaces[1]),
  #               checkboxGroupInput("ProcessorsChoice", "Processors to compare:",
  #                                  choiceNames = Processors, choiceValues = Processors, selected = Processors[1]),
  #               selectInput("Indicatorshow", "Choose a System:",
  #                           choices = Indicators, selected = Indicators[1]),
  #             ),
  #
  #             mainPanel(
  #
  #               plotOutput("boxplot")
  #             )
  #           )
  # )



  # New tab tree
  ,tabPanel("Tree",
            sidebarLayout(
              sidebarPanel(
                #TODO use fluid row https://shiny.rstudio.com/gallery/basic-datatable.html
                selectInput("Scope2", "Choose a Scope:",
                            choices = Scopes),
                selectInput("Period2", "Choose a Period:",
                            choices = Periods)
              ),

              mainPanel(
                collapsibleTreeOutput("Tree")
              )
            )
  ) #end tab


  # New tab tree with quantities
  ,tabPanel("TreeInterface",
            sidebarLayout(
              sidebarPanel(
                selectInput("Scope", "Choose a Scope:",
                            choices = Scopes),
                selectInput("Period", "Choose a Period:",
                            choices = Periods),
                selectInput("Interface", "Choose an Interface:",
                            choices = Interfaces),
                h3(textOutput("Unit"))
              ),

              mainPanel(
                collapsibleTreeOutput("TreeInterface")
              )
            )
  ) #end tab
  
  )
)