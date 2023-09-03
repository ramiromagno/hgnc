
#' Enable disk-based caching of hgnc results
#'
#' @param cache_dir The cache directory to use
#' @examples use_cache_dir()
#'
#' @export
use_cache_dir <- function(cache_dir = tools::R_user_dir('hgnc', 'cache')) {


  if (!is.null(cache_dir)) {
    stopifnot(
      rlang::is_scalar_character(cache_dir),
      dir.exists(cache_dir) || dir.create(cache_dir)
    )
    message('using hgnc cache dir: ', cache_dir)
  }

  options('hgnc.cache_dir' = cache_dir)
}


#' Get HGNC cache directory
#'
#' @return A character vector of length 1 or NULL
#'
#' @examples
#' get_cache_dir()
#'
#' @export
get_cache_dir <- function() {

  cache_dir <- getOption('hgnc.cache_dir')

  if (!is.null(cache_dir)) {
    stopifnot(
      rlang::is_scalar_character(cache_dir),
      dir.exists(cache_dir) || dir.create(cache_dir)
    )
  }

  return(cache_dir)
}

#' Set the HGNC TSV file to use for [import_hgnc_dataset()].
#' Defaults to the [latest_archive_url()], but can also use [latest_monthly_url()] or [latest_quarterly_url()]`
#' @param file A file or URL of the complete HGNC data set (in TSV format).
#' @examples
#' # use the default file given by import_hgnc_dataset()
#' use_hgnc_file()
#'
#' # use to the latest monthly release
#' use_hgnc_file(file = latest_monthly_url())
#'
#' # use a predefined release for reproducibility
#' use_hgnc_file(file = "https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/archive/monthly/tsv/hgnc_complete_set_2023-08-01.txt")
#' @export
use_hgnc_file <- function(file = latest_archive_url()) {


  if (!is.null(file)) {
    stopifnot(
      rlang::is_scalar_character(file)
    )
    message('using hgnc file: ', file)
  }

  options('hgnc.file' = file)
}

#' Get HGNC TSV file in use
#'
#' @return A character vector of length 1 or NULL
#'
#' @examples
#' get_hgnc_file()
#'
#' @export
get_hgnc_file <- function() {

  file <- getOption('hgnc.file')

  if (is.null(file)) {
    use_hgnc_file()
    file <- getOption('hgnc.file')
  }

  if (!is.null(file)) {
    stopifnot(
      rlang::is_scalar_character(file)
    )
  }

  return(file)
}

