#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("TBL App"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         textInput(
           "ratsnumber",
           "Enter the RAT id number:"
         ),
         textInput(
           "usernumber",
           "Enter your usernumber:"
         ),
         actionButton(
           "actionButton",
           "Take RAT"
         )
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        radioButtons("optionChoice",
                     "label",
                     choices = c("Choice A", "Choice B", "Choice C", "Choice D")
        )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   


  }

# Run the application 
shinyApp(ui = ui, server = server)

