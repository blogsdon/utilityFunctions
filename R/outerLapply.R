outerLapply <- function(FUN,X,Y,...){
  require(dplyr)
  internal <- function(X,Y,FUN,...){
    Y %>%
      lapply(FUN,X,...) %>%
      return
  }
  X %>%
    lapply(internal,Y,FUN,...) %>%
    return
}
