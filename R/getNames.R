getNames <- function(x){
  bar <- NULL
  try(bar <- names(x),silent=T)
  return(bar)
}
