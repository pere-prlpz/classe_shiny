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
        
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("grafic")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$grafic <- renderPlot({
        sxy <- input$sx*input$sy*input$r
        b <- sxy/(input$sx)^2
        x <- rnorm(input$n,0,input$sx)
        serr <- sqrt(1-input$r^2)*input$sy
        errors <- rnorm(input$n,0,serr)
        y <- x*b+errors
        plot(y~x)
        if (input$n>1) {abline(lm(y~x),
                               col="green",
                               lty=2)}
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
