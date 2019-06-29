# TBL App
# 20190612_1207
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# devtools::install_github("paulc91/shinyauthr")
library(shinyauthr)
library(shinyjs)
library(readxl)
library(janitor)

# dataframe that holds usernames, passwords and other user data
user_base <- data.frame(
  user = c("user1", "user2"),
  password = c("pass1", "pass2"), 
  permissions = c("admin", "standard"),
  name = c("User One", "User Two"),
  stringsAsFactors = FALSE,
  row.names = NULL
)

question_data <- data.frame(
    stem = "question stem",
    options = c("Choice A","Choice B","Choice C","Choice D")
  )


# library(readxl)
# rats_data <- read_excel("C:/Users/chapmjs/Downloads/RATs-Chapter01-Questions_List.xlsx")
# View(rats_data)


rats_data <- read_excel("https://www.dropbox.com/s/sjlz6677z3v5ob7/RATs-Chapter01-Questions_List.xlsx?dl=1")
names(rats_data) <- clean_names(rats_data,"snake")


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("TBL App"),
   
   # Sidebar
   sidebarLayout(
      sidebarPanel(
        # must turn shinyjs on
        shinyjs::useShinyjs()
        # add logout button UI 
        # div(class = "pull-right", shinyauthr::logoutUI(id = "logout")),
        # add login panel UI function
        # shinyauthr::loginUI(id = "login")
      ),
      
      # main panel
      mainPanel(
#        if (credentials()$user_auth) {
          tabsetPanel(type = "tab",
                      tabPanel("RAT Questions",
                               radioButtons("question",
                                            question_data$stem,
                                            choices = question_data$options
                                            )
                      ),
                      tabPanel("Scores")
                      )
#        }
        )
      )
  )

# Define server logic required to draw a histogram
server <- function(input, output,session) {
  
  # call the logout module with reactive trigger to hide/show
  logout_init <- callModule(shinyauthr::logout, 
                            id = "logout", 
                            active = reactive(credentials()$user_auth))
  
  # call login module supplying data frame, user and password cols
  # and reactive trigger
  credentials <- callModule(shinyauthr::login, 
                            id = "login", 
                            data = user_base,
                            user_col = user,
                            pwd_col = password,
                            log_out = reactive(logout_init()))
  
  # pulls out the user information returned from login module
  user_data <- reactive({credentials()$info})
  
  

  
  
  # output$question <- renderText({
  #   req(credentials()$user_auth)
  #   question_data()
  #   
  # })


  }

# Run the application 
shinyApp(ui = ui, server = server)

