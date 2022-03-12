ftp_base_url <- function() {
  'http://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/'
}

ftp_archive <- function() {
  paste0(ftp_base_url(), 'archive/')
}
