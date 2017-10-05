pairwiseMatrixOfEnrichments(key,value){
  #get unique keys
  unique_keys <- unique(key)
  unique_values <- unique(value)
  #create list of key value
  #df <- data.frame(keys=key,values=value,stringsAsFactors=F)

  #listify
  dfList <- utilityFunctions::listify(unique_keys,
                                      value,
                                      key)
  names(dfList) <- unique_keys
  res <- list()

  library(dplyr)

  res$pval <- utilityFunctions::fisherWrapperPval %>%
    utilityFunctions::outerSapplyParallel(dfList,
                                          dfList,
                                          unique_values)

  res$or <- utilityFunctions::fisherWrapperOR %>%
    utilityFunctions::outerSapplyParallel(dfList,
                                          dfList,
                                          unique_values)
  return(res)
}
