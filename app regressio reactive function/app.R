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
   titlePanel("Regressió"),
   
   sidebarLayout(
      sidebarPanel(
        numericInput("n",
                     "Mida de la mostra:",
                     value=1),
        numericInput("sx",
                     "sx:",
                     value=1),
        numericInput("sy",
                     "sy:",
                     value=1),
        sliderInput("r",
                    "Correlació:",
                    value=0,
                    min=-1,
                    max=1,
                    step=.01)
      ),
      
      # Show a plot 
      mainPanel(
         plotOutput("grafic"),
         verbatimTextOutput("sumari")
      )
   )
)

# Functions and non reactive values used in server

genera_mostra <- function(sx, sy, r, n) {
  sxy <- sx*sy*r
  b <- sxy/(sx)^2
  x <- rnorm(n,0,sx)
  serr <- sqrt(1-r^2)*sy
  errors <- rnorm(n,0,serr)
  y <- x*b+errors
  return(data.frame(x,y))
}

# Define server logic  
server <- function(input, output) {

   mostra <- reactive({
     genera_mostra(input$sx, input$sy, input$r, input$n)
   })
   
   model <- reactive({
     lm(y~x, data=mostra())
   })
     
   output$grafic <- renderPlot({
      # generar mostra
     plot(mostra()$x,mostra()$y)
   })
   
   output$sumari <- renderPrint({
      summary(model())
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

