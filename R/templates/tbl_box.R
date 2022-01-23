tbl_box <- function(name){
  ui <- paste0(
    "<div class = ''>
    <label>", name, "</label>
    </div>"
  )
  
  return(HTML(ui))
}
