cut_address <- function(full_address, address){
  stopifnot(str_detect(full_address, address))
  x <- str_split(full_address, address, simplify = TRUE) %>% 
    .[1, 1]
  if(str_detect(x, "/$")){
    x <- x %>% str_c(., address)
  } else {
    x <- x %>% str_c(., "/", address)
  }
  return(x)
}

