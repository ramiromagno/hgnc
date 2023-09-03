
# return a table that maps from a key column to another columns in the hgnc_dataset
get_hgnc_key_table <- function(key,
                               column,
                               drop_non_unique = TRUE,
                               file = get_hgnc_file()) {

  key_table <-
    import_hgnc_dataset(file = file) %>%
    dplyr::select(key = dplyr::all_of(key),
                  column = dplyr::all_of(column)) %>%
    (function(x) `if`(key %in% hgnc_list_cols, tidyr::unchop(x, key), x)) %>%
    (function(x) `if`(column %in% hgnc_list_cols, tidyr::unchop(x, column), x)) %>%
    dplyr::filter(!is.na(key)) %>%
    dplyr::distinct()

  is_unique_key <- nrow(key_table) == dplyr::n_distinct(key_table$key)

  if (!is_unique_key & drop_non_unique) {

    message('dropping non-unique keys in "', key, '"')
    key_table <-
      key_table %>%
      dplyr::add_count(key) %>%
      dplyr::filter(n == 1) %>%
      dplyr::select(-n)

  } else if (!is_unique_key){

    message('key "', key, '" is not unique, returning list-columns')
    key_table <-
      key_table %>%
      tidyr::chop(-key)

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
#' @param drop_non_unique A boolean value indicating whether non-unique rows should be dropped. If set to `FALSE` and the 'by' column is not unique, the added column will be a list-column.
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
                      drop_non_unique = TRUE,
                      file = get_hgnc_file()) {

  stopifnot(
    is.data.frame(.data),
    rlang::is_scalar_character(by),
    rlang::is_scalar_character(column),
    by %in% names(hgnc_col_types),
    column %in% names(hgnc_col_types),
    by != column,
    rlang::is_bool(drop_non_unique),
    rlang::is_scalar_character(file)
  )

  key_table <- get_hgnc_key_table(
    key = unname(by),
    column = column,
    drop_non_unique = drop_non_unique,
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
#' @param drop_non_unique A boolean value indicating whether non-uniquely mapped values of from should be dropped. If set to `FALSE` and there are non-unique mappings, the returned value will be a list.
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
                         drop_non_unique = TRUE,
                         file = get_hgnc_file()) {

  stopifnot(
    rlang::is_atomic(x),
    rlang::is_scalar_character(from),
    rlang::is_scalar_character(to),
    from %in% names(hgnc_col_types),
    to %in% names(hgnc_col_types),
    from != to,
    rlang::is_bool(drop_non_unique),
    rlang::is_scalar_character(file)
  )

  key_table <-
    get_hgnc_key_table(
      key = from,
      column = to,
      drop_non_unique = drop_non_unique,
      file = file
    ) %>%
    dplyr::rename(
      from = all_of(from),
      to = all_of(to)
    )

  with(key_table, to[match(x, from)])
}

