tree <- ape::read.tree(text = "((A:0.1,B:0.1)95:0.2,(C:0.1,D:0.1)80:0.2)99;")
metadata <- data.frame(tip = c("A", "B", "C", "D"), host = c("Human", "Bird", "Environment", "Human"), region = c("N", "S", "E", "W"), lineage = c("L1", "L1", "L2", "L2"))

test_that("tip alignment is strict and descriptive", {
  expect_true(validate_tip_alignment(tree, metadata))
  expect_error(validate_tip_alignment(tree, transform(metadata, tip = c("A", "B", "C", "X"))), "do not align")
  expect_error(validate_tip_alignment("not a tree", metadata), "ape::phylo")
})

test_that("tree constructors return ggtree objects", {
  expect_s3_class(rectangular_phylogeny(tree, metadata), "ggplot")
  expect_s3_class(circular_phylogeny(tree, metadata), "ggplot")
  expect_s3_class(clade_support_tree(tree, 70), "ggplot")
  expect_error(clade_support_tree(tree, 101), "\\[0, 100\\]")
})

test_that("pangenome values and row identities are validated", {
  x <- matrix(c(0, 1), nrow = 4, ncol = 2, dimnames = list(tree$tip.label, c("g1", "g2")))
  expect_s3_class(aligned_pangenome_tree(tree, x), "ggplot")
  x[1, 1] <- 2
  expect_error(aligned_pangenome_tree(tree, x), "0/1")
})

test_that("heatmaps require finite matrices and ordered metadata", {
  x <- matrix(seq(-1, 1, length.out = 24), 6, 4, dimnames = list(paste0("g", 1:6), paste0("S", 1:4)))
  pathway <- matrix(seq(-.5, .5, length.out = 12), 3, 4, dimnames = list(paste0("p", 1:3), paste0("S", 1:4)))
  samples <- data.frame(sample = paste0("S", 1:4), condition = rep(c("Control", "Treatment"), each = 2), batch = rep(c("B1", "B2"), 2), subtype = rep(c("A", "B"), 2))
  expect_s4_class(annotated_expression_heatmap(x, samples), "Heatmap")
  expect_s4_class(microbiome_heatmap(x, transform(samples, cohort = condition)), "Heatmap")
  expect_s4_class(multiomics_heatmap(x, pathway, samples), "HeatmapList")
  expect_s4_class(correlation_heatmap(x, samples), "Heatmap")
  expect_error(annotated_expression_heatmap(x, samples[4:1, ]), "ordered exactly")
})

test_that("oncoprint checks sample identity", {
  x <- matrix(c("SNV", "", "Deletion", "Amplification"), 1, 4, dimnames = list("TP53", paste0("S", 1:4)))
  samples <- data.frame(sample = paste0("S", 1:4), subtype = rep(c("A", "B"), 2))
  expect_s4_class(mutation_oncoprint(x, samples), "Heatmap")
  expect_error(mutation_oncoprint(x, samples[4:1, ]), "must match")
})

