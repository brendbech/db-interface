address_link_UI <- function(id) {
  ns <- NS(id)
  label <- str_split(id, "-", simplify = TRUE) %>% .[1, 2]
  tagList(
    actionLink(ns("link"),
               label = label)
  )
}

address_link <- function(input, output, session, id, ui = NULL, address = NULL){
  observeEvent(input$link, {
    validate(
      need(str_detect(ui$address, address), "New address not available")
    )

    ui$address <- cut_address(
      full_address = ui$address,
      address = address)
  })
} #function(input, output, session)
