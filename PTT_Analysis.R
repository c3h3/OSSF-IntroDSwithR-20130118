boards = c("Boy-Girl","BuyTogether","C_and_CPP","Food","Hate","job","LoL","Python","R_Language","Soft_Job","StarCraft","StudyGroup","Math")
board_name = "BuyTogether"
r_arts = get_board_articles(board_name)
data.wired.segmentCN <-segmentCN(r_arts$Title)

data.wired.Corpus <- Corpus(VectorSource(data.wired.segmentCN))

data.wired.TDM <- TermDocumentMatrix(data.wired.Corpus)

# inspect(data.wired.DTM[1:5,900:2000])
findFreqTerms(data.wired.TDM)


termFrequency <- rowSums(as.matrix(data.wired.TDM))
termFrequency_p <- termFrequency / sum(termFrequency)
termFrequency <- subset(termFrequency, termFrequency>=1)
termFrequency_p <- subset(termFrequency_p, termFrequency_p>0.005)

library(ggplot2)
qplot(names(termFrequency_p), termFrequency_p, geom="bar") + coord_flip()


library(wordcloud)
m <- as.matrix(data.wired.TDM)
# calculate the frequency of words and sort it descendingly by frequency
wordFreq <- sort(rowSums(m), decreasing=TRUE)
wordFreq <- wordFreq[1:100]
# word cloud
set.seed(375) # to make it reproducible
grayLevels <- gray( (wordFreq+10) / (max(wordFreq)+10) )
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=15, random.order=F,colors=grayLevels)



myTdm2 <- removeSparseTerms(data.wired.TDM, sparse=0.95)
m2 <- as.matrix(myTdm2)

# cluster terms
distMatrix <- dist(scale(m2))
fit <- hclust(distMatrix, method="ward")
plot(fit)
# cut tree into 10 clusters
rect.hclust(fit, k=10)
(groups <- cutree(fit, k=10))

# transpose the matrix to cluster documents (tweets)
m3 <- t(m2)
# set a fixed random seed
set.seed(122)
# k-means clustering of tweets
k <- 8
kmeansResult <- kmeans(m3, k)
# cluster centers
round(kmeansResult$centers, digits=3)


for (i in 1:k) {
  cat(paste("cluster ", i, ": ", sep=""))
  s <- sort(kmeansResult$centers[i,], decreasing=T)
  cat(names(s)[1:3], "\n")
  # print the tweets of every cluster
  # print(rdmTweets[which(kmeansResult$cluster==i)])
}