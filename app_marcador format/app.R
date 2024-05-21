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
   titlePanel("Marcador"),
   
   verticalLayout(
     strong(textOutput("marcador"), 
            style="font-size: 2000%;
            text-align: center;"),
     fluidRow(column(width = 12), 
              actionButton("golLocal","Gol local",style="margin: auto;"),
              actionButton("golVisitant","Gol visitant",style="margin: auto;"),
              actionButton("reset","Reset",style="margin: auto;")
              )
   )
)

# Define server logic 
server <- function(input, output) {
   
  punts <- reactiveValues(local=0,
                          visitant=0)

  observeEvent(input$golLocal, {
    punts$local <- isolate(punts$local)+1
  })
    
  observeEvent(input$golVisitant, {
    punts$visitant <- isolate(punts$visitant)+1
  })
  
  observeEvent(input$reset, {
    punts$local <- 0
    punts$visitant <- 0
  })
  
  output$marcador <- renderText({
     paste(punts$local,punts$visitant, sep = "-")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

