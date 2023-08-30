

.onLoad <- function(pkgname, libname) {

  # create memory-cached version of import_hgnc_dataset
  import_hgnc_dataset <<- memoise::memoise(
    import_hgnc_dataset,
    cache = cachem::cache_mem(max_size = 512 * 1024^2)
  )

  # cache list_archives in memory for 15 min
  list_archives <<- memoise::memoise(
    list_archives,
    cache = cachem::cache_mem(max_size = 512 * 1024^2, max_age = 60*15)
  )

  invisible()
}
