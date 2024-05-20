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
         span("Resultat",textOutput("suma"), 
              style="color:red; font-size:25px"), #style
         verbatimTextOutput("suma2"),
         plotOutput(("barra"))
      )
   )
)

# Define server logic 
server <- function(input, output) {
   
  output$suma <- renderText({
    # generar suma
    input$sumand1+input$sumand2
  })
  
  output$suma2 <- renderPrint({
    # generar suma
    cat(paste(input$sumand1,"+",input$sumand2, "=", input$sumand1+input$sumand2))
  })
  
  output$barra <- renderPlot(
     barplot(matrix(c(input$sumand1, input$sumand2)))
   )
   
}

# Run the application 
shinyApp(ui = ui, server = server)

