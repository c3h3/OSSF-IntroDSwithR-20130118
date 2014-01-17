.libPaths("/home/c3h3/R/library")

library(fastICA)
library(tuneR)
# library(seewave)

setwd("/home/c3h3/c3h3Works/MLDM_Projects/OSSF-IntroDSwithR-20130118/wavs")

origin = matrix(0, nrow = 50000, ncol = 4)
data_list = list()


for (i in 1:4) {
  filename = paste("110010001mix", as.character(i), ".wav", sep = "")
  data = readWave(filename)
  data_list[[i]] = data
  # listen(data)
  origin[, i] = data@left
  
}


par(mfrow=c(4,1))
for (i in 1:4) {
  plot(data_list[[i]],col=i+1)
}  


