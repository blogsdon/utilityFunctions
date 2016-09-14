computeRefGeneStat <- function(targetGene,referenceList,Graph){
  library(dplyr)
  #minDistFxn: igraph fxn that computes minimum path length between two nodes
  library(igraph)
  networkDistanceScore <- sapply(referenceList,minDistFxn,targetGene,Graph) %>%
    mean
  return(networkDistanceScore)
}

require(synapseClient)
synapseLogin()
foo <- synGet('syn5908669')
graph1 <- graph_from_adjacency_matrix(bicNetworks$rankConsensus$network, mode = c( "upper"))

geneSet <- sample(colnames(bicNetworks$rankConsensus$network),100)

bar <- igraph::distances(graph1,1:100,colnames(bicNetworks$rankConsensus$network)%in%geneSet)
bar[!is.finite(bar)]<-NA
rowMeans(bar,na.rm=T)[1:5]




