#' Download HGNC dataset
#'
#' Download the latest HGNC approved data set.
#'
#' @param url A character string naming the URL of the HGNC dataset. It defaults
#'   to the latest available archive.
#' @param path A character string with the directory path where the downloaded
#'   file is to be saved. By default, this is the current working directory.
#' @param filename A character string with the name of the saved file. By
#'   default, this is inferred from the last part of the URL.
#' @param ... Additional arguments passed on to [download.file()].
#'
#' @export
download_archive <- function(url = get_hgnc_file(), path = getwd(), filename = basename(url), ...) {

  destfile <- file.path(path, filename)
  utils::download.file(url = url, destfile = destfile, ...)

}
