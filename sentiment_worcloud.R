library(readr)
library(tm)
library(SnowballC)
library(wordcloud) 

#Import the data set into the R-Studio
dem <-demonetization

#Tokenising the data
dem_txt <- Corpus(VectorSource(dem$text))

#Converting the data into text document
dem_txt <- tm_map(dem_txt, PlainTextDocument)

#Data Cleaning 
#Remove the punctuation
dem_txt <- tm_map(dem_txt, removePunctuation)

dem_txt <- tm_map(dem_txt, removeWords, stopwords('english'))


dem_txt <- tm_map(dem_txt, stemDocument)
dem_txt <- tm_map(dem_txt, removeWords, c('the', 'this', stopwords('english')))


#wordcloud(dem_txt, max.words = 150, random.order = FALSE)

wordcloud(dem_txt, min.freq = 50,
          max.words=150, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"), scale = c(3,0.5))

