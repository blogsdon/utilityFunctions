convertSparseMatrixToGraph = function(sparseMatrix){
  library(igraph)
  return(igraph::graph_from_adjacency_matrix(sparseMatrix, mode = c( "upper")))
}
