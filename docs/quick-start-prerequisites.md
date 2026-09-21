# Quick-start prerequisites

The README quick start assumes a recent R/Bioconductor environment and two CRAN packages that are not core R packages.

Before running the example, verify that **R 4.6 or newer** is available; this matches the package's `DESCRIPTION` requirement.

```r
R.version.string
install.packages(c("remotes", "ape"))
```

Then install the Bioconductor dependencies and this repository as shown in the README. `remotes` provides `install_github()`, while `ape` provides `read.tree()` used by the example.

If installation reports that the current R version is too old, upgrade R before troubleshooting individual package dependencies. Keeping the R version aligned with `DESCRIPTION` avoids resolving an environment that the package does not support.
