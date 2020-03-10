#załadpwanie bibliotek
library(tm)

#zmiana katalogu roboczego
workDir <- "D:\\md\\PJN\\"
setwd(workDir)

#definicja katalogow funkcjonalnych
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptsDir <- ".\\scripts"
workspacesDir <- ".\\workspaces"

#utworzenie katalogu wyjsciowego
dir.create(outputDir, showWarnings = FALSE)
dir.create(workspacesDir, showWarnings = FALSE)

#utworzenie korpusu dokumentów
corpusDir <- paste(inputDir,"Literatura - streszczenia - oryginał", sep="\\")
corpus <- VCorpus(
  DirSource(corpusDir, pattern = "*.txt", encoding = "UTF-8"),  
  readerControl = list(language = "pl_PL")
)

#wstepne przetwarzanie
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))

stoplistFile <- paste(inputDir, "stopwords_pl.txt", sep = "\\")

stoplist <- readLines(stoplistFile, encoding = "UTF-8")
corpus <- tm_map(corpus, removeWords, stoplist)
corpus <- tm_map(corpus, stripWhitespace)

writeLines(as.character(corpus[1]))
writeLines(corpus[1]$content)
