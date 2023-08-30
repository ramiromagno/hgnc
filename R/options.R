
#' Enable disk-based caching of hgnc results
#'
#' @examples
#' use_cache_dir()
#'
#' @md
#' @export
use_cache_dir <- function(cache_dir = tools::R_user_dir('hgnc', 'cache')) {


  if (!is.null(cache_dir)) {
    assertthat::assert_that(
      rlang::is_scalar_character(cache_dir),
      dir.exists(cache_dir) || dir.create(cache_dir)
    )
  }

  message('using hgnc cache dir: ', cache_dir)
  options('hgnc.cache_dir' = cache_dir)
}


#' Get HGNC cache directory
#'
#' @return A character vector of length 1 or NULL
#'
#' @examples
#' get_cache_dir()
#'
#' @md
#' @export
get_cache_dir <- function() {

  cache_dir <- getOption('hgnc.cache_dir')

  if (!is.null(cache_dir)) {
    assertthat::assert_that(
      rlang::is_scalar_character(cache_dir),
      dir.exists(cache_dir) || dir.create(cache_dir)
    )
  }

  return(cache_dir)
}
