

.onLoad <- function(libname, pkgname) {

  # create memory-cached version of import_hgnc_dataset
  import_hgnc_dataset <<- memoise::memoise(
    import_hgnc_dataset,
    cache = cachem::cache_mem(max_size = 512 * 1024^2)
  )

  # cache list_archives in memory for 15 min
  # speeds up latest_monthly_url and latest_quarterly_url
  list_archives <<- memoise::memoise(
    list_archives,
    cache = cachem::cache_mem(max_size = 100 * 1024^2, max_age = 60*15)
  )

  # cache latest_archive_url in memory for 15 min
  # speeds up import_hgnc_dataset with default file argument
  latest_archive_url <<- memoise::memoise(
    latest_archive_url,
    cache = cachem::cache_mem(max_size = 100 * 1024^2, max_age = 60*15)
  )

  invisible()
}
