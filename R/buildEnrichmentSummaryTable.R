buildEnrichmentSummaryTable <- function(x){
  require(dplyr)
  require(data.table)

  internal <- function(y,x){
    x <- arrange(x,fdr)
    green <- filter(x,ComparisonName==y)
    greenSplit <- lapply(names(table(green$Category)),function(x,y) return(filter(y,Category==x)),green)
    names(greenSplit) <- names(table(green$Category))
    summarygreen <- do.call(rbind,lapply(greenSplit,function(x) return(x[1,c('GeneSetName','Category','pval','noverlap','Odds.Ratio','fdr','Genes')])))
    try(summarygreen <- arrange(summarygreen,fdr),silent=TRUE)
    return(summarygreen)
  }
  nameKeep <- unique(x$ComparisonName)
  res <- lapply(nameKeep,internal,x)
  names(res) <- nameKeep
  return(res)

}
