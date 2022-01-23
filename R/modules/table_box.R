table_box_UI <- function(id, ui = NULL) {
  stopifnot(!is.null(ui))
  ns <- NS(id)
  tagList(
    actionButton(
      inputId = ns("click"),
      label = HTML(ui),
      class = "tblBox"
    )
  )
}

table_box <- function(input, output, session, id, ui = NULL){
  
} #function(input, output, session)