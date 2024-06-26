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

# Define UI for application that draws a histogram
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
                    step=.01),
        submitButton(text="Aplicar")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("Gràfics base",
                   plotOutput("grafic"),
                   verbatimTextOutput("sumari"),
                   verbatimTextOutput("sumariDades")
          ),
          tabPanel("ggplot2",
                   plotOutput("ggrafic"),
                   verbatimTextOutput("sumari2")),
          tabPanel("Ajuda",
                   h1("Informació"),
                   p("Aquesta aplicació ajuda a visualitzar la regressió lineal
                     amb un sol predictor."),
                   p("Feu servir els controls de l'esquerra per canvir la mostra."),
                   h2("Detalls"),
                   p(strong("n"),": mida de la mostra"),
                   p(strong("r"),": correlació de la població"))
        )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   mostra <- reactive({
     sxy <- input$sx*input$sy*input$r
     b <- sxy/(input$sx)^2
     x <- rnorm(input$n,0,input$sx)
     serr <- sqrt(1-input$r^2)*input$sy
     errors <- rnorm(input$n,0,serr)
     y <- x*b+errors
     data.frame(x,y)
   })
   
   model <- reactive({
     lm(y~x, data=mostra())
   })
     
   output$grafic <- renderPlot({
     plot(y~x, data=mostra())
     if (input$n>1) {abline(model(),
                            col="green",
                            lty=2)}
   })
   
   output$sumari <- renderPrint({
     summary(model())
   })

   output$sumariDades <- renderPrint({
     summary(mostra())
   })
   
   output$ggrafic <- renderPlot({
     ggplot(mostra())+
       geom_point(aes(x,y))+
       geom_smooth(method="lm", aes(x,y))
   })
   
   output$sumari2 <- renderPrint({
     summary(model())
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

