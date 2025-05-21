#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Sumador"),

    # Sidebar 
    sidebarLayout(
        sidebarPanel(
            sliderInput("sumand1",
                        "Primer número:",
                        min = 0,
                        max = 50,
                        value = 30),
            numericInput("sumand2",
                         "Segon número:",
                         value=0),
            submitButton(text="Aplicar")
        ),

        # Main plot
        mainPanel(
           p("La suma és", strong(textOutput("suma1", inline=TRUE))),
           verbatimTextOutput("suma2"),
           plotOutput("barplot")
        )
    )
)

# Define server logic
server <- function(input, output) {
  
    suma <- reactive({input$sumand1+input$sumand2})

    output$suma1 <- renderText({
        suma()
    })
    
    output$suma2 <- renderPrint({
      suma()
    })
    
    output$barplot <- renderPlot(
      barplot(c(input$sumand1, input$sumand2, suma()))
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)
