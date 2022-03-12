#' Import HGNC data set
#'
#' This function imports into memory as a tibble, the complete HGNC data set
#' from a TSV file.
#'
#' @param file A file or URL of the  complete HGNC data set (in TSV format).
#' @param ... Additional arguments to be passed to [readr::read_tsv()].
#'
#' @return A [tibble][tibble::tibble-package] of the HGNC data set.
#'
#' @md
#' @importFrom rlang .data
#' @export
import_hgnc_dataset_tsv <- function(file, ...) {

  col_types <- list(
    hgnc_id = readr::col_character(),
    symbol = readr::col_character(),
    name = readr::col_character(),
    locus_group = readr::col_character(),
    locus_type = readr::col_character(),
    status = readr::col_character(),
    location = readr::col_character(),
    location_sortable = readr::col_character(),
    alias_symbol = readr::col_character(),
    alias_name = readr::col_character(),
    prev_symbol = readr::col_character(),
    prev_name = readr::col_character(),
    gene_group = readr::col_character(),
    gene_group_id = readr::col_character(),
    date_approved_reserved = readr::col_date(),
    date_symbol_changed = readr::col_date(),
    date_modified = readr::col_date(),
    entrez_id = readr::col_integer(),
    ensembl_gene_id = readr::col_character(),
    vega_id = readr::col_character(),
    ucsc_id = readr::col_character(),
    ena = readr::col_character(),
    refseq_accession = readr::col_character(),
    ccds_id = readr::col_character(),
    uniprot_ids = readr::col_character(),
    pubmed_id = readr::col_character(),
    mgd_id = readr::col_character(),
    rgd_id = readr::col_character(),
    lsdb  = readr::col_character(),
    cosmic = readr::col_character(),
    omim_id = readr::col_character(),
    mirbase= readr::col_character(),
    homeodb= readr::col_character(),
    snornabase= readr::col_character(),
    bioparadigms_slc = readr::col_character(),
    orphanet = readr::col_character(),
    `pseudogene.org` = readr::col_character(),
    horde_id = readr::col_character(),
    merops = readr::col_character(),
    imgt = readr::col_character(),
    iuphar = readr::col_character(),
    kznf_gene_catalog = readr::col_character(),
    `mamit-trnadb` = readr::col_character(),
    cd = readr::col_character(),
    lncrnadb = readr::col_character(),
    enzyme_id = readr::col_character(),
    intermediate_filament_db = readr::col_character(),
    rna_central_ids = readr::col_character(),
    lncipedia = readr::col_character(),
    gtrnadb = readr::col_character(),
    agr = readr::col_character(),
    mane_select = readr::col_character(),
    gencc = readr::col_character()
  )

  tbl <- readr::read_tsv(file = file, col_types = col_types, ...)

  # Create list-columns for those cases where multiples values are possible
  # per observation.
  tbl2 <- dplyr::mutate(
    tbl,
    alias_symbol = strsplit(.data$alias_symbol, split = '|', fixed = TRUE),
    alias_name = strsplit(.data$alias_name, split = '|', fixed = TRUE),
    prev_symbol = strsplit(.data$prev_symbol, split = '|', fixed = TRUE),
    prev_name = strsplit(.data$prev_name, split = '|', fixed = TRUE),
    gene_group = strsplit(.data$gene_group, split = '|', fixed = TRUE),
    gene_group_id = strsplit(.data$gene_group_id, split = '|', fixed = TRUE),
    ena = strsplit(.data$ena, split = '|', fixed = TRUE),
    refseq_accession = strsplit(.data$refseq_accession, split = '|', fixed = TRUE),
    ccds_id = strsplit(.data$ccds_id, split = '|', fixed = TRUE),
    uniprot_ids = strsplit(.data$uniprot_ids, split = '|', fixed = TRUE),
    pubmed_id = strsplit(.data$pubmed_id, split = '|', fixed = TRUE),
    mgd_id = strsplit(.data$mgd_id, split = '|', fixed = TRUE),
    rgd_id = strsplit(.data$rgd_id, split = '|', fixed = TRUE),
    omim_id = strsplit(.data$omim_id, split = '|', fixed = TRUE),
    enzyme_id = strsplit(.data$enzyme_id, split = '|', fixed = TRUE),
    mane_select = strsplit(.data$mane_select, split = '|', fixed = TRUE)
  ) %>%
    dplyr::mutate(hgnc_id2 = stringr::str_remove(.data$hgnc_id, '^HGNC:'), .after = 'hgnc_id')

  return(tbl2)
}
