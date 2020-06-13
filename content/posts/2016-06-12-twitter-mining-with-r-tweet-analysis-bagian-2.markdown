---
title: 'Twitter Mining with R : Tweet Analysis, Bagian 2'
date: '2016-06-12 16:54:57'
tags:
- r
- programming
- text-mining
---

## Pengantar
Pada tulisan ini akan melanjutkan proses selanjutnya setelah mendapatkan data dengan Twitter API. Jika ingin mengunduh dataset tanpa mengambil online dari twitter, silakan unduh melalui link berikut : 

* [Tweet @RadioElshinta](https://rizkidoank.com/static/elshinta.RData)
* [Stopwords Indonesia](https://rizkidoank.com/static/stopwords.txt)

## Text Cleaning
Setelah akuisisi data, langkah selanjutnya adalah *Text Cleaning* . Tahapan ini meliputi sub-proses antara lain stopwords removal, whitespaces stripping, dan stemming.

    library(tm)
    library(SnowballC)
    load(file = "elshinta.RData")
    tweets.df <- twListToDF(tweets_data)
    
    corpus <- Corpus(VectorSource(tweets.df$text))

    # lowercase konten
    corpus <- tm_map(corpus,content_transformer(tolower))

    # hapus url, dan tanda baca
    removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
    corpus <- tm_map(corpus, content_transformer(removeURL))
    corpus <- tm_map(corpus, removePunctuation)
    
    # buat stopwords Indonesia
    file_stop <- file("stopwords.txt",open = "r")
    id_stopwords <- readLines(file_stop)
    close(file_stop)
    id_stopwords = c(id_stopwords, "amp")
    
    # hapus stopwords, angka, whitespace
    corpus <- tm_map(corpus, removeWords, id_stopwords)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, stripWhitespace)
    corpus <- tm_map(corpus, PlainTextDocument)
    
    # tampilkan konten tweet ke 125
    writeLines(strwrap(corpus[[125]]$content))

    # TDF dan DTF untuk corpus dataset elshinta
    dtm = DocumentTermMatrix(corpus)
    tdm = TermDocumentMatrix(corpus)

Untuk kasus ini, bahasa yang digunakan adalah bahasa Indonesia. Sedangkan pada R tidak tersedia untuk bahasa Indonesia. Sehingga, perlu membuat sendiri stopwords custom.

![Stopwords Bahasa Indonesia](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_02_01.jpg)

![Dataframe Tweets @RadioElshinta](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_02_02.jpg)

![Konten Tweet ke 120 dan 125](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_02_03.jpg)

![DTF dan TDF dari corpus](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_02_04.jpg)

Setelah dilakukan Text Cleaning, maka data siap diolah menjadi informasi lain. Tahap selanjutnya yaitu membuat statistik term frequency, dan membuat wordcloud dari TDF.