varCompWrapperFunction <- function(outcome,fixed,randomFeatures){
  library(varComp)
  ####features have to be in observations as rows and features as column format
  kernel <- cor(t(randomfeatures),
                use = 'pairwise.complete.obs')
  alternativeModel <- varComp::varComp(outcome~fixed,
                                       varcov=kernel)
  nullModel <- varComp::varComp(outcome~fixed)

  model <- list()
  model$totalVariance <- as.numeric(var(outcome))
  model$varianceExplained <- as.numeric(alternativeModel$varComps[1])
  model$percentVarianceExplained <- model$varianceExplained/model$totalVariance
  model$errorVarianceExplained <- as.numeric(alternativeModel$sigma2)
  model$LRT <- 2*(logLik(alternativeModel)[1]-logLik(nullModel)[1])

  pVarianceLRT <- function(x){
    x <- round(x,8)
    if(x==0){
      return(0.5)
    }else{
      return(0.5*pchisq(x,1,lower.tail=F))
    }
  }

  model$pvalue <-pVarianceLRT(model$LRT)
  return(model)
}
