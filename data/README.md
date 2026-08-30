# Data dictionary

All data are deterministic simulations for tutorials and software tests.

| File | Role |
|---|---|
| `pathogen_tree.nwk` | Newick topology with branch lengths and internal-node support labels |
| `tip_metadata.csv` | host, region, lineage, and resistance traits keyed by tree tip |
| `pangenome.csv` | binary isolate-by-gene presence–absence matrix |
| `sample_metadata.csv` | condition, batch, and subtype keyed by omics sample |
| `expression_zscores.csv` | row-standardized gene-expression matrix |
| `pathway_activity.csv` | pathway activity scores on the same samples |
| `microbiome_clr.csv` | centered-log-ratio microbial coordinates |
| `alterations.csv` | semicolon-delimited categorical somatic alterations |

