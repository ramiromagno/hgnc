ftp_base_url <- function() {
  'https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/'
}

ftp_archive <- function() {
  paste0(ftp_base_url(), 'archive/')
}
