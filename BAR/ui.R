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
ui<-# table view of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel("Plot",fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("scenario", "Choose a Scenario:",
                        choices = Scenarios),
            selectInput("period", "Choose a Period:",
                        choices = Periods),
            selectInput("processor", "Choose a Processor:",
                        choices = Processors),
            checkboxInput("log_10","apply log10 to data",
                          value = FALSE)
        ),
            
            #TODO l should be variable with the filter
        #     checkboxGroupInput("checkGroup", label = h3("Interfaces"),
        #                        choices = l,
        #                        selected = names(l))
        # ),
        

        # Create a spot for the barplot
        mainPanel(
            plotOutput("BarPlot")  
        )
    
)
))))