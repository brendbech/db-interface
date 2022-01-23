dynamic_address <- function(address = NULL, root = getwd()){
  address_path <- paste0(root, "/", address)
  dirs <- str_split(address_path, "/", simplify = TRUE) %>% .[1, ]
}


address <- "Home/cooldatabase"
dirs <- str_split(address, "/", simplify = TRUE) %>% .[1, ]

for(i in seq_along(dirs)){
  
}
