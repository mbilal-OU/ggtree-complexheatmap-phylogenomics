library(phyloheatmapviz)

read_matrix <- function(path, mode = "numeric") {
  x <- read.csv(path, check.names = FALSE)
  ids <- x[[1]]
  x <- as.matrix(x[-1])
  rownames(x) <- ids
  if (mode == "numeric") storage.mode(x) <- "numeric"
  x
}

save_heatmap <- function(object, filename, width = 1800, height = 1200) {
  grDevices::png(filename, width = width, height = height, res = 170, bg = "white")
  grid::grid.newpage()
  ComplexHeatmap::draw(object, merge_legends = TRUE, heatmap_legend_side = "right", annotation_legend_side = "right")
  grDevices::dev.off()
}

dir.create("figures", showWarnings = FALSE, recursive = TRUE)
tree <- ape::read.tree("data/pathogen_tree.nwk")
metadata <- read.csv("data/tip_metadata.csv")
pangenome <- read_matrix("data/pangenome.csv")
samples <- read.csv("data/sample_metadata.csv")
expression <- read_matrix("data/expression_zscores.csv")
pathway <- read_matrix("data/pathway_activity.csv")
microbiome <- read_matrix("data/microbiome_clr.csv")
alterations <- read_matrix("data/alterations.csv", mode = "character")

ggplot2::ggsave("figures/01_rectangular_phylogeny.png", rectangular_phylogeny(tree, metadata), width = 9, height = 6.5, dpi = 170, bg = "white")
ggplot2::ggsave("figures/02_circular_phylogeny.png", circular_phylogeny(tree, metadata), width = 8, height = 8, dpi = 170, bg = "white")
ggplot2::ggsave("figures/03_clade_support.png", clade_support_tree(tree, 80), width = 9, height = 6.3, dpi = 170, bg = "white")
ggplot2::ggsave("figures/04_aligned_pangenome.png", aligned_pangenome_tree(tree, pangenome), width = 12, height = 7.5, dpi = 170, bg = "white")
ggplot2::ggsave("figures/05_resistance_gene_context.png", aligned_pangenome_tree(tree, pangenome[, 1:8, drop = FALSE]), width = 10, height = 7.2, dpi = 170, bg = "white")
save_heatmap(annotated_expression_heatmap(expression, samples), "figures/06_expression_heatmap.png")
save_heatmap(microbiome_heatmap(microbiome, transform(samples, cohort = ifelse(condition == "Control", "Healthy", "Disease"))), "figures/07_microbiome_clr_heatmap.png")
save_heatmap(mutation_oncoprint(alterations, samples), "figures/08_mutation_oncoprint.png", 1900, 1150)
save_heatmap(multiomics_heatmap(expression, pathway, samples), "figures/09_multiomics_heatmap.png", 1800, 1900)
save_heatmap(correlation_heatmap(expression, samples), "figures/10_sample_correlation.png", 1500, 1350)

message("Generated ten phylogenomic gallery figures.")

