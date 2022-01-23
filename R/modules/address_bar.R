address_bar_UI <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(class = "addressBarContainer",
             uiOutput(ns("bar"))
    )
  )
}

address_bar <- function(id, ui = NULL){
  moduleServer(
    id,
    function(input, output, session){
      rv <- reactiveValues(
        address_links = list(),
        modules = list()
      )
      output$bar <- renderUI({
        tagList(rv$address_links)
      })
      
      observeEvent(ui$address, {
        rv$address_links <- list()
        if(length(rv$modules) > 0){
          lapply(rv$modules, FUN = function(x){x$destroy()})
        }
        validate(
          need(!is.null(ui$address), "address cannot be NULL"),
          need(file.exists(paste0(getwd(), "/", ui$address)), "Address is not available")
        )
        dirs <- str_split(ui$address, "/", simplify = TRUE) %>% .[1, ]
        
        for(i in seq_along(dirs)){
          rv$address_links[[dirs[i]]] <- address_link_UI(id = session$ns(dirs[i]))
          eval(
            parse(
              text = paste0(
                "rv$modules[[dirs[i]]] <- callModule(
            module = address_link,
            id = dirs[i],
            ui = ui,
            address = '", as.character(dirs[i]), "')"
              )
            )
          )
          
          # rv$modules[[dirs[i]]] <- callModule(
          #   module = address_link,
          #   id = dirs[i],
          #   ui = ui,
          #   address = dirs[i]
          # )
          
          
        }
      })
    } #function(input, output, session)
  ) # moduleServer
} #address_bar

