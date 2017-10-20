list2df <- function(x){
  n1 <- names(x)
  internal <- function(x,y){
    return(data.frame(key=rep(y,length(x)),
                      value=x,
                      stringsAsFactors=F))
  }
  foo <- mapply(internal,
                x,
                n1,
                SIMPLIFY=F)
  foo <- do.call('rbind',foo)
  foo <- data.frame(foo,stringsAsFactors = F)
  return(foo)
}
