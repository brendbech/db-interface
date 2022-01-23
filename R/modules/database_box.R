database_box_UI <- function(id, ui = NULL) {
  stopifnot(!is.null(ui))
  ns <- NS(id)
  tagList(
    actionButton(
      inputId = ns("click"),
      label = HTML(ui),
      class = "dbBox"
    )
  )
}

database_box <- function(input, output, session, id, ui = NULL){
  
  observeEvent(input$click, {
    address <- session$ns("x") %>% str_split(., pattern = "-", simplify = TRUE) %>% .[,2]
    ui$address <- str_c(ui$address, "/", address)
    print(ui$address)
    
  })
} #function(input, output, session)