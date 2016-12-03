library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(syuzhet)

#Import the dataset demonetization-tweets.csv
#The dataset consists of 8000 entries

demonit <- demonetization 
demonit_text<-as.character(demonit$text)

#The following steps are to clean the data

#removing Retweets

sentiment_txt<-gsub("(RT|via)((?:\\b\\w*@\\w+)+)","",demonit_text,ignore.case = TRUE)

#clean html links

sentiment_txt<-gsub("http[^[:blank:]]+","",sentiment_txt,ignore.case = TRUE)

#  remove people names

sentiment_txt<-gsub("@\\w+","",sentiment_txt,ignore.case = TRUE)

#  remove punctuations

sentiment_txt<-gsub("[[:punct:]]"," ",sentiment_txt,ignore.case = TRUE)

#  remove number (alphanumeric)

sentiment_txt<-gsub("[^[:alnum:]]"," ",sentiment_txt,ignore.case = TRUE)



mysentiment<-get_nrc_sentiment((sentiment_txt))
#used to classify sentiment scores

Sentimentscores<-data.frame(colSums(mysentiment[,]))
names(Sentimentscores)<-"Score"
SentimentScores<-cbind("sentiment"=rownames(Sentimentscores),Sentimentscores)
rownames(SentimentScores)<-NULL
ggplot(data=SentimentScores,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("emotion")+ylab("scores")+ggtitle("Total sentiment based on Tweets")

#Looks like demonitization is good move by the government
#Also mixed emotions by the different categories of people
#seems like majority of people feel positive about demonitization!!!!
#There are people who feel negative about it, mixed feelings eh??
