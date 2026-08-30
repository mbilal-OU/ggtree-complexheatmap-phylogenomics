assert_columns <- function(data, required, context = "data") {
  if (!is.data.frame(data)) stop(context, " must be a data frame.", call. = FALSE)
  missing <- setdiff(required, names(data))
  if (length(missing)) stop(context, " is missing columns: ", paste(missing, collapse = ", "), call. = FALSE)
  invisible(data)
}

#' Validate alignment between phylogeny tips and an annotation object
#' @param tree An `ape::phylo` object.
#' @param object A matrix/data frame with row names, or a metadata frame with a `tip` column.
#' @return Invisibly returns `TRUE`; otherwise raises a descriptive error.
#' @export
validate_tip_alignment <- function(tree, object) {
  if (!inherits(tree, "phylo")) stop("tree must inherit from ape::phylo.", call. = FALSE)
  ids <- if (is.data.frame(object) && "tip" %in% names(object)) object$tip else rownames(object)
  if (is.null(ids) || anyNA(ids) || anyDuplicated(ids)) stop("annotation identifiers must be present, unique, and non-missing.", call. = FALSE)
  missing <- setdiff(tree$tip.label, ids)
  extra <- setdiff(ids, tree$tip.label)
  if (length(missing) || length(extra)) {
    stop("tip identifiers do not align; missing: ", paste(missing, collapse = ", "), "; extra: ", paste(extra, collapse = ", "), call. = FALSE)
  }
  invisible(TRUE)
}

validate_numeric_matrix <- function(x, name = "matrix") {
  if (!is.matrix(x) || !is.numeric(x) || any(!is.finite(x))) stop(name, " must be a finite numeric matrix.", call. = FALSE)
  invisible(x)
}

