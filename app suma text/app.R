#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application 
ui <- fluidPage(
   
   # Application title
   titlePanel("Sumadora"),
   
   # Sidebar 
   sidebarLayout(
      sidebarPanel(
        numericInput("sumand1",
                     "Primer sumand:",
                     value=1),
        numericInput("sumand2",
                     "Segon sumand:",
                     value=1)
      ),
      
      # Show result
      mainPanel(
         textOutput("suma")
      )
   )
)

# Define server logic 
server <- function(input, output) {
   
   output$suma <- renderText({
      # generar suma
      input$sumand1+input$sumand2
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

