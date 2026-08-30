tree_palette <- c("Human" = "#D95F59", "Bird" = "#3B82A0", "Environment" = "#2A9D8F")

#' Metadata-annotated rectangular phylogeny
#' @export
rectangular_phylogeny <- function(tree, metadata) {
  assert_columns(metadata, c("tip", "host", "lineage"), "tip metadata")
  validate_tip_alignment(tree, metadata)
  p <- ggtree::ggtree(tree, linewidth = 0.65)
  p <- ggtree::`%<+%`(p, metadata)
  p +
    ggtree::geom_tippoint(ggplot2::aes(colour = host, shape = lineage), size = 2.8) +
    ggtree::geom_tiplab(ggplot2::aes(label = label), size = 2.5, align = TRUE, linesize = 0.25) +
    ggplot2::scale_colour_manual(values = tree_palette) +
    ggplot2::labs(title = "Pathogen phylogeny and host context", subtitle = "Tip metadata are joined by explicit identifiers", colour = "Host", shape = "Lineage") +
    ggtree::theme_tree2() +
    ggplot2::theme(legend.position = "bottom", plot.title = ggplot2::element_text(face = "bold", colour = "#153243"))
}

#' Circular phylogeny with geographic metadata
#' @export
circular_phylogeny <- function(tree, metadata) {
  assert_columns(metadata, c("tip", "region", "host"), "tip metadata")
  validate_tip_alignment(tree, metadata)
  p <- ggtree::ggtree(tree, layout = "circular", linewidth = 0.55)
  p <- ggtree::`%<+%`(p, metadata)
  p + ggtree::geom_tippoint(ggplot2::aes(colour = region, shape = host), size = 2.4) +
    ggplot2::scale_colour_viridis_d(option = "D", end = 0.9) +
    ggplot2::labs(title = "Circular phylogeny with sampling geography", colour = "Region", shape = "Host") +
    ggtree::theme_tree() + ggplot2::theme(legend.position = "right", plot.title = ggplot2::element_text(face = "bold"))
}

#' Phylogeny with internal-node support labels
#' @export
clade_support_tree <- function(tree, support_threshold = 70) {
  if (!inherits(tree, "phylo")) stop("tree must inherit from ape::phylo.", call. = FALSE)
  if (!is.numeric(support_threshold) || length(support_threshold) != 1 || support_threshold < 0 || support_threshold > 100) stop("support_threshold must be in [0, 100].", call. = FALSE)
  ggtree::ggtree(tree, linewidth = 0.7) +
    ggtree::geom_tiplab(size = 2.4) +
    ggtree::geom_text2(ggplot2::aes(subset = !isTip & suppressWarnings(as.numeric(label)) >= support_threshold, label = label), hjust = -0.2, size = 2.6, colour = "#B91C1C") +
    ggplot2::labs(title = "Internal-node support", subtitle = paste0("Only support >= ", support_threshold, "% is labelled")) +
    ggtree::theme_tree2() + ggplot2::theme(plot.title = ggplot2::element_text(face = "bold"))
}

#' Align a pangenome matrix to a phylogeny
#' @export
aligned_pangenome_tree <- function(tree, pangenome, metadata = NULL) {
  validate_tip_alignment(tree, pangenome)
  if (!all(pangenome %in% c(0, 1))) stop("pangenome must contain only 0/1 presence-absence values.", call. = FALSE)
  p <- ggtree::ggtree(tree, linewidth = 0.55) + ggtree::geom_tiplab(size = 2.2)
  ggtree::gheatmap(p, pangenome[tree$tip.label, , drop = FALSE], offset = 0.08, width = 0.62, colnames_angle = 90, colnames_offset_y = 0.5, font.size = 2.1) +
    ggplot2::scale_fill_gradient(low = "#F1F5F9", high = "#256D85", breaks = c(0, 1), name = "Gene present") +
    ggplot2::labs(title = "Phylogeny-aligned pangenome", subtitle = "Rows are reordered to the tree before plotting") +
    ggplot2::theme(plot.title = ggplot2::element_text(face = "bold"))
}
