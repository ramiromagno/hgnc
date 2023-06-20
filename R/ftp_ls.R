#' @importFrom rlang .data
ftp_ls <- function(url) {

  txt <-
    rvest::read_html(url) %>%
    rvest::html_elements(xpath = "//html/body/table") %>%
    rvest::html_text2()

  txt2 <- sub(pattern = 'Parent Directory\t \t-\t \n', replacement = '', x =  txt)
  txt3 <- sub(pattern = "\tName\tLast modified\tSize\tDescription\n\n\n\t", replacement = "", x = txt2)

  df <-
    utils::read.table(
      text = txt3,
      sep = "\t",
      header = FALSE,
      col.names = c("..", 'file', 'date', 'size', 'description'),
      colClasses = c("NULL", "character", "character", "character", "NULL")
    )

  tbl <- tibble::as_tibble(df) %>%
    dplyr::mutate(dataset = stringr::str_remove(.data$file, '[-_]\\d{4}-\\d{2}-\\d{2}\\.\\w+$'), .before = 1L) %>%
    dplyr::mutate(last_modified = lubridate::ymd_hm(date)) |>
    dplyr::mutate(date = lubridate::ymd(stringr::str_extract(file, "\\d{4}-\\d{2}-\\d{2}"))) |>
    dplyr::mutate(url = rvest::url_absolute(x = .data$file, base = url))

  return(tbl)

}
