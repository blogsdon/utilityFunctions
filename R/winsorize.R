winsorize <- function(x,per=.99){
  up <- quantile(x,per)
  low <- quantile(x,1-per)
  x[x>=up] <- up
  x[x<=low] <- low
  return(x)
}
