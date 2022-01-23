parse_address <- function(address = "Home",
                          root = getwd()){
  address_path <- paste0(root, "/", address)
  db <- do.call(file.info, list(path = dir(address_path, full.names = TRUE))) %>% 
    dplyr::filter(isdir)
  tbl <- do.call(file.info, list(path = dir(address_path, full.names = TRUE))) %>% 
    dplyr::filter(!isdir & str_detect(row.names(.), ".txt$"))
  
  ui <- list(
    db = list(),
    tbl = list()
  )
  rnames <- row.names(db)
  for(i in seq_along(db$size)){
    id <- last_address(rnames[i])
    ntables <- do.call(file.info, list(path = dir(rnames[i], full.names = TRUE))) %>% 
      dplyr::filter(!isdir & str_detect(row.names(.), ".txt$")) %>% dim(.) %>% .[1]
    ui$db[[id]] <- db_box(name = id,
                       tables = ntables,
                       size = db$size[i])
  }
  
  if(length(tbl) > 0){
    tnames <- row.names(tbl)
    for(i in seq_along(tbl$size)){
      id <- last_address(tnames[i])
      ui$tbl[[id]] <- tbl_box(id)
    }
  }
  return(ui)
}


