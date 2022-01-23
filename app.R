source("init.R", encoding = "utf-8")

ui <- fluidPage(
  tags$head(
    tags$link(href = "modalstyle.css", type = "text/css", rel = "stylesheet"),
    tags$link(href = "boxstyle.css", type = "text/css", rel = "stylesheet"),
    tags$link(href = "dbPanel.css", type = "text/css", rel = "stylesheet")
  ),
  
  actionButton("browser", "browser"),
  dbPanel_UI("db")
)

server <- function(input, output, session) {
  ui <- reactiveValues(
    address = NULL
  )
  ui$address <- "Home"
  dbPanel("db", ui = ui)
  
  observeEvent(input$browser, {
    browser()
  })
}

shinyApp(ui, server)


