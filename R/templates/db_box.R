db_box <- function(name = NULL,
                   tables = NULL,
                   size = NULL){
  ui <- paste0(
    "<div>
    <label>", name, "</label>
    <ul style = 'list-style: none;'>
    <li>Tables: ", tables, "</li>
    <li>Size: ", size, "</li>
    </ul>
    </div>"
  )
  
  return(HTML(ui))
}
