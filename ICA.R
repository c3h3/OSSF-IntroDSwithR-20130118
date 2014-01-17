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

ica_result = fastICA(origin, n.comp = 4)
ica_source = ica_result$S
dec_data = list()

for (i in 1:4) {
  temp = ica_source[, i]
  temp = round((temp - min(temp))/(max(temp) - min(temp)) * max(origin) + 
                 min(origin))
  temp = temp - min(temp)
  temp = Wave(left = temp, samp.rate = 8000, bit = 8)
  dec_data[[i]] = temp
  # listen(temp)
  writeWave(temp, paste("dec_source", as.character(i), ".wav", sep = ""))
}

par(mfrow=c(4,1))
for (i in 1:4) {
  plot(dec_data[[i]],col=i+1)
}  