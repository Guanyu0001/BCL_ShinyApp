library(shiny)
library(tidyverse)
library(DT)
bcl <- read.csv("bcl-data.csv")
options(shiny.autoreload = T)

ui <- fluidPage(
  titlePanel("BCL app"),
  "This is a interactive app to help users select beverages they like by types and prices. There are three functions can help reader select the beverages: 
  1. select the price range, 2. select beverage type, and 3. Sort the results. Textboxes can help users check inputs. The filtered records are visualized by a histgram and a table.
  The filtered records can be downloaded. Thank your for trying this app. Feel free to let me know if you have any questions.",
  br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("my_slider", "Select a Price Range:", max = 200, min = 0, value = c(10, 30)), # the slider for selecting the price
      verbatimTextOutput("price_range_selected"),
      br(),

      # checkbox for selecting the types of beverages
      checkboxGroupInput("my_radio", "Select Beverage Type:",
        choices = unique(bcl$Type),
        selected = unique(bcl$Type)
      ),
      verbatimTextOutput("beverage_type_selected"),
      br(),

      # checkbox for sorting the results
      strong("Order of Results:"),
      checkboxInput("descending", "Descending by price", FALSE),
      verbatimTextOutput("value"),
      br(),

      # for providing the total number of options
      strong("Filtered Results:"),
      verbatimTextOutput("options"),
      br(),

      # for downloading
      strong("Download Filtered Results:"),
      downloadButton("downloadData", "Download")
    ),
    mainPanel(
      plotOutput("my_plot"), # for the histogram
      DT::dataTableOutput("my_table") # for the summary table
    )
  ),
)

# do the analysis for the output
server <- function(input, output) {
  filtered <- reactive({
    # if-else is used for descending the results by user's choice
    if (input$descending) {
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
    if (input$descending) {
      paste("The order is descending by price.")
    } else {
      paste("The order is ascending by price.")
    }
  )

  # for demonstrating the inputs:
  # display the selected price range for beverages
  output$price_range_selected <- renderText(paste("The beverages from", input$my_slider[1],"CAD", "to", input$my_slider[2], "CAD were selected."))
  # display the selected types of beverages
  output$beverage_type_selected <- renderText(paste(paste(input$my_radio, collapse = " "), "were selected."))
  # providing the number of options
  output$options <- renderText(paste("We found ", nrow(filtered()), " options for you."))

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
