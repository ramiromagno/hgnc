
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hgnc <img src='man/figures/logo.svg' align="right" height="139" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/hgnc)](https://CRAN.R-project.org/package=hgnc)
<!-- badges: end -->

The [HUGO Gene Nomenclature Committee
(HGNC)](https://www.genenames.org/) is a committee of the Human Genome
Organisation (HUGO) that sets the standards for human gene nomenclature.

The HGNC approves a unique and meaningful name for every known human
gene, based on a group of experts. In addition, the HGNC also provides
the mapping between gene symbols to gene entries in other popular
databases or resources: the HGNC complete gene set.

The goal of `{hgnc}` is to easily download and import the latest HGNC
complete gene data set into R.

This data set provides a useful mapping of HGNC symbols to gene entries
in other popular databases or resouces, such as, the Entrez gene
identifier or the UCSC gene identifier, among many others. Check the
documentation of the function `import_hgnc_dataset()` for a description
of the several fields available.

## Installation

Install `{hgnc}` from CRAN:

``` r
install.packages("hgnc")
```

You can install the development version of `{hgnc}` like so:

``` r
# install.packages("remotes")
remotes::install_github("maialab/hgnc")
```

## Usage

### Basic usage

To import the latest HGNC gene data set in tabular format directly into
memory as a tibble do as follows:

``` r
library(hgnc)

# Date of HGNC last update
last_update()
#> [1] "2023-06-20 12:46:57 UTC"

# Direct URL to the latest archive in TSV format
(url <- latest_archive_url())
#> [1] "https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt"

# Import the data set in tidy tabular format
# NB: Multiple-value columns are kept as list-columns
hgnc_dataset <- import_hgnc_dataset(url)

dplyr::glimpse(hgnc_dataset)
#> Rows: 43,700
#> Columns: 55
#> $ hgnc_id                  <chr> "HGNC:5", "HGNC:37133", "HGNC:24086", "HGNC:7…
#> $ hgnc_id2                 <chr> "5", "37133", "24086", "7", "27057", "23336",…
#> $ symbol                   <chr> "A1BG", "A1BG-AS1", "A1CF", "A2M", "A2M-AS1",…
#> $ name                     <chr> "alpha-1-B glycoprotein", "A1BG antisense RNA…
#> $ locus_group              <chr> "protein-coding gene", "non-coding RNA", "pro…
#> $ locus_type               <chr> "gene with protein product", "RNA, long non-c…
#> $ status                   <chr> "Approved", "Approved", "Approved", "Approved…
#> $ location                 <chr> "19q13.43", "19q13.43", "10q11.23", "12p13.31…
#> $ location_sortable        <chr> "19q13.43", "19q13.43", "10q11.23", "12p13.31…
#> $ alias_symbol             <list> NA, "FLJ23569", <"ACF", "ASP", "ACF64", "ACF…
#> $ alias_name               <list> NA, NA, NA, NA, NA, NA, NA, NA, NA, <"iGb3 s…
#> $ prev_symbol              <list> NA, <"NCRNA00181", "A1BGAS", "A1BG-AS">, NA,…
#> $ prev_name                <list> NA, <"non-protein coding RNA 181", "A1BG ant…
#> $ gene_group               <list> "Immunoglobulin like domain containing", "An…
#> $ gene_group_id            <list> "594", "1987", "725", "2148", "1987", "2148"…
#> $ date_approved_reserved   <date> 1989-06-30, 2009-07-20, 2007-11-23, 1986-01-…
#> $ date_symbol_changed      <date> NA, 2010-11-25, NA, NA, NA, 2005-09-01, NA, …
#> $ date_name_changed        <date> NA, 2012-08-15, NA, NA, 2018-03-21, 2016-03-…
#> $ date_modified            <date> 2023-01-20, 2013-06-27, 2023-01-20, 2023-01-…
#> $ entrez_id                <int> 1, 503538, 29974, 2, 144571, 144568, 10087410…
#> $ ensembl_gene_id          <chr> "ENSG00000121410", "ENSG00000268895", "ENSG00…
#> $ vega_id                  <chr> "OTTHUMG00000183507", "OTTHUMG00000183508", "…
#> $ ucsc_id                  <chr> "uc002qsd.5", "uc002qse.3", "uc057tgv.1", "uc…
#> $ ena                      <list> NA, "BC040926", "AF271790", <"BX647329", "X6…
#> $ refseq_accession         <list> "NM_130786", "NR_015380", "NM_014576", "NM_0…
#> $ ccds_id                  <list> "CCDS12976", NA, <"CCDS7243", "CCDS7242", "C…
#> $ uniprot_ids              <list> "P04217", NA, "Q9NQ94", "P01023", NA, "A8K2U…
#> $ pubmed_id                <list> "2591067", NA, <"11815617", "11072063">, <"2…
#> $ mgd_id                   <list> "MGI:2152878", NA, "MGI:1917115", "MGI:24491…
#> $ rgd_id                   <list> "RGD:69417", NA, "RGD:619834", "RGD:2004", N…
#> $ lsdb                     <chr> NA, NA, NA, "LRG_591|http://ftp.ebi.ac.uk/pub…
#> $ cosmic                   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ omim_id                  <list> "138670", NA, "618199", "103950", NA, "61062…
#> $ mirbase                  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ homeodb                  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ snornabase               <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ bioparadigms_slc         <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ orphanet                 <chr> NA, NA, NA, NA, NA, "410627", NA, NA, NA, NA,…
#> $ pseudogene.org           <chr> NA, NA, NA, NA, NA, NA, NA, NA, "PGOHUM000002…
#> $ horde_id                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ merops                   <chr> "I43.950", NA, NA, "I39.001", NA, "I39.007", …
#> $ imgt                     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ iuphar                   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ kznf_gene_catalog        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ `mamit-trnadb`           <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ cd                       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ lncrnadb                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ enzyme_id                <list> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "2.4…
#> $ intermediate_filament_db <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ rna_central_ids          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ lncipedia                <chr> NA, "A1BG-AS1", NA, NA, "A2M-AS1", NA, "A2ML1…
#> $ gtrnadb                  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ agr                      <chr> "HGNC:5", "HGNC:37133", "HGNC:24086", "HGNC:7…
#> $ mane_select              <list> <"ENST00000263100.8", "NM_130786.4">, NA, <"…
#> $ gencc                    <chr> NA, NA, NA, "HGNC:7", NA, "HGNC:23336", NA, N…
```

The original data set does not contain the column `hgnc_id2`, which is
added as a convenience by `{hgnc}`; this is because although the HGNC
identifiers should formally contain the prefix `"HGNC:"`, it is often
found elsewhere that they are stripped of this prefix, so the column
`hgnc_id2` is also provided whose values only contain the integer part.

``` r
hgnc_dataset %>%
  dplyr::select(c('hgnc_id', 'hgnc_id2'))
#> # A tibble: 43,700 × 2
#>    hgnc_id    hgnc_id2
#>    <chr>      <chr>   
#>  1 HGNC:5     5       
#>  2 HGNC:37133 37133   
#>  3 HGNC:24086 24086   
#>  4 HGNC:7     7       
#>  5 HGNC:27057 27057   
#>  6 HGNC:23336 23336   
#>  7 HGNC:41022 41022   
#>  8 HGNC:41523 41523   
#>  9 HGNC:8     8       
#> 10 HGNC:30005 30005   
#> # ℹ 43,690 more rows
```

### Locus groups

The HGNC defines a group name (`locus_group`) for a set of related locus
types. Here’s how you can quickly check how many gene entries there are
per locus group.

``` r
hgnc_dataset %>%
  dplyr::count(locus_group, sort = TRUE)
#> # A tibble: 4 × 2
#>   locus_group             n
#>   <chr>               <int>
#> 1 protein-coding gene 19270
#> 2 pseudogene          14364
#> 3 non-coding RNA       9075
#> 4 other                 991
```

`locus_type` provides a finer classification:

``` r
hgnc_dataset %>%
  dplyr::group_by(locus_group) %>%
  dplyr::count(locus_type, sort = TRUE) %>%
  dplyr::arrange(locus_group) %>%
  print(n = Inf)
#> # A tibble: 23 × 3
#> # Groups:   locus_group [4]
#>    locus_group         locus_type                     n
#>    <chr>               <chr>                      <int>
#>  1 non-coding RNA      RNA, long non-coding        5738
#>  2 non-coding RNA      RNA, micro                  1912
#>  3 non-coding RNA      RNA, transfer                591
#>  4 non-coding RNA      RNA, small nucleolar         568
#>  5 non-coding RNA      RNA, cluster                 119
#>  6 non-coding RNA      RNA, ribosomal                60
#>  7 non-coding RNA      RNA, small nuclear            50
#>  8 non-coding RNA      RNA, misc                     29
#>  9 non-coding RNA      RNA, Y                         4
#> 10 non-coding RNA      RNA, vault                     4
#> 11 other               immunoglobulin gene          230
#> 12 other               T cell receptor gene         206
#> 13 other               readthrough                  147
#> 14 other               fragile site                 116
#> 15 other               endogenous retrovirus        109
#> 16 other               complex locus constituent     69
#> 17 other               unknown                       68
#> 18 other               region                        38
#> 19 other               virus integration site         8
#> 20 protein-coding gene gene with protein product  19270
#> 21 pseudogene          pseudogene                 14124
#> 22 pseudogene          immunoglobulin pseudogene    203
#> 23 pseudogene          T cell receptor pseudogene    37
```

### Downloading to disk

If you prefer to download the data set as a file to disk first, you can
use `download_archive()`. Then, you can use `import_hgnc_dataset()` to
import the downloaded file into R.

### Downloading other archives

Besides the latest archive, the [HUGO Gene Nomenclature Committee
(HGNC)](https://www.genenames.org/) website also provides monthly and
quarterly updates. Use `list_archives()` to list the currently available
for download archives. The column `url` contains the direct download
link that you can pass to `import_hgnc_dataset()` to import the data
into R.

``` r
list_archives()
#> # A tibble: 97 × 6
#>    series  dataset           file                         date       size  url  
#>    <chr>   <chr>             <chr>                        <date>     <chr> <chr>
#>  1 monthly hgnc_complete_set hgnc_complete_set_2021-03-0… 2023-05-01 14M   http…
#>  2 monthly hgnc_complete_set hgnc_complete_set_2021-04-0… 2023-05-01 15M   http…
#>  3 monthly hgnc_complete_set hgnc_complete_set_2021-05-0… 2023-05-01 15M   http…
#>  4 monthly hgnc_complete_set hgnc_complete_set_2021-06-0… 2023-05-01 15M   http…
#>  5 monthly hgnc_complete_set hgnc_complete_set_2021-07-0… 2023-05-01 15M   http…
#>  6 monthly hgnc_complete_set hgnc_complete_set_2021-08-0… 2023-05-01 15M   http…
#>  7 monthly hgnc_complete_set hgnc_complete_set_2021-09-0… 2023-05-01 15M   http…
#>  8 monthly hgnc_complete_set hgnc_complete_set_2021-10-0… 2023-05-01 15M   http…
#>  9 monthly hgnc_complete_set hgnc_complete_set_2021-11-0… 2023-05-01 15M   http…
#> 10 monthly hgnc_complete_set hgnc_complete_set_2021-12-0… 2023-05-01 15M   http…
#> # ℹ 87 more rows
```

## Motivation

You could go to [www.genenames.org](https://www.genenames.org) and
download the files yourself. So why the need for this R package?

`{hgnc}` really is just a convenience package. The main advantage is
that the function `import_hgnc_dataset()` reads in the data in tabular
format with all the columns with the appropriate type (so you don’t have
to specify it yourself). As an extra step, those variables that contain
multiple values are encoded as list-columns.

Remember that list-columns can be expanded with `tidyr::unnest()`. E.g.,
`alias_symbol` is a list-column containing multiple alternative aliases
to the standard `symbol`:

``` r
hgnc_dataset %>%
  dplyr::filter(symbol == 'TP53') %>%
  dplyr::select(c('symbol', 'alias_symbol'))
#> # A tibble: 1 × 2
#>   symbol alias_symbol
#>   <chr>  <list>      
#> 1 TP53   <chr [2]>

hgnc_dataset %>%
  dplyr::filter(symbol == 'TP53') %>%
  dplyr::select(c('symbol', 'alias_symbol')) %>%
  tidyr::unnest(cols = 'alias_symbol')
#> # A tibble: 2 × 2
#>   symbol alias_symbol
#>   <chr>  <chr>       
#> 1 TP53   p53         
#> 2 TP53   LFS1
```

In addition, we also provide the function `filter_by_keyword()` that
allows filtering the data set based on a keyword or regular expression.
By default this function will look into all columns that contain gene
symbols or names (`symbol`, `name`, `alias_symbol`, `alias_name`,
`prev_symbol` and `prev_name`). It works automatically with list-columns
too.

Look for entries in the data set that contain the keyword `"TP53"`:

``` r
hgnc_dataset %>%
  filter_by_keyword('TP53') %>%
  dplyr::select(1:4)
#> # A tibble: 66 × 4
#>    hgnc_id    hgnc_id2 symbol      name                                         
#>    <chr>      <chr>    <chr>       <chr>                                        
#>  1 HGNC:49685 49685    ABHD15-AS1  ABHD15 antisense RNA 1                       
#>  2 HGNC:20679 20679    ANO9        anoctamin 9                                  
#>  3 HGNC:40093 40093    BCAR3-AS1   BCAR3 antisense RNA 1                        
#>  4 HGNC:13276 13276    EI24        EI24 autophagy associated transmembrane prot…
#>  5 HGNC:3345  3345     ENC1        ectodermal-neural cortex 1                   
#>  6 HGNC:27919 27919    ERVMER61-1  endogenous retrovirus group MER61 member 1   
#>  7 HGNC:56226 56226    FAM169A-AS1 FAM169A antisense RNA 1                      
#>  8 HGNC:4136  4136     GAMT        guanidinoacetate N-methyltransferase         
#>  9 HGNC:54868 54868    KLRK1-AS1   KLRK1 antisense RNA 1                        
#> 10 HGNC:6568  6568     LGALS7      galectin 7                                   
#> # ℹ 56 more rows
```

Restrict the search to the `symbol` column:

``` r
hgnc_dataset %>%
  filter_by_keyword('TP53', cols = 'symbol') %>%
  dplyr::select(1:4)
#> # A tibble: 23 × 4
#>    hgnc_id    hgnc_id2 symbol    name                                           
#>    <chr>      <chr>    <chr>     <chr>                                          
#>  1 HGNC:11998 11998    TP53      tumor protein p53                              
#>  2 HGNC:29984 29984    TP53AIP1  tumor protein p53 regulated apoptosis inducing…
#>  3 HGNC:11999 11999    TP53BP1   tumor protein p53 binding protein 1            
#>  4 HGNC:12000 12000    TP53BP2   tumor protein p53 binding protein 2            
#>  5 HGNC:16328 16328    TP53BP2P1 tumor protein p53 binding protein 2 pseudogene…
#>  6 HGNC:43652 43652    TP53COR1  tumor protein p53 pathway corepressor 1        
#>  7 HGNC:19373 19373    TP53I3    tumor protein p53 inducible protein 3          
#>  8 HGNC:16842 16842    TP53I11   tumor protein p53 inducible protein 11         
#>  9 HGNC:25102 25102    TP53I13   tumor protein p53 inducible protein 13         
#> 10 HGNC:18022 18022    TP53INP1  tumor protein p53 inducible nuclear protein 1  
#> # ℹ 13 more rows
```

Search for the whole word `"TP53"` exactly by taking advantage of
regular expressions:

``` r
hgnc_dataset %>%
  filter_by_keyword('^TP53$', cols = 'symbol') %>%
  dplyr::select(1:4)
#> # A tibble: 1 × 4
#>   hgnc_id    hgnc_id2 symbol name             
#>   <chr>      <chr>    <chr>  <chr>            
#> 1 HGNC:11998 11998    TP53   tumor protein p53
```

## Citing the HGNC

To cite HGNC nomenclature resources use:

- Tweedie S, Braschi B, Gray KA, Jones TEM, Seal RL, Yates B, Bruford
  EA. *Genenames.org: the HGNC and VGNC resources in 2021.* Nucleic
  Acids Res. 49, D939–D946 (2021). doi:
  [10.1093/nar/gkaa980](https://doi.org/10.1093/nar/gkaa980)

To cite data within the database use the following format:

- HGNC Database, HUGO Gene Nomenclature Committee (HGNC), European
  Molecular Biology Laboratory, European Bioinformatics Institute
  (EMBL-EBI), Wellcome Genome Campus, Hinxton, Cambridge CB10 1SD,
  United Kingdom www.genenames.org.

Please include the month and year you retrieved the data cited.
