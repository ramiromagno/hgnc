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
#' @examples
#' \dontrun{
#' # Start by retrieving the HGNC data set
#' hgnc_tbl <- import_hgnc_dataset()
#'
#' # Search for entries containing "TP53" in the HGNC data set
#' hgnc_tbl %>%
#'   filter_by_keyword('TP53') %>%
#'   dplyr::select(1:4)
#'
#' # The same as above but restrict the search to the `symbol` column
#' hgnc_tbl %>%
#'   filter_by_keyword('TP53', cols = 'symbol') %>%
#'   dplyr::select(1:4)
#'
#' # Match "TP53" exactly in the `symbol` column
#' hgnc_tbl %>%
#'   filter_by_keyword('^TP53$', cols = 'symbol') %>%
#'   dplyr::select(1:4)
#'
#' # `filter_by_keyword()` is vectorised over `keyword`
#' hgnc_tbl %>%
#'   filter_by_keyword(c('^TP53$', '^PIK3CA$'), cols = 'symbol') %>%
#'   dplyr::select(1:4)
#' }
#'
#' @md
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

  purrr::map_dfr(keyword, .f = filter_by_keyword_, tbl = tbl, cols = cols)
  }


filter_by_keyword_ <-
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
