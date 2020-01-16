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
     
     # New tab with file input and table display -----
     tabPanel("CHOOSE YOU INPUT FILE ",
              sidebarLayout(
                sidebarPanel(
                  fileInput('target_upload', 'Choose file to upload',
                            accept = c(
                              'text/csv',
                              'text/comma-separated-values',
                              '.csv'
                            )),
                  radioButtons("separator","Separator: ",choices = c(";",",",":"), selected=";",inline=TRUE),
                  actionButton("act","click to update dataset input"),
                  br()
                  
                ),
                mainPanel(
                  DT::dataTableOutput("sample_table")
                )
              )
     )
     #end of Tab                
           
     # New tab with pie chart Levels-Interfaces ----
  ,tabPanel("Pie chart by level and Interface",
          sidebarLayout(
          sidebarPanel(
            #selectInput("scenario", "Choose a Scenario:",
            #            choices = Scenarios),
            uiOutput('scenario'),
            #selectInput("scope", "Choose a Scope:",
            #            choices = Scopes),
            uiOutput('scope'),
            #selectInput("period", "Choose a Period:",
            #            choices = Periods),
            uiOutput('period'),
            #selectInput("level", "Choose a level:",
            #            choices = Level),
            uiOutput('level'),
            #selectInput("interface", "Choose an Interface:",
            #            choices = Interfaces),
            uiOutput('interface')

          ),
          mainPanel(
            plotOutput("PiePlot")
          )
        )
  )

    #end of Tab

  # New tab with pie chart Systems-Interfaces -----
  ,tabPanel("Pie chart by System and Interface",
           sidebarLayout(
             sidebarPanel(
               # selectInput("scenario2", "Choose a Scenario:",
               #             choices = Scenarios),
               uiOutput("scenario2"),
               # selectInput("scope2", "Choose a Scope:",
               #             choices = Scopes),
               uiOutput("scope2"),
               # selectInput("period2", "Choose a Period:",
               #             choices = Periods),
               uiOutput("period2"),
               # selectInput("interface2", "Choose an Interface:",
               #             choices = Interfaces)
               uiOutput("interface2")

             ),
             mainPanel(
               plotOutput("PiePlotSystem")
             )
           )
  )

  #end of Tab

  #New tab with pie chart  Processots-Interfaces -----
  ,tabPanel("Pie chart by Processors and Interface",
            sidebarLayout(
              sidebarPanel(
# 
#                 selectInput("scenario3", "Choose a Scenario:",
#                             choices = Scenarios),
#                 selectInput("scope3", "Choose a Scope:",
#                             choices = Scopes),
#                 selectInput("period3", "Choose a Period:",
#                             choices = Periods),
#                 selectInput("interface3", "Choose an Interface:",
#                             choices = Interfaces),
#                 checkboxGroupInput("ProcessorsChoice", "Processors to compare:",
#                                    choiceNames = Processors, choiceValues = Processors, selected = Processors[1])
                uiOutput("scenario3"),
                uiOutput("scope3"),
                uiOutput("period3"),
                uiOutput("interface3"),
                uiOutput("ProcessorsChoice")

              ),
              mainPanel(
                plotOutput("PiePlotProcessors")
              )
            )
  )

  # end of Tab




    # New tab Var Chart (not in use) ----
    # ,tabPanel("Plot",
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

# TAB 5 EUM -----
  #New tab EUM
  #TODO use fluid row https://shiny.rstudio.com/gallery/basic-datatable.html
  ,tabPanel("EUM",
            sidebarLayout(
              sidebarPanel(
                numericInput("Population", "Population", 100000),
                # selectInput("FundInterface", "Choose a Fund InterfaceType:",
                #             choices = FundInterfaces,selected = FundInterfaces[1]),
                # selectInput("ScopeChoice", "Choose a Scope:",
                #             choices = Scopes, selected = Scopes[1]),
                # selectInput("ScenarioChoice", "Choose a Scenario:",
                #             choices = Scenarios),
                # selectInput("PeriodChoice", "Choose a Period:",
                #             choices = Periods, selected = Periods[length(Periods)]),
                # selectInput("SystemChoice", "Choose a System:",
                #             choices = Systems, selected = Systems[1]),
                # checkboxGroupInput("show_Interfaces", "Choose a flow InterfaceType to show:",
                #                    choiceNames = FlowInterfaces, choiceValues = FlowInterfaces, selected = Interfaces[1])
                uiOutput("FundInterface"),
                uiOutput("ScopeChoice"),
                uiOutput("ScenarioChoice"),
                uiOutput("PeriodChoice"),
                uiOutput("SystemChoice"),
                uiOutput("show_Interfaces")
              ),

                mainPanel(
                  #tableOutput("eum") # FORMATO 1
                  #DT::dataTableOutput("eum") # FORMATO 2
                  excelOutput("eum") #FORMATO EXCEL
                  
              )
            )
  ) #end tab


  # box plot (no in use) ----
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



  # New tab tree ----
  ,tabPanel("Tree",
            sidebarLayout(
              sidebarPanel(
                # selectInput("Scope2", "Choose a Scope:",
                #             choices = Scopes),
                # selectInput("Period2", "Choose a Period:",
                #             choices = Periods)
                uiOutput("ScopeTree"),
                uiOutput("PeriodTree")
              ),

              mainPanel(
                collapsibleTreeOutput("Tree")
              )
            )
  ) #end tab


  # New tab tree with quantities ----
  ,tabPanel("TreeInterface",
            sidebarLayout(
              sidebarPanel(
                # selectInput("Scope", "Choose a Scope:",
                #             choices = Scopes),
                # selectInput("Period", "Choose a Period:",
                #             choices = Periods),
                # selectInput("Interface", "Choose an Interface:",
                #             choices = Interfaces),
                h3(textOutput("Unit")),
                uiOutput("ScopeTree2"),
                uiOutput("PeriodTree2"),
                uiOutput("InterfaceTree2")
                #uiOutput("UnitTree2")
              ),

              mainPanel(
                collapsibleTreeOutput("TreeInterface")
              )
            )
  ) #end tab
  
  )
)