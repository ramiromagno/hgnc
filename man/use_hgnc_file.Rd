% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/options.R
\name{use_hgnc_file}
\alias{use_hgnc_file}
\title{Set the HGNC TSV file to use for \code{\link[=import_hgnc_dataset]{import_hgnc_dataset()}}.
Defaults to the \code{\link[=latest_archive_url]{latest_archive_url()}}, but can also use \code{\link[=latest_monthly_url]{latest_monthly_url()}} or \code{\link[=latest_quarterly_url]{latest_quarterly_url()}}`}
\usage{
use_hgnc_file(file = latest_archive_url())
}
\arguments{
\item{file}{A file or URL of the complete HGNC data set (in TSV format).}
}
\description{
Set the HGNC TSV file to use for \code{\link[=import_hgnc_dataset]{import_hgnc_dataset()}}.
Defaults to the \code{\link[=latest_archive_url]{latest_archive_url()}}, but can also use \code{\link[=latest_monthly_url]{latest_monthly_url()}} or \code{\link[=latest_quarterly_url]{latest_quarterly_url()}}`
}
\examples{
# use the default file given by import_hgnc_dataset()
use_hgnc_file()

# use to the latest monthly release
use_hgnc_file(file = latest_monthly_url())

# use a predefined release for reproducibility
use_hgnc_file(file = "https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/archive/monthly/tsv/hgnc_complete_set_2023-08-01.txt")
}
