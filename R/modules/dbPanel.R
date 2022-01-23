dbPanel_UI <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("container"))
  )
}

dbPanel <- function(id, ui = NULL){
  moduleServer(
    id,
    function(input, output, session){
      rv <- reactiveValues(
        boxes = list(
          db = list(),
          tbl = list()
        ),
        modules = list()
      )
      
      output$container <- renderUI({
        tagList(
          rv$boxes$db,
          rv$boxes$tbl
        )
      })
      
      observeEvent(ui$address, {
        validate(
          need(!is.null(ui$address), "address cannot be NULL"),
          need(file.exists(paste0(getwd(), "/", ui$address)), "Address is not available")
        )
        ns <- session$ns
        rv$boxes <- list()
        boxes <- parse_address(address = ui$address,
                               root = getwd())
        if(length(rv$modules) > 0){
          lapply(rv$module, FUN = function(x){x$destroy()})
        }
        
        for(name in names(boxes$db)){
          rv$boxes$db[[name]] <- database_box_UI(id = ns(name),
                                                 ui = boxes$db[[name]]
          )
          
          eval(
            parse(
              text = paste0(
                "rv$modules[[name]] <- callModule(module = database_box,
                          id = '", name, "',
                          ui = ui)"
              )
            )
          )
          
          # rv$modules[[name]] <- callModule(module = database_box,
          #                 id = name,
          #                 ui = ui)
        }
        
        for(name in names(boxes$tbl)){
          rv$boxes$tbl[[name]] <- table_box_UI(id = ns(name),
                                               ui = boxes$tbl[[name]]
          )
          eval(
            parse(
              text = paste0(
                "rv$modules[[name]] <- callModule(module = table_box,
                          id = '", name, "',
                          ui = ui)"
              )
            )
          )
          # rv$modules[[name]] <- callModule(module = table_box,
          #                 id = name,
          #                 ui = ui)
        }
      })
      
    } #function(input, output, session)
  ) # moduleServer
} #dbPanel
