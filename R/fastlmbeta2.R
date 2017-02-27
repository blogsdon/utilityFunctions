fastlmbeta2 <- function(y,x,colId){
  library(dplyr)
  colId <- c('intercept',colId)
  X <- x %>% as.matrix
  n1 <- X %>% nrow
  X <- (1 %>% rep(n1)) %>% cbind(X)
  ginv <- t(X)%*%X %>% solve();
  Xhat <- ginv%*%t(X);
  betahat <- Xhat%*%y;
  #print('In cleaning')
  names(betahat) <- colId
  return(betahat);
}
