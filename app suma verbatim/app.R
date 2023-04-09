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
   titlePanel("Sumadora"),
   
   sidebarLayout(
      sidebarPanel(
        numericInput("sumand1",
                     "Primer sumand:",
                     value=1),
        numericInput("sumand2",
                     "Segon sumand:",
                     value=1)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         verbatimTextOutput("suma")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$suma <- renderPrint({
      # generar suma
      input$sumand1+input$sumand2
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

