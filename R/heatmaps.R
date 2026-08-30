heat_colours <- circlize::colorRamp2(c(-2.5, 0, 2.5), c("#2166AC", "#F7F7F7", "#B2182B"))

#' Annotated standardized-expression heatmap
#' @export
annotated_expression_heatmap <- function(expression, sample_metadata) {
  validate_numeric_matrix(expression, "expression")
  assert_columns(sample_metadata, c("sample", "condition", "batch"), "sample metadata")
  if (!identical(colnames(expression), sample_metadata$sample)) stop("sample metadata must be ordered exactly like expression columns.", call. = FALSE)
  top <- ComplexHeatmap::HeatmapAnnotation(
    condition = sample_metadata$condition,
    batch = sample_metadata$batch,
    col = list(condition = c("Control" = "#3B82A0", "Treatment" = "#D95F59"))
  )
  ComplexHeatmap::Heatmap(expression, name = "Row z-score", col = heat_colours, top_annotation = top,
    column_split = sample_metadata$condition, cluster_columns = FALSE, row_names_gp = grid::gpar(fontsize = 8),
    column_title = "Annotated expression programs")
}

#' CLR microbiome heatmap with cohort annotation
#' @export
microbiome_heatmap <- function(clr_matrix, sample_metadata) {
  validate_numeric_matrix(clr_matrix, "CLR matrix")
  assert_columns(sample_metadata, c("sample", "cohort"), "sample metadata")
  if (!identical(colnames(clr_matrix), sample_metadata$sample)) stop("sample metadata must match CLR matrix columns.", call. = FALSE)
  top <- ComplexHeatmap::HeatmapAnnotation(cohort = sample_metadata$cohort, col = list(cohort = c("Healthy" = "#2A9D8F", "Disease" = "#E76F51")))
  ComplexHeatmap::Heatmap(clr_matrix, name = "CLR", col = circlize::colorRamp2(c(-2, 0, 2), c("#3B4CC0", "#F7F7F7", "#B40426")), top_annotation = top,
    column_split = sample_metadata$cohort, row_km = 2, show_column_names = FALSE, column_title = "CLR-transformed microbiome profiles")
}

#' Mutation oncoprint
#' @export
mutation_oncoprint <- function(alterations, sample_metadata) {
  if (!is.matrix(alterations) || is.null(rownames(alterations)) || is.null(colnames(alterations))) stop("alterations must be a named character matrix.", call. = FALSE)
  assert_columns(sample_metadata, c("sample", "subtype"), "sample metadata")
  if (!identical(colnames(alterations), sample_metadata$sample)) stop("sample metadata must match alteration columns.", call. = FALSE)
  colours <- c(SNV = "#D95F59", Amplification = "#E9C46A", Deletion = "#3B82A0")
  alter_fun <- list(
    background = function(x, y, w, h) grid::grid.rect(x, y, w * 0.95, h * 0.95, gp = grid::gpar(fill = "#F1F5F9", col = NA)),
    SNV = function(x, y, w, h) grid::grid.rect(x, y, w * 0.95, h * 0.32, gp = grid::gpar(fill = colours[["SNV"]], col = NA)),
    Amplification = function(x, y, w, h) grid::grid.rect(x, y, w * 0.95, h * 0.95, gp = grid::gpar(fill = colours[["Amplification"]], col = NA)),
    Deletion = function(x, y, w, h) grid::grid.rect(x, y, w * 0.95, h * 0.95, gp = grid::gpar(fill = colours[["Deletion"]], col = NA))
  )
  top <- ComplexHeatmap::HeatmapAnnotation(subtype = sample_metadata$subtype)
  ComplexHeatmap::oncoPrint(alterations, alter_fun = alter_fun, col = colours, top_annotation = top,
    remove_empty_columns = FALSE, column_title = "Somatic alteration landscape")
}

#' Integrated expression and pathway-activity heatmap list
#' @export
multiomics_heatmap <- function(expression, pathway, sample_metadata) {
  validate_numeric_matrix(expression, "expression")
  validate_numeric_matrix(pathway, "pathway")
  if (!identical(colnames(expression), colnames(pathway))) stop("expression and pathway matrices must share ordered columns.", call. = FALSE)
  assert_columns(sample_metadata, c("sample", "condition"), "sample metadata")
  if (!identical(colnames(expression), sample_metadata$sample)) stop("sample metadata must match matrix columns.", call. = FALSE)
  top <- ComplexHeatmap::HeatmapAnnotation(condition = sample_metadata$condition, col = list(condition = c("Control" = "#3B82A0", "Treatment" = "#D95F59")))
  h1 <- ComplexHeatmap::Heatmap(expression, name = "Expression z", col = heat_colours, top_annotation = top, column_split = sample_metadata$condition, cluster_columns = FALSE, column_title = "Genes")
  h2 <- ComplexHeatmap::Heatmap(pathway, name = "Activity", col = circlize::colorRamp2(c(-2, 0, 2), c("#542788", "#F7F7F7", "#B35806")), column_split = sample_metadata$condition, cluster_columns = FALSE, column_title = "Pathways")
  ComplexHeatmap::`%v%`(h1, h2)
}

#' Sample-correlation heatmap
#' @export
correlation_heatmap <- function(expression, sample_metadata) {
  validate_numeric_matrix(expression, "expression")
  assert_columns(sample_metadata, c("sample", "condition"), "sample metadata")
  if (!identical(colnames(expression), sample_metadata$sample)) stop("sample metadata must match expression columns.", call. = FALSE)
  similarity <- stats::cor(expression, method = "spearman")
  top <- ComplexHeatmap::HeatmapAnnotation(condition = sample_metadata$condition, col = list(condition = c("Control" = "#3B82A0", "Treatment" = "#D95F59")))
  ComplexHeatmap::Heatmap(similarity, name = "Spearman r", col = circlize::colorRamp2(c(-1, 0, 1), c("#2166AC", "#F7F7F7", "#B2182B")),
    top_annotation = top, show_row_names = FALSE, show_column_names = FALSE, column_title = "Sample similarity and potential outliers")
}
