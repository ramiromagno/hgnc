
# return a table that maps from a key column to another columns in the hgnc_dataset
get_hgnc_key_table <- function(key,
                               column,
                               one_to_many = FALSE,
                               file = get_hgnc_file()) {

  key_table <-
    import_hgnc_dataset(file = file) %>%
    dplyr::select(key = dplyr::all_of(key),
                  column = dplyr::all_of(column)) %>%
    (function(x) `if`(key %in% hgnc_list_cols, tidyr::unchop(x, key), x)) %>%
    (function(x) `if`(column %in% hgnc_list_cols, tidyr::unchop(x, column), x)) %>%
    dplyr::filter(!is.na(key)) %>%
    dplyr::distinct()


  if (one_to_many) {

    key_table <- tidyr::chop(key_table, column)

  } else {

    key_table <-
      key_table %>%
      dplyr::add_count(key, name = 'nkey') %>%
      dplyr::filter(nkey == 1) %>%
      dplyr::select(-nkey)

  }

  key_table <-
    key_table %>%
    dplyr::rename_with(.fn = ~ key, .cols = key) %>%
    dplyr::rename_with(.fn = ~ column, .cols = column)
}

#' Add a column to a data frame from the hgnc dataset
#'
#' @param .data The data frame to join with
#' @param by The column to join by, as in [dplyr::left_join()]
#' @param column The column to add to the data frame from the HGNC dataset
#' @param one_to_many A boolean value indicating whether cases where the 'by' column maps to multiple valuesof the selected column should be returned.
#'  If set to `FASLE` (the default), such one-to-many cases will yield NA. If set to `TRUE`, the returned column will be a list of vectors of varying length.
#' @param file A file or URL of the complete HGNC data set (in TSV format), as used by [import_hgnc_dataset()].
#' @return A data frame with the HGNC column added
#' @examples
#' \dontrun{
#'library(dplyr)
#'df <- tibble(hgnc_id = c("HGNC:44948", "HGNC:43240", "HGNC:23357", "HGNC:1855", "HGNC:39400"))
#'
#'df %>%
#'  hgnc_join(by = 'hgnc_id', column = 'symbol') %>%
#'  hgnc_join(by = 'hgnc_id', column = 'entrez_id')
#'}
#'
#' @export
hgnc_join <- function(.data,
                      by = 'hgnc_id',
                      column = 'symbol',
                      one_to_many = FALSE,
                      file = get_hgnc_file()) {

  stopifnot(
    is.data.frame(.data),
    rlang::is_scalar_character(by),
    rlang::is_scalar_character(column),
    by %in% names(hgnc_col_types),
    column %in% names(hgnc_col_types),
    by != column,
    rlang::is_bool(one_to_many),
    rlang::is_scalar_character(file)
  )

  key_table <- get_hgnc_key_table(
    key = unname(by),
    column = column,
    one_to_many = one_to_many,
    file = file
  )

  dplyr::left_join(
    .data,
    key_table,
    by = by
  )

}

#' Convert one HGNC identifier to another
#'
#' @param x A vector of values to convert from
#' @param from The HGNC identifier to convert from, must be a column name in the HGNC dataset
#' @param to The HGNC identifier to convert to, must be a column name in the HGNC dataset
#' @param one_to_many A boolean value indicating whether cases where the 'from' identifier maps to multiple 'to' values should be returned.
#'  If set to `FASLE` (the default), such one-to-many cases will yield NA. If set to `TRUE`, the returned value will be a list of vectors of varying length.
#' @param file A file or URL of the complete HGNC data set (in TSV format), as used by [import_hgnc_dataset()].
#' @return A list or vector of converted values
#' @examples
#' \dontrun{
#'# convert a set of hgnc_ids to symbols
#'hgnc_ids <- c("HGNC:44948", "HGNC:43240", "HGNC:23357", "HGNC:1855", "HGNC:39400")
#'hgnc_convert(hgnc_ids, from = 'hgnc_id', to = 'symbol')

#'# convert a set of entrez_ids to ensembl_gene_ids
#'entrez_ids <- c(79933, 109623458, 158471, 54987, 81631)
#'hgnc_convert(entrez_ids, from = 'entrez_id', to = 'ensembl_gene_id')
#'}
#'
#' @export
hgnc_convert <- function(x,
                         from = 'hgnc_id',
                         to = 'symbol',
                         one_to_many = FALSE,
                         file = get_hgnc_file()) {

  stopifnot(
    rlang::is_atomic(x),
    rlang::is_scalar_character(from),
    rlang::is_scalar_character(to),
    from %in% names(hgnc_col_types),
    to %in% names(hgnc_col_types),
    from != to,
    rlang::is_bool(one_to_many),
    rlang::is_scalar_character(file)
  )

  key_table <-
    get_hgnc_key_table(
      key = from,
      column = to,
      one_to_many = one_to_many,
      file = file
    ) %>%
    dplyr::rename(
      from = dplyr::all_of(from),
      to = dplyr::all_of(to)
    )

  with(key_table, to[match(x, from)])
}

