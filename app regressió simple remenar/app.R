#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

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
         plotOutput("grafic")
      )
   )
)


genera_mostra <- function(sx, sy, r, rx, rerr) {
  sxy <- sx*sy*r
  b <- sxy/(sx)^2
  x <- rx*sx
  serr <- sqrt(1-r^2)*sy
  errors <- rerr*serr
  y <- x*b+errors
  data.frame(x,y)
  
}

# Define server logic
server <- function(input, output) {
  
  rer <- reactive({
    rnorm(input$n,0,1)
  })

  rx <- reactive({
    rnorm(input$n,0,1)
  })
  
  mostra <- reactive({
    genera_mostra (input$sx, input$sy, input$r, rx(), rer())
  })
  
     
   output$grafic <- renderPlot({
      # generar mostra
     plot(y~x, data=mostra())
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

