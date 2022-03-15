#' Filter genes by keyword
#'
#' Filter the HGNC data set by a keyword to be looked up in the columns
#' containing gene names or symbols. By default, it will look up in `symbol`,
#' `name`, `alias_symbol`, `alias_name`, `prev_symbol` and `prev_name`. Note
#' that this function in dive into list-columns and match return a hit result if
#' at least one of the strings matches the `keyword`.
#'
#' @param tbl A tibble containing the HGNC data set, typically obtained with `import_hgnc_dataset()`.
#' @param keyword A keyword or a regular expression to be used as search criterion.
#' @param cols Columns to be looked up.
#'
#' @return A [tibble][tibble::tibble-package] of the HGNC data set filtered by
#'   observations matching the `keyword`.
#'
#' @export
filter_by_keyword <-
  function(tbl,
           keyword,
           cols = c('symbol',
                    'name',
                    'alias_symbol',
                    'alias_name',
                    'prev_symbol',
                    'prev_name')) {

    dplyr::filter(tbl,
                  dplyr::if_any(.cols = cols,
                                str_detect2, pattern = keyword))
  }
