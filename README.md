# Phylogenomic Visualization with ggtree + ComplexHeatmap

[![R-CMD-check](https://github.com/mbilal-OU/Biology-data-viz-ggtree-complexheatmap/actions/workflows/ci.yml/badge.svg)](https://github.com/mbilal-OU/Biology-data-viz-ggtree-complexheatmap/actions/workflows/ci.yml)
[![Gallery](https://github.com/mbilal-OU/Biology-data-viz-ggtree-complexheatmap/actions/workflows/gallery.yml/badge.svg)](https://github.com/mbilal-OU/Biology-data-viz-ggtree-complexheatmap/actions/workflows/gallery.yml)
[![Bioconductor](https://img.shields.io/badge/Bioconductor-3.23-87B13F)](https://bioconductor.org/)
[![License: MIT](https://img.shields.io/badge/license-MIT-2E7D32)](LICENSE.md)

A **tutorial-first, tested portfolio for aligned biological visualization**.
The central skill demonstrated here is coordination: tree tips, sample columns,
metadata rows, matrices, annotations, legends, and scientific interpretations
remain explicitly aligned from input validation through export.

All data are deterministic simulations for learning and testing—not biological
evidence.

## Start here

| Goal | Resource |
|---|---|
| Learn tree annotation and layouts | [`01_ggtree_foundations.Rmd`](tutorials/01_ggtree_foundations.Rmd) |
| Learn annotated and multi-panel heatmaps | [`02_complexheatmap_workflows.Rmd`](tutorials/02_complexheatmap_workflows.Rmd) |
| Reuse validated functions | [`R/trees.R`](R/trees.R) and [`R/heatmaps.R`](R/heatmaps.R) |
| Understand alignment safeguards | [`R/validation.R`](R/validation.R) |
| Review scientific limits | [`docs/scientific-practice.md`](docs/scientific-practice.md) |
| Browse rendered reference | [Documentation](https://mbilal-ou.github.io/Biology-data-viz-ggtree-complexheatmap/) |

## Visual tutorial gallery

The Gallery workflow regenerates every panel using the current Bioconductor
release. The first five focus on tree grammar and aligned matrices; the final
five demonstrate annotation-rich heatmap engineering.

| Phylogenomic analysis | Phylogenomic analysis |
|---|---|
| **1 · Host-annotated phylogeny**<br>![Rectangular phylogeny](figures/01_rectangular_phylogeny.png)<br>Tip metadata join through validated identifiers. | **2 · Circular geographic overview**<br>![Circular phylogeny](figures/02_circular_phylogeny.png)<br>Layout changes without changing topology or metadata meaning. |
| **3 · Internal-node support**<br>![Clade support](figures/03_clade_support.png)<br>Only support above a declared threshold is labelled. | **4 · Tree-aligned pangenome**<br>![Aligned pangenome](figures/04_aligned_pangenome.png)<br>Matrix rows are reordered to tree-tip order before rendering. |
| **5 · Resistance-gene context**<br>![Resistance gene context](figures/05_resistance_gene_context.png)<br>A focused binary gene panel stays aligned to evolutionary history. | **6 · Annotated expression programs**<br>![Expression heatmap](figures/06_expression_heatmap.png)<br>Condition, batch, splits, clustering, and row z-scores are explicit. |
| **7 · CLR microbiome profiles**<br>![Microbiome CLR heatmap](figures/07_microbiome_clr_heatmap.png)<br>Compositional coordinates replace raw-count colour mapping. | **8 · Somatic alteration oncoprint**<br>![Mutation oncoprint](figures/08_mutation_oncoprint.png)<br>SNVs, amplifications, deletions, subtype, and alteration burden coexist. |
| **9 · Integrated multi-omics heatmap**<br>![Multiomics heatmap](figures/09_multiomics_heatmap.png)<br>Expression and pathway activity share the same ordered samples. | **10 · Sample similarity**<br>![Sample correlation](figures/10_sample_correlation.png)<br>Clustered Spearman correlation supports batch and outlier review. |

## What this repository proves

| Skill | Evidence |
|---|---|
| ggtree grammar | Rectangular/circular layouts, tip annotations, node labels, aligned heatmaps |
| ComplexHeatmap engineering | Annotation tracks, splits, clustering, oncoprints, heatmap lists, legends |
| Phylogenomic alignment | Strict identifier checks and explicit row reordering |
| Omics transformations | Binary presence–absence, row z-scores, CLR coordinates, Spearman similarity |
| Reusable R design | Package API, namespaced dependencies, deterministic builders, documented failures |
| Reliability | testthat, R CMD check, coverage, and gallery regeneration on Bioconductor release |

## Quick start

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("ggtree", "ComplexHeatmap"))
remotes::install_github("mbilal-OU/Biology-data-viz-ggtree-complexheatmap")

library(phyloheatmapviz)
tree <- ape::read.tree("data/pathogen_tree.nwk")
metadata <- read.csv("data/tip_metadata.csv")
rectangular_phylogeny(tree, metadata)
```

## Scientific guardrails

- A tree layout is not a tree inference method; topology and branch lengths come from upstream analysis.
- Tip metadata must be joined by identifiers, never by incidental row order.
- Bootstrap or posterior support is not the probability that a biological narrative is true.
- Presence–absence matrices require a defined gene-calling and clustering workflow.
- Heatmap clustering depends on transformation, distance, linkage, filtering, and missing-data choices.
- Row z-scores support within-feature comparisons but remove absolute between-feature scale.
- CLR coordinates require documented zero handling and cannot be interpreted as proportions.
- Oncoprints summarize calls; they do not validate variant quality or clinical significance.

## Visualization portfolio series

- [Seaborn](https://github.com/mbilal-OU/biology-data-viz-seaborn) · [Matplotlib](https://github.com/mbilal-OU/biology-data-viz-matplotlib) · [Plotly](https://github.com/mbilal-OU/Biology-data-viz-plotly)
- [ggplot2](https://github.com/mbilal-OU/Biology-data-viz-ggplot2) · **ggtree + ComplexHeatmap** · [Shiny](https://github.com/mbilal-OU/Biology-data-viz-shiny) · [Gnuplot](https://github.com/mbilal-OU/biology-data-viz-gnuplot)

Citation metadata are in [`CITATION.cff`](CITATION.cff). Code is under the [MIT License](LICENSE.md).

