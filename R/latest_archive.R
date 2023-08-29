
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
#'
#' @return A string with the latest HGNC archive URL.
#'
#' @examples
#' latest_archive_url()
#'
#' @md
#' @export
#' @importFrom rlang .data
latest_archive_url <- function(type = c('tsv', 'json')) {

  type <- match.arg(type)
  basename <- 'hgnc_complete_set'
  extension <- ifelse(type == 'tsv', 'txt', 'json')
  filename <- paste0(basename, '.', extension)
  url <- paste0(ftp_base_url(), type, '/', filename)
  # allow memoisation to recognise new updates
  attr(url, 'last_update') <- last_update()

  return(url)
}

#' Latest HGNC monthly URL
#'
#' @return A string with the latest HGNC monthly archive URL.
#'
#' @examples
#' latest_monthly_url()
#'
#' @md
#' @export
#' @importFrom rlang .data
latest_monthly_url <- function() {

  url <-
    list_archives() %>%
    dplyr::filter(.data$series == 'monthly',
                  .data$dataset == 'hgnc_complete_set') %>%
    dplyr::arrange(date) %>%
    dplyr::pull(url) %>%
    dplyr::last()

  stopifnot(length(url) == 1)

  return(url)
}

#' Latest HGNC quarterly URL
#'
#' @return A string with the latest HGNC monthly archive URL.
#'
#' @examples
#' latest_quarterly_url()
#'
#' @md
#' @export
#' @importFrom rlang .data
latest_quarterly_url <- function() {

  url <-
    list_archives() %>%
    dplyr::filter(.data$series == 'quarterly',
                  .data$dataset == 'hgnc_complete_set') %>%
    dplyr::arrange(date) %>%
    dplyr::pull(url) %>%
    dplyr::last()

  stopifnot(length(url) == 1)

  return(url)
}
