db_connect_UI <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("modal"))
  )
}

db_connect <- function(id){
  moduleServer(
    id,
    function(input, output, session){
      rv <- reactiveValues(
        con = NULL,
        message = NULL
      )
      
      output$modal <- renderUI({
        ns <- session$ns
        showModal(
          modalDialog(
            tags$div(
              class = "modal-db",
              
                tags$strong("MS-SQL Credentials:"),
                textInput(ns("server"), "Server", value = "DESKTOP-VT1QO2N"),
                textInput(ns("user"), "User"),
                passwordInput(ns("password"), "Password"),
                actionButton(ns("connect"), "Login"),
                logpanel_UI(ns("log"))  
               
            ),
            title = "Connect to database",
            size = "s",
            
          )
        )
      })
      
      observeEvent(input$connect, {
        if(exists("con")){
          dbDisconnect(con)
          rm("con", envir = globalenv())
        }
        
        validate(
          need(input$server != "", message = "Need server name"),
          need(input$user != "", message = "Need user name"),
          need(input$password != "", message = "Need password")
        )
        
        insertUI(
          selector = paste0("#", session$ns("connect")),
          immediate = TRUE,
          where = "afterEnd",
          ui = includeHTML("./www/loading.html")
        )
        
        rv$message <- c(rv$message, "Checking if connection is possible\n")
        if(DBI::dbCanConnect(odbc::odbc(),
                             Driver = "{SQL Server}",
                             Server = input$server,
                             uid = input$user,
                             pwd = input$password,
                             encoding = "WINDOWS-1252")
        ) {
          rv$message <- c(rv$message, "Connection is possible\n")
          rv$message <- c(rv$message, "Connecting...\n")
          con <- DBI::dbConnect(odbc::odbc(),
                                Driver = "{SQL Server}",
                                Server = input$server,
                                uid = input$user,
                                pwd = input$password,
                                encoding = "WINDOWS-1252")
        } else {
          con <- NULL
          rv$message <- c(rv$message, "Connection could not be made\n")
        }
        
        if(class(con) == "Microsoft SQL Server"){
          rv$con <- con
          removeModal()
          
        }
        removeUI(selector = ".loading",
                 immediate = TRUE)
      })
      
      logpanel(id = "log", rv = rv)
      
      return(rv)
      
    } #function(input, output, session)
  ) # moduleServer
} #db_connect
