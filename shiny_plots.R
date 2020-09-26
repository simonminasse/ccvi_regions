
#### Building RShiny App

setwd("/Users/simonminasse/GitAndR/ccvi_regions")

library(tidyverse)
library(readxl)
library(RColorBrewer)
library(wesanderson)

load('/Users/simonminasse/GitAndR/ccvi_regions/regional_plots.RData')

library(shiny)

ui <- fluidPage(
   
   # Application title
   titlePanel("CCVI U.S. Regional Data"),
   
   # Sidebar with input for CCVI Indicator 
   sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "variable", label = "Indicator:", 
                    choices = 
                      c("Socioeconomic Status" = "theme_1",
                        "Household Composition & Disability" = "theme_2",
                        "Minority Status & Language" = "theme_3",
                        "Housing Type & Transportation" = "theme_4",
                        "Epidemiologic Factors" = "theme_5",
                        "Healthcare System Factors" = "theme_6",
                        "Overall CCVI Score" = "ccvi_score"), multiple = FALSE),
        
        helpText("Select from the six themes / indicators that were used to calculate the CCVI Score.", 
                 "A higher score indicates higher vulnerability.")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("barPlot")
      )
   )
)

server <- function(input, output) {
  
   output$barPlot <- renderPlot({
     
      # plot ccvi mean / median side-by-side
      ggplot(data = rg_data, aes(x = region, y = unlist(rg_data[,input$variable]), fill = value)) + 
        geom_col(position = position_dodge(), color = 'black', lwd = 0.8) + 
        scale_fill_brewer(palette="Greens") +
        geom_text(aes(label=unlist(rg_data[,input$variable])), position = position_dodge(width = 0.9),
                  vjust=-0.5, size=4) +
        theme_minimal() +
        ylab('Scores') +
        xlab('U.S. Region') +
        ggtitle('Mean / Median Scores across U.S. Regions')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

