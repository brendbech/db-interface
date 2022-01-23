logpanel_UI <- function(id, log_height = "100px") {
  ns <- NS(id)
  autoscroll_JS <- paste0(
    "$(document).ready(function(){
      var objDiv = document.getElementById('", ns("process_log"), "');
      // create an observer instance
      var observer = new MutationObserver(function(mutations) {
        objDiv.scrollTop = objDiv.scrollHeight - objDiv.clientHeight;
      });
      // configuration of the observer
      var config = {childList: true};
      // observe objDiv
      observer.observe(objDiv, config);
    })"
  )
  
  tagList(
    tags$head(
      tags$script(HTML(autoscroll_JS)),
      tags$style(paste0("#", ns("process_log"),
                        "{overflow-y:scroll; min-height: ", log_height, ";}"))
    ),
    verbatimTextOutput(ns("process_log"))
  )
}

logpanel <- function(id, rv = NULL){
  moduleServer(
    id,
    function(input, output, session){
      output$process_log <- renderText({
        rv$message
      },
      sep = "\n")
    } #function(input, output, session)
  ) # moduleServer
} #logpanel
