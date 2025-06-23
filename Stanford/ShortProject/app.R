# app.R

library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)

vehicles <- read.csv("Vehicles.csv", stringsAsFactors=FALSE)

vehicles <- vehicles %>%
  mutate(
    Year = with(vehicles, ifelse(Vehicle.Model.Year < 1900 | Vehicle.Model.Year > as.integer(format(Sys.Date(), "%Y")), 2014, Vehicle.Model.Year)), 
    Wheelchair.Accessible = factor(Wheelchair.Accessible, levels = c("N","Y"))
  )

ui <- fluidPage(
  titlePanel("Accessibility by Status"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "year",
        label   = "Select Year",
        min     = min(vehicles$Year, na.rm = TRUE),
        max     = max(vehicles$Year, na.rm = TRUE),
        value   = min(vehicles$Year, na.rm = TRUE),
        sep     = ""
      )
    ),
    mainPanel(
      plotOutput("barPlot")
    )
  )
)

server <- function(input, output, session) {
  filtered <- reactive({
    vehicles %>% filter(Year == input$year)
  })
  
  output$barPlot <- renderPlot({
    df <- filtered() %>%
      group_by(Status) %>%
      summarise(
        percent = mean(Wheelchair.Accessible == "Y", na.rm = TRUE) * 100,
        n       = n(),
        .groups = "drop"
      ) %>%
      filter(n > 10)
    
    ggplot(df, aes(x = Status, y = percent)) +
      geom_col() +
      labs(
        x     = "Status",
        y     = "Accessibility (%)",
        title = paste("Accessibility by Status in", input$year)
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1)
      )
  })
}

shinyApp(ui, server)

