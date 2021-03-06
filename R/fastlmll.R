fastlmll <- function(y,x=NULL){
  require(dplyr)
  if(!is.null(x)){
    X <- x %>% as.matrix
    n1 <- X %>% nrow
    X <- (1 %>% rep(n1)) %>% cbind(X)
  }else{
    n1 <- length(y)
    X <- as.matrix(rep(1,n1))
  }
  ginv <- t(X)%*%X %>% solve();
  Xhat <- ginv%*%t(X);
  betahat <- Xhat%*%y;
  sig <- (((y-X%*%betahat)^2) %>% mean);
  #print('In cleaning')
  return(-0.5*n1*(log(sig)+1+log(2*pi)));
}
