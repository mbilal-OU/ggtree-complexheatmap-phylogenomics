figures <- c(
  "01_rectangular_phylogeny.png",
  "02_circular_phylogeny.png",
  "03_clade_support.png",
  "04_aligned_pangenome.png",
  "05_resistance_gene_context.png",
  "06_expression_heatmap.png",
  "07_microbiome_clr_heatmap.png",
  "08_mutation_oncoprint.png",
  "09_multiomics_heatmap.png",
  "10_sample_correlation.png"
)

test_that("every gallery figure links to a complete tutorial", {
  readme <- paste(readLines("README.md", warn = FALSE), collapse = "\n")
  guide <- paste(readLines("docs/figure-tutorials.md", warn = FALSE), collapse = "\n")

  for (figure in figures) {
    expect_true(grepl(
      paste0("figures/", figure, ")\\]\\(docs/figure-tutorials.md#"),
      readme
    ))
  }

  expect_equal(length(gregexpr("\\*\\*Use when:\\*\\*", guide)[[1]]), length(figures))
  expect_equal(length(gregexpr("\\*\\*Data and code:\\*\\*", guide)[[1]]), length(figures))
  expect_equal(length(gregexpr("\\*\\*Use your own data:\\*\\*", guide)[[1]]), length(figures))
  expect_equal(length(gregexpr("\\*\\*Interpret:\\*\\*", guide)[[1]]), length(figures))
})
