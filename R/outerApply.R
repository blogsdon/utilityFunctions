outerApply <- function(FUN,X,Y,...){
  require(dplyr)
  pb <- progress::progress_bar$new(total=length(X))
  internal <- function(X,Y,FUN,...){
    pb$tick()
    return(Y%>% apply(2,FUN,X,...))
  }
  return(X %>% apply(2,internal,Y,FUN,...))
}
