.libPaths("/home/c3h3/R/library")

library(Rwordseg)
library(tm)

setwd("/home/c3h3/c3h3Works/MLDM_Projects/OSSF-IntroDSwithR-20130118")
load("PTT_Articles.RData")

# boards = c("Boy-Girl","BuyTogether","C_and_CPP","Food","Hate","job","LoL","Python","R_Language","Soft_Job","StarCraft","StudyGroup","Math")
# clean_arts_ix = which(as.character(article_df$Board) %in% boards)
# article_df = article_df[clean_arts_ix,]
# article_df$Title = as.character(article_df$Title)
# article_df$text = as.character(article_df$text)
# article_df$Board = as.factor(as.character(article_df$Board))
# save(article_df, file = "PTT_Articles.RData")

board_name = "R_Language"

get_board_articles = function(board_name){
#   start = min(which(article_df$Board == board_name))
#   end = max(which(article_df$Board == board_name))
#   return(article_df[start:end,])
  return(article_df[which(article_df$Board == board_name),])
}

get_author_articles = function(author_name){
  #   start = min(which(article_df$Board == board_name))
  #   end = max(which(article_df$Board == board_name))
  #   return(article_df[start:end,])
  return(article_df[which(article_df$Author == author_name),])
}

r_arts = get_board_articles(board_name)
summary(r_arts$Author)
wush = names(summary(r_arts$Author))[1]
summary(get_author_articles(wush)$Board)







