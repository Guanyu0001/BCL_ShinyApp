library(shiny)
library(tidyverse)
library(DT)
bcl <- read.csv("bcl-data.csv")
options(shiny.autoreload = T)

ui <- fluidPage(
  titlePanel("BCL app"),
  "This is a interactive app to help user select beverages they like by types and prices. The results can be downloaded.",
  sidebarLayout(
    sidebarPanel(
      sliderInput("my_slider", "Select a price range", max = 200, min = 0, value = c(10, 30)), # the slider for selecting the price

      checkboxGroupInput("my_radio", "Select beverage type:",
        choices = unique(bcl$Type),
        selected = unique(bcl$Type)
      ), # checkbox for selecting the types of beverages

      checkboxInput("dscending", "Dscending by price", FALSE), # checkbox for soring the results

      verbatimTextOutput("value"), # for checking the output of checkboxInput

      textOutput("options"), # for providing the total number of options

      downloadButton("downloadData", "Download") # for downloading
    ),
    mainPanel(
      plotOutput("my_plot"), # for the histogram
      DT::dataTableOutput("my_table")
    ) # for the summary table
  ),
)

# do the analysis for the output
server <- function(input, output) {
  filtered <- reactive({
    # if-else is used for descending the results by user's choice
    if (input$dscending) {
      bcl %>%
        filter(
          Price <= input$my_slider[2],
          Price >= input$my_slider[1],
          Type %in% input$my_radio
        ) %>%
        arrange(desc(Price))
    } else {
      bcl %>%
        filter(
          Price <= input$my_slider[2],
          Price >= input$my_slider[1],
          Type %in% input$my_radio
        ) %>%
        arrange(Price)
    }
  })

  # get the histogram
  output$my_plot <- renderPlot(
    filtered() %>%
      ggplot(aes(Alcohol_Content)) +
      geom_histogram()
  )

  # get the table
  output$my_table <- DT::renderDataTable(filtered())

  output$value <- renderText(
    if (input$dscending) {
      print("The order is dscending by price.")
    } else {
      print("The order is ascending by price.")
    }
  ) # for checking the output of checkboxInput

  output$options <- renderText(paste("We found ", nrow(filtered()), " options for you.")) # providing the number of options

  # settings for download
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("BCL_selected_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(filtered(), file)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)
