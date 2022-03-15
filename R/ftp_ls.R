#' @importFrom rlang .data
ftp_ls <- function(url) {

  txt <-
    rvest::read_html(url) %>%
    rvest::html_elements('pre') %>%
    rvest::html_text2()

  # Remove "../\r\n"
  txt2 <- sub(pattern = '^../\r\n', replacement = '', x =  txt)

  df <- utils::read.table(text = txt2, header = FALSE, col.names = c('file', 'date', 'time', 'size'))
  tbl <- tibble::as_tibble(df) %>%
    dplyr::mutate(datetime = lubridate::parse_date_time(paste(.data$date, .data$time), "d-m-y HM"), .before = .data$date) %>%
    dplyr::mutate(date = lubridate::dmy(.data$date),
                  time = lubridate::hm(.data$time)) %>%
    dplyr::mutate(dataset = stringr::str_remove(.data$file, '[-_]\\d{4}-\\d{2}-\\d{2}\\.\\w+$'), .before = 1L) %>%
    dplyr::mutate(url = rvest::url_absolute(x = .data$file, base = url))

  return(tbl)

}
