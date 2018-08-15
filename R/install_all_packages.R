install_all_packages <- function(package_names,bioconductor=FALSE){
  if(!bioconductor){
    fun1 <- function(pkg){
      try(install.packages(pkg),silent=T)
    }
  }else{
    fun1 <- function(pkg){
      source("https://bioconductor.org/biocLite.R")
      try(biocLite(pkg),silent=T)

    }
  }
  sapply(package_names,fun1)
  res1 <- installed.packages()
  return(setdiff(package_names,res1[,1]))
}
