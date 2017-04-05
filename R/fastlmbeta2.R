fastlmbeta2 <- function(y,x,n2){
  library(dplyr)
  X <- x %>% as.matrix
  n1 <- X %>% nrow
  X <- (1 %>% rep(n1)) %>% cbind(X)
  ginv <- t(X)%*%X %>% solve();
  Xhat <- ginv%*%t(X);
  betahat <- Xhat%*%y;
  #n1 <- colnames(x)
  betahat <- c(betahat)
  #print(n2)
  names(betahat) <- c('intercept',n2)
  #print('In cleaning')
  return(betahat);
}
