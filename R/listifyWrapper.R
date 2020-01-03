listifyWrapper = function(x,y){
  uniqueKeys <- unique(x)
  res <- lapply(uniqueKeys,
                utilityFunctions::listify,
                y,
                x)
  names(res) <- uniqueKeys
  return(res)
}
