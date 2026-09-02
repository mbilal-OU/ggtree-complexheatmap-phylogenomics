# Tree-aligned phylogenomics figure tutorials

Each tutorial identifies the upstream biological object, exact constructor,
alignment rules, own-data workflow, and interpretation boundary. The bundled
tree, matrices, and metadata are deterministic simulations.

```r
library(phyloheatmapviz)
```

## 01 Host-annotated phylogeny

- **Use when:** tip-associated categories should be shown on a rectangular tree
  without changing topology.
- **Data and code:** [`pathogen_tree.nwk`](../data/pathogen_tree.nwk),
  [`tip_metadata.csv`](../data/tip_metadata.csv), and
  [`rectangular_phylogeny()`](../R/trees.R).
- **Use your own data:** read a valid Newick tree with `ape::read.tree()`. Supply
  metadata with one row per tip and exactly matching identifiers.
- **Interpret:** color describes supplied host metadata. Clade concentration is
  descriptive and does not establish host adaptation or transmission.

## 02 Circular geographic overview

- **Use when:** many tips and compact metadata display make a circular layout
  useful.
- **Data and code:** the same tree and metadata as tutorial 01, rendered by
  [`circular_phylogeny()`](../R/trees.R).
- **Use your own data:** pass the validated tree and tip table to the function;
  shorten labels or increase figure size for large trees.
- **Interpret:** circular placement changes display geometry only. It does not
  change rooting, branch length, topology, support, or evolutionary meaning.

## 03 Internal-node support

- **Use when:** selected bootstrap or posterior support values should be shown
  at internal nodes.
- **Data and code:** [`pathogen_tree.nwk`](../data/pathogen_tree.nwk) and
  [`clade_support_tree()`](../R/trees.R).
- **Use your own data:** ensure node labels contain the support measure you
  intend, then set a declared threshold such as
  `clade_support_tree(tree, support_threshold = 80)`.
- **Interpret:** support quantifies stability under a particular analysis. It is
  not the probability that a biological story or named clade is true.

## 04 Tree-aligned pangenome

- **Use when:** binary gene-family presence must be aligned exactly to tree-tip
  order.
- **Data and code:** [`pathogen_tree.nwk`](../data/pathogen_tree.nwk),
  [`pangenome.csv`](../data/pangenome.csv), and
  [`aligned_pangenome_tree()`](../R/trees.R).
- **Use your own data:** use tip labels as matrix row names, binary gene-family
  columns, and no duplicated or missing IDs. Validation must pass before drawing.
- **Interpret:** visible blocks show supplied gene calls on the tree. Gain, loss,
  convergence, and horizontal transfer require explicit evolutionary analysis.

## 05 Resistance-gene context

- **Use when:** a focused set of binary resistance determinants should be
  compared in evolutionary context.
- **Data and code:** a selected column subset from
  [`pangenome.csv`](../data/pangenome.csv), passed to
  [`aligned_pangenome_tree()`](../R/trees.R).
- **Use your own data:** build a validated tip-by-gene binary matrix from a
  documented caller and database version. Keep uncertain calls distinct if used.
- **Interpret:** presence is not phenotype, expression, or clinical resistance.
  Detection thresholds and assembly quality influence absence calls.

## 06 Annotated expression programs

- **Use when:** a numeric expression matrix needs sample annotations, splits,
  clustering, and controlled legends.
- **Data and code:** [`expression_zscores.csv`](../data/expression_zscores.csv),
  [`sample_metadata.csv`](../data/sample_metadata.csv), and
  [`annotated_expression_heatmap()`](../R/heatmaps.R).
- **Use your own data:** supply a numeric gene-by-sample matrix whose column names
  match metadata sample IDs. Document normalization, scaling, filtering, distance,
  and linkage.
- **Interpret:** row z-scores compare each gene relative to itself. They do not
  compare absolute abundance across genes or show significance.

## 07 CLR microbiome profiles

- **Use when:** a sample-by-taxon composition has already been transformed to
  centered-log-ratio coordinates.
- **Data and code:** [`microbiome_clr.csv`](../data/microbiome_clr.csv), sample
  metadata, and [`microbiome_heatmap()`](../R/heatmaps.R).
- **Use your own data:** perform and document zero replacement and CLR
  transformation upstream. Align matrix columns with metadata sample IDs.
- **Interpret:** colors are log-ratio coordinates, not proportions. Clustering
  depends on filtering, replacement, distance, and linkage.

## 08 Somatic alteration oncoprint

- **Use when:** several alteration types and sample annotations should be
  summarized in one sparse event matrix.
- **Data and code:** [`alterations.csv`](../data/alterations.csv), sample metadata,
  and [`mutation_oncoprint()`](../R/heatmaps.R).
- **Use your own data:** use genes as rows, samples as columns, and documented
  alteration codes. Match every sample identifier before plotting.
- **Interpret:** an oncoprint summarizes supplied calls. It does not validate
  variant quality, clonality, pathogenicity, or clinical significance.

## 09 Integrated multi-omics heatmap

- **Use when:** multiple feature matrices must share one ordered set of samples
  and coordinated annotations.
- **Data and code:** [`expression_zscores.csv`](../data/expression_zscores.csv),
  [`pathway_activity.csv`](../data/pathway_activity.csv), metadata, and
  [`multiomics_heatmap()`](../R/heatmaps.R).
- **Use your own data:** align all matrices by exact sample IDs and document each
  assay's normalization and scale before composing the heatmap list.
- **Interpret:** aligned patterns suggest hypotheses across assays. They do not
  demonstrate regulation, mediation, or causal coupling.

## 10 Sample similarity

- **Use when:** pairwise sample association should support batch, replicate, and
  outlier review.
- **Data and code:** [`expression_zscores.csv`](../data/expression_zscores.csv),
  sample metadata, and [`correlation_heatmap()`](../R/heatmaps.R).
- **Use your own data:** provide a processed numeric feature-by-sample matrix,
  align metadata, and decide whether Spearman correlation is appropriate.
- **Interpret:** high correlation indicates similar rank profiles under the
  selected features. It does not establish sample identity or absence of bias.

## Reproduce the gallery

```bash
Rscript -e 'testthat::test_local()'
Rscript scripts/build_gallery.R
```

Read [`R/validation.R`](../R/validation.R) before adapting the examples. It
defines the identifier and numeric-matrix checks that prevent silent misalignment.
