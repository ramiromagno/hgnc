#' Import HGNC data
#'
#' This function imports into memory, as a tibble, the complete HGNC data set
#' from a TSV file.
#'
#' @param file A file or URL of the  complete HGNC data set (in TSV format).
#' @param ... Additional arguments to be passed on to [readr::read_tsv()].
#'
#' @return A [tibble][tibble::tibble-package] of the HGNC data set consisting of
#'   55 columns:
#' \describe{
#' \item{`hgnc_id`}{A unique ID provided by the HGNC for each gene with an approved symbol. IDs are of the format HGNC:n, where n is a unique number. HGNC IDs remain stable even if a name or symbol changes.}
#' \item{`hgnc_id2`}{A stripped down version of `hgnc_id` where the prefix `"HGNC:"` has been removed (this column is added by the package `{hgnc}`).}
#' \item{`symbol`}{The official gene symbol approved by the HGNC, which is typically a short form of the gene name. Symbols are approved in accordance with the Guidelines for Human Gene Nomenclature.}
#' \item{`name`}{The full gene name approved by the HGNC; corresponds to the approved symbol above.}
#' \item{`locus_group`}{A group name for a set of related locus types as defined by the HGNC. One of: `"protein-coding gene"`, `"non-coding RNA"`, `"pseudogene"` or `"other"`.}
#' \item{`locus_type`}{Specifies the genetic class of each gene entry:
#'   \describe{
#'     \item{`"gene with protein product"`}{Protein-coding genes (the protein
#'     may be predicted and of unknown function),
#'     [SO:0001217](http://www.sequenceontology.org/browser/current_svn/term/SO:0001217).}
#'     \item{`"RNA, cluster"`}{Region containing a cluster of small non-coding RNA genes.}
#'     \item{`"RNA, long non-coding"`}{Non-protein coding genes that encode long
#'     non-coding RNAs (lncRNAs)
#'     [SO:0001877](http://www.sequenceontology.org/browser/current_svn/term/SO:0001877);
#'     these are at least 200 nt in length. Subtypes include intergenic
#'     [SO:0001463](http://www.sequenceontology.org/browser/current_svn/term/SO:0001463),
#'     intronic
#'     [SO:0001903](http://www.sequenceontology.org/browser/current_svn/term/SO:0001903)
#'     and antisense
#'     [SO:0001904](http://www.sequenceontology.org/browser/current_svn/term/SO:0001904).}
#'     \item{`"RNA, micro"`}{Non-protein coding genes that encode microRNAs (miRNAs), [SO:0001265](http://www.sequenceontology.org/browser/current_svn/term/SO:0001265).}
#'     \item{`"RNA, ribosomal"`}{Non-protein coding genes that encode ribosomal RNAs (rRNAs), [SO:0001637](http://www.sequenceontology.org/browser/current_svn/term/SO:0001637).}
#'     \item{`"RNA, small nuclear"`}{Non-protein coding genes that encode small nuclear RNAs (snRNAs), [SO:0001268](http://www.sequenceontology.org/browser/current_svn/term/SO:0001268).}
#'     \item{`"RNA, small nucleolar"`}{Non-protein coding genes that encode small nucleolar RNAs (snoRNAs) containing C/D or H/ACA box domains, [SO:0001267](http://www.sequenceontology.org/browser/current_svn/term/SO:0001267).}
#'     \item{`"RNA, small cytoplasmic"`}{Non-protein coding genes that encode small cytoplasmic RNAs (scRNAs), [SO:0001266](http://www.sequenceontology.org/browser/current_svn/term/SO:0001266).}
#'     \item{`"RNA, transfer"`}{Non-protein coding genes that encode transfer RNAs (tRNAs), [SO:0001272](http://www.sequenceontology.org/browser/current_svn/term/SO:0001272).}
#'     \item{`"RNA, small misc"`}{Non-protein coding genes that encode miscellaneous types of small ncRNAs, such as vault ([SO:0000404](http://www.sequenceontology.org/browser/current_svn/term/SO:0000404)) and Y ([SO:0000405](http://www.sequenceontology.org/browser/current_svn/term/SO:0000405)) RNA genes.}
#'     \item{`"phenotype only"`}{Mapped phenotypes where the causative gene has not been identified, [SO:0001500](http://www.sequenceontology.org/browser/current_svn/term/SO:0001500).}
#'     \item{`"pseudogene"`}{Genomic DNA sequences that are similar to protein-coding genes but do not encode a functional protein, [SO:0000336](http://www.sequenceontology.org/browser/current_svn/term/SO:0000336).}
#'     \item{`"complex locus constituent"`}{Transcriptional unit that is part of a named complex locus.}
#'     \item{`"endogenous retrovirus"`}{Integrated retroviral elements that are transmitted through the germline, [SO:0000100](http://www.sequenceontology.org/browser/current_svn/term/SO:0000100).}
#'     \item{`"fragile site"`}{A heritable locus on a chromosome that is prone to DNA breakage.}
#'     \item{`"immunoglobulin gene"`}{Gene segments that undergo somatic recombination to form heavy or light chain immunoglobulin genes (SO:0000460). Also includes immunoglobulin gene segments with open reading frames that either cannot undergo somatic recombination, or encode a peptide that is not predicted to fold correctly; these are identified by inclusion of the term "non-functional" in the gene name.}
#'     \item{`"immunoglobulin pseudogene"`}{Immunoglobulin gene segments that are inactivated due to frameshift mutations and/or stop codons in the open reading frame.}
#'     \item{`"protocadherin"`}{Gene segments that constitute the three clustered protocadherins (alpha, beta and gamma)}
#'     \item{`"readthrough"`}{A naturally occurring transcript containing coding sequence from two or more genes that can also be transcribed individually.}
#'     \item{`"region"`}{Extents of genomic sequence that contain one or more genes, also applied to non-gene areas that do not fall into other types.}
#'     \item{`"T cell receptor gene"`}{Gene segments that undergo somatic recombination to form either alpha, beta, gamma or delta chain T cell receptor genes ([SO:0000460](http://www.sequenceontology.org/browser/current_svn/term/SO:0000460)). Also includes T cell receptor gene segments with open reading frames that either cannot undergo somatic recombination, or encode a peptide that is not predicted to fold correctly; these are identified by inclusion of the term "non-functional" in the gene name.}
#'     \item{`"T cell receptor pseudogene"`}{T cell receptor gene segments that are inactivated due to frameshift mutations and/or stop codons in the open reading frame.}
#'     \item{`"transposable element"`}{A segment of repetitive DNA that can move, or retrotranspose, to new sites within the genome ([SO:0000101](http://www.sequenceontology.org/browser/current_svn/term/SO:0000101)).}
#'     \item{`"unknown"`}{Entries where the locus type is currently unknown.}
#'     \item{`"virus integration site"`}{Target sequence for the integration of viral DNA into the genome.}
#'   }
#' }
#' \item{`status`}{Status of the symbol report, which can be either `"Approved"` or `"Entry Withdrawn"`.}
#' \item{`location`}{Chromosomal location. Indicates the cytogenetic location of
#' the gene or region on the chromsome, e.g. `"19q13.43"`. In the absence of
#' that information one of the following may be listed:
#' \describe{
#' \item{`"not on reference assembly"`}{Named gene is not annotated on the current version of the Genome Reference Consortium human reference assembly; may have been annotated on previous assembly versions or on a non-reference human assembly.}
#' \item{`"unplaced"`}{Named gene is annotated on an unplaced/unlocalized scaffold of the human reference assembly.}
#' \item{`"reserved"`}{Named gene has never been annotated on any human assembly.}
#' }
#' }
#' \item{`location_sortable`}{A sortable version of the `location` column (see above).}
#' \item{`alias_symbol`}{Alternative symbols that have been used to refer to the gene. Aliases may be from literature, from other databases or may be added to represent membership of a gene group.}
#' \item{`alias_name`}{Alternative names for the gene. Aliases may be from literature, from other databases or may be added to represent membership of a gene group.}
#' \item{`prev_symbol`}{This field displays any symbols that were previously HGNC-approved nomenclature.}
#' \item{`prev_name`}{This field displays any names that were previously HGNC-approved nomenclature.}
#' \item{`gene_group`}{A gene group. Each gene has been assigned to one or more groups, according to either sequence similarity or information from publications, specialist advisors for that group or other databases. Groups may be either structural or functional.}
#' \item{`gene_group_id`}{Gene group identifier, an integer number. This column contains the gene group identifiers, see `gene_group` for the gene group name.}
#' \item{`date_approved_reserved`}{The date the entry was first approved.}
#' \item{`date_symbol_changed`}{The date the gene symbol was last changed.}
#' \item{`date_name_changed`}{The date the gene name was last changed.}
#' \item{`date_modified`}{Date the entry was last modified.}
#' \item{`entrez_id`}{Entrez gene identifier.}
#' \item{`ensembl_gene_id`}{Ensembl gene identifier.}
#' \item{`vega_id`}{VEGA gene identifier.}
#' \item{`ucsc_id`}{UCSC gene identifier.}
#' \item{`ena`}{International Nucleotide Sequence Database Collaboration (GenBank, ENA and DDBJ) accession number(s).}
#' \item{`refseq_accession`}{The Reference Sequence (RefSeq) identifier for that entry, provided by the NCBI.}
#' \item{`ccds_id`}{Consensus CDS identifier.}
#' \item{`uniprot_ids`}{UniProt protein accession.}
#' \item{`pubmed_id`}{Pubmed and Europe Pubmed Central PMIDs.}
#' \item{`mgd_id`}{Mouse genome informatics database identifier.}
#' \item{`rgd_id`}{Rat genome database gene identifier.}
#' \item{`lsdb`}{The name of the Locus Specific Mutation Database and URL for the gene.}
#' \item{`cosmic`}{Symbol used within the Catalogue of somatic mutations in cancer for the gene.}
#' \item{`omim_id`}{Online Mendelian Inheritance in Man (OMIM) identifier.}
#' \item{`mirbase`}{miRBase identifier.}
#' \item{`homeodb`}{Homeobox Database identifier.}
#' \item{`snornabase`}{snoRNABase identifier.}
#' \item{`bioparadigms_slc`}{Symbol used to link to the SLC tables database at bioparadigms.org for the gene.}
#' \item{`orphanet`}{Orphanet identifier.}
#' \item{`pseudogene.org`}{Pseudogene.org identifier.}
#' \item{`horde_id`}{Symbol used within HORDE for the gene.}
#' \item{`merops`}{Identifier used to link to the MEROPS peptidase database.}
#' \item{`imgt`}{Symbol used within international ImMunoGeneTics information system.}
#' \item{`iuphar`}{The objectId used to link to the IUPHAR/BPS Guide to PHARMACOLOGY database.}
#' \item{`kznf_gene_catalog`}{Lawrence Livermore National Laboratory Human KZNF Gene Catalog (LLNL) identifier.}
#' \item{`mamit-trnadb`}{Identifier to link to the Mamit-tRNA database.}
#' \item{`cd`}{Symbol used within the Human Cell Differentiation Molecule database for the gene.}
#' \item{`lncrnadb`}{lncRNA Database identifier.}
#' \item{`enzyme_id`}{ENZYME EC accession number.}
#' \item{`intermediate_filament_db`}{Identifier used to link to the Human Intermediate Filament Database.}
#' \item{`rna_central_ids`}{Identifier in the RNAcentral, The non-coding RNA sequence database.}
#' \item{`lncipedia`}{The LNCipedia identifier to which the gene belongs. This will only appear if the gene is a long non-coding RNA.}
#' \item{`gtrnadb`}{The GtRNAdb identifier to which the gene belongs. This will only appear if the gene is a tRNA.}
#' \item{`agr`}{The Alliance of Genomic Resources HGNC ID for the Human gene page within the resource.}
#' \item{`mane_select`}{MANE Select nucleotide accession with version (i.e. NCBI RefSeq or Ensembl transcript ID and version).}
#' \item{`gencc`}{Gene Curation Coalition (GenCC) Database identifier.}
#' }
#'
#' @md
#' @examples
#' try(import_hgnc_dataset())
#' @importFrom rlang .data
#' @export
import_hgnc_dataset <- function(file = latest_archive_url(), ...) {

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
