convertAdjacencyToEdgeList <- function(adj){
  library(dplyr)
  foo <- igraph::graph_from_adjacency_matrix(adj,mode='undirected') %>%
    igraph::as_edgelist()
  return(foo)
}
