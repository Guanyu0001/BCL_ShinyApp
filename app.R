#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
bcl <- read.csv("bcl-data.csv")
options(shiny.autoreload=T)


# define areas for output. note that order matters.
ui <- fluidPage(
    titlePanel("BCL app"),
    "Expanation goes here.",
    tags$br(),
    tags$br(),
    sidebarLayout(
        sidebarPanel(
          sliderInput("my_slider","Select a price range", max = 200, min= 0, value = c(10,30)),
          radioButtons("my_radio","Select beverage type:" ,
               choices = unique(bcl$Type))
                ),

        mainPanel(
          plotOutput("my_plot"),
          tableOutput("my_table"))
    )

)

# do the analysis for the output
server <- function(input, output) {

  filtered <- reactive({
    # print(input$my_slider)# use a curly bracket to input two arguments into reactive() which required only one input.
    # print(input$my_radio)
    bcl %>%
    filter(Price<=input$my_slider[2],
         Price>=input$my_slider[1],
         Type == input$my_radio)
    }
  )

   output$my_plot <- renderPlot(
     filtered() %>%
           ggplot(aes(Alcohol_Content))+
               geom_histogram()
   )

  output$my_table <- renderTable(
  filtered()
    )




}

# Run the application
shinyApp(ui = ui, server = server)
