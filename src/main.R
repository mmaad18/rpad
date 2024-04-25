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

  plot <- Plot2DrugHeatmap(
    data = res3,
    plot_block = 1,
    drugs = c(1, 2),
    plot_value = "Bliss_synergy",
    dynamic = FALSE,
    text_label_size_scale = 1.5,
    summary_statistic = c("quantile_25", "quantile_75", "mean")
  )

  my_theme <- theme(
    axis.line = element_line(color = "black", size = 0.75),
    panel.grid.major = element_line(color = "black", size = 0.75),
    panel.background = element_rect(fill = "white"),

    plot.title = element_text(face = "bold", size = 14),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 10)
  )

  plot + my_theme
}


main()

