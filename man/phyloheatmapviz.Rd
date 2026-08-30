\name{phyloheatmapviz}
\alias{rectangular_phylogeny}
\alias{circular_phylogeny}
\alias{clade_support_tree}
\alias{aligned_pangenome_tree}
\alias{annotated_expression_heatmap}
\alias{microbiome_heatmap}
\alias{mutation_oncoprint}
\alias{multiomics_heatmap}
\alias{correlation_heatmap}
\alias{validate_tip_alignment}
\title{Validated phylogenomic and complex heatmap visualizations}
\description{Reusable constructors for trees, aligned pangenomes, annotated omics matrices, oncoprints, and multi-omics heatmap lists.}
\usage{
rectangular_phylogeny(tree, metadata)
circular_phylogeny(tree, metadata)
clade_support_tree(tree, support_threshold = 70)
aligned_pangenome_tree(tree, pangenome, metadata = NULL)
annotated_expression_heatmap(expression, sample_metadata)
microbiome_heatmap(clr_matrix, sample_metadata)
mutation_oncoprint(alterations, sample_metadata)
multiomics_heatmap(expression, pathway, sample_metadata)
correlation_heatmap(expression, sample_metadata)
validate_tip_alignment(tree, object)
}
\arguments{
\item{tree}{An \code{ape::phylo} object.}
\item{metadata}{Tip metadata with explicit identifiers.}
\item{support_threshold}{Minimum displayed node-support percentage.}
\item{pangenome}{A tip-by-gene binary matrix.}
\item{expression}{A finite gene-by-sample numeric matrix.}
\item{sample_metadata}{Sample metadata in the same order as matrix columns.}
\item{clr_matrix}{A finite taxon-by-sample CLR matrix.}
\item{alterations}{A named character alteration matrix.}
\item{pathway}{A pathway-by-sample numeric matrix.}
\item{object}{An annotation matrix/data frame with identifiers.}
}
\value{A ggtree/ggplot object, a ComplexHeatmap object, or invisibly \code{TRUE} for validation.}
