

install <- function() {
  if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

  BiocManager::install("synergyfinder")
  BiocManager::install("ggplot2")
  library(synergyfinder)
}

init <- function() {
  library(synergyfinder)
  library(ggplot2)
}


main <- function() {
  #install()
  init()

  res <- ReshapeData(
  data = mathews_screening_data,
  data_type = "viability",
  impute = TRUE,
  impute_method = NULL,
  noise = TRUE,
  seed = 1)

  Plot2DrugHeatmap(
    data = res,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "response",
    dynamic = FALSE,
    summary_statistic = c("mean",  "median")
  )

  Plot2DrugHeatmap(
    data = res,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "ZIP_synergy",
    dynamic = FALSE,
    summary_statistic = c( "quantile_25", "quantile_75")
  )
}


main()

