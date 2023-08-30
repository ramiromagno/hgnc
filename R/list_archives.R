#' List monthly and quarterly archives
#'
#' This function lists the monthly and quarterly archives currently available.
#'
#' @return A [tibble][tibble::tibble-package] of available archives for download.
#' @md
#' @export
# list_archives memoised in zzz.R
list_archives <- function(type = c('tsv', 'json')) {

  type <- match.arg(type)
  monthly_url <- rvest::url_absolute(paste0('monthly/', type, '/'), ftp_archive())
  quarterly_url <- rvest::url_absolute(paste0('quarterly/', type, '/'), ftp_archive())

  monthly_tbl <- ftp_ls(monthly_url) %>%
    dplyr::mutate(series = 'monthly', .before = 1L)

  quarterly_tbl <- ftp_ls(quarterly_url) %>%
    dplyr::mutate(series = 'quarterly', .before = 1L)

  dplyr::bind_rows(monthly_tbl, quarterly_tbl)

}
