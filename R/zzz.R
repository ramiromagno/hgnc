
# use memoised verysion of import_hgnc_dataset
.onLoad <- function(pkgname, libname) {


  # setup cache for import_hgnc_dataset
  cache_mode <- getOption('hgnc.cache_mode')

  if (is.null(cache_mode)) {
    cache_mode <- 'cache_mem'
  }

  cache_dir <- getOption('hgnc.cache_dir')
  if (is.null(cache_dir)) {
    cache_dir <- tools::R_user_dir('hgnc', 'cache')
  }

  if (cache_mode == 'cache_mem') {

    message('using hgnc cache (cachem::cache_mem)')
    cache <- cachem::cache_mem(max_size = 1024 * 1024^2)

  } else if (cache_mode == 'cache_disk') {

    message ('using hgnc cache (cachem::cache_disk)')
    message ('using hgnc cache dir: ', cache_dir)
    cache <- cachem::cache_disk(max_size = 1024 * 1024^2, dir = cache_dir)

  } else if (cache_mode == 'cache_layered') {

    message ('using hgnc cache (cachem::cache_layered)')
    message ('using hgnc cache dir: ', cache_dir)
    cache <- cachem::cache_layered(
      cachem::cache_mem(max_size = 1024 * 1024^2),
      cachem::cache_disk(max_size = 1024 * 1024^2, dir = cache_dir)
    )

  } else {
    message('Not using hgnc cache')

    return(invisible())
  }

  import_hgnc_dataset <<- memoise::memoise(import_hgnc_dataset, cache = cache)

  # cache list_archives for 1 hour
  list_archives <<- memoise::memoise(
    list_archives,
    cache = cachem::cache_mem(max_size = 1024 * 1024^2, max_age = 60*60)
  )

  invisible()
}
