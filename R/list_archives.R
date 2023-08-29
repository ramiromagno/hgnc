#' List monthly and quarterly archives
#'
#' This function lists the monthly and quarterly archives currently available.
#'
#' @return A [tibble][tibble::tibble-package] of available archives for download.
#' @md
#' @export
list_archives <- function() {

  monthly_url <- rvest::url_absolute('monthly/tsv/', ftp_archive())
  quarterly_url <- rvest::url_absolute('quarterly/tsv/', ftp_archive())

  monthly_tbl <- ftp_ls(monthly_url) %>%
    dplyr::mutate(series = 'monthly', .before = 1L)

  quarterly_tbl <- ftp_ls(quarterly_url) %>%
    dplyr::mutate(series = 'quarterly', .before = 1L)

  dplyr::bind_rows(monthly_tbl, quarterly_tbl)

}
