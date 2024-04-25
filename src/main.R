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
  data(mathews_screening_data)

  res1 <- ReshapeData(
    data = mathews_screening_data,
    data_type = "viability",
    impute = TRUE,
    impute_method = NULL,
    noise = TRUE,
    seed = 1
  )

  res2 <- CalculateSynergy(
    data = res1,
    method = c("ZIP", "HSA", "Bliss", "Loewe"),
    Emin = NA,
    Emax = NA,
    correct_baseline = "non"
  )

  res3 <- CalculateSensitivity(
    data = res2,
    correct_baseline = "non"
  )

  for (i in c(1, 2)){
    PlotDoseResponseCurve(
      data = res3,
      plot_block = 1,
      drug_index = i,
      plot_new = FALSE,
      record_plot = FALSE
    )
  }

  Plot2DrugHeatmap(
    data = res3,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "response",
    dynamic = FALSE,
    summary_statistic = c("mean", "median")
  )
  Plot2DrugHeatmap(
    data = res3,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "ZIP_synergy",
    dynamic = FALSE,
    summary_statistic = c("quantile_25", "quantile_75")
  )

  Plot2DrugContour(
    data = res3,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "response",
    dynamic = FALSE,
    summary_statistic = c("mean", "median")
  )
  Plot2DrugContour(
    data = res3,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "ZIP_synergy",
    dynamic = FALSE,
    summary_statistic = c("quantile_25", "quantile_75")
  )

  Plot2DrugSurface(
    data = res3,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "response",
    dynamic = FALSE,
    summary_statistic = c("mean", "quantile_25", "median", "quantile_75")
  )
  Plot2DrugSurface(
    data = res3,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "ZIP_synergy",
    dynamic = FALSE,
    summary_statistic = c("mean", "quantile_25", "median", "quantile_75")
  )
}


main()

