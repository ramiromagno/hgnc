#' @importFrom rlang .data
latest_monthly_archive <- function(type = c('tsv', 'json')) {

  type <- match.arg(type)
  ftp_url <- rvest::url_absolute(x = paste0('monthly/', type, '/'), base = ftp_archive())

  tbl <- ftp_ls(ftp_url)

  tbl %>%
    dplyr::filter(.data$dataset == 'hgnc_complete_set') %>%
    dplyr::arrange(dplyr::desc(.data$datetime)) %>%
    dplyr::slice(1L)

}

#' @importFrom rlang .data
latest_monthly_archive_url <- function(type = c('tsv', 'json')) {

  type <- match.arg(type)

  url <- latest_monthly_archive(type = type) %>%
    dplyr::pull(.data$url)

  return(url)
}

#' @importFrom rlang .data
latest_archive <- function(type = c('tsv', 'json')) {

  type <- match.arg(type)
  basename <- 'hgnc_complete_set'
  extension <- ifelse(type == 'tsv', 'txt', 'json')
  filename <- paste0(basename, '.', extension)
  url <- paste0(ftp_base_url(), type, '/', filename)

  datetime <- last_update()

  tbl <-
    tibble::tibble(
      dataset = 'hgnc_complete_set',
      file = filename,
      datetime = datetime,
      date = as.Date(datetime),
      time = hms::as_hms(datetime),
      size = NA_integer_,
      url = url
    )

  return(tbl)

}

#' Latest HGNC archive URL
#'
#' @param type The format of the archive: `"tsv"` or `"json"`.
#' @export
#' @importFrom rlang .data
latest_archive_url <- function(type = c('tsv', 'json')) {

  type <- match.arg(type)
  basename <- 'hgnc_complete_set'
  extension <- ifelse(type == 'tsv', 'txt', 'json')
  filename <- paste0(basename, '.', extension)
  url <- paste0(ftp_base_url(), type, '/', filename)

  return(url)
}
