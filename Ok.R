library("wordcloud")
library("RColorBrewer")
#------------------------------------------------
setwd("/Users/miriamespino/Desktop/YHack 2019/")
library("stringr")
library(sentimentr)
library(wordcloud2)
library(text2vec) # needed for tokenizer
library(tm) # needed for stopwords
library(ggplot2)

# use readLines to return a character vector (each element is a line in the file)


filePath <- "Ok.txt"
text <- readLines(filePath)

docs <- Corpus(VectorSource(text))

#removing words
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removeWords, c("not", "n't"))

#term doc matric
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)


#word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

barplot(d[1:100,]$freq, las = 2, names.arg = d[1:100,]$word,
        col ="lightblue", main ="Frequent Nuetral Words",
        ylab = "Word frequencies")
