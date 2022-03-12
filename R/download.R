download <- function(url, dir = getwd()) {

  my_tmp_file <- tempfile()
  fil <- httr::GET(url = url, httr::write_disk(my_tmp_file), httr::progress())

  fname <- stringr::str_match(httr::headers(fil)$`content-disposition`, "\"(.*)\"")[2]
  dest_filename <- file.path(dir, fname)
  file.copy(my_tmp_file, dest_filename)

  return(dest_filename)
}
