any_str_detect <- function(string, pattern, negate = FALSE) {

  any(stringr::str_detect(string = string, pattern = pattern, negate = negate), na.rm = TRUE)
}

str_detect2 <- function(string, pattern, negate = FALSE) {

  lgl <-
  if(is.list(string)) {
    purrr::map_lgl(string, ~ any_str_detect(string = .x, pattern = pattern, negate = negate))
  } else {
    stringr::str_detect(string = string, pattern = pattern, negate = negate)
  }

  return(lgl)
}
