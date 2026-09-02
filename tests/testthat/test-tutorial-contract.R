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
  root <- Sys.getenv("GITHUB_WORKSPACE", unset = getwd())
  readme_path <- file.path(root, "README.md")
  guide_path <- file.path(root, "docs", "figure-tutorials.md")
  skip_if_not(file.exists(readme_path) && file.exists(guide_path), "source documentation is unavailable")
  readme <- paste(readLines(readme_path, warn = FALSE), collapse = "\n")
  guide <- paste(readLines(guide_path, warn = FALSE), collapse = "\n")

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
