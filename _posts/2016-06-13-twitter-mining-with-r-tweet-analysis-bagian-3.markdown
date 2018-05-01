---
layout: post
title: 'Twitter Mining with R : Tweet Analysis, Bagian 3'
date: '2016-06-13 07:01:36'
tags:
- r
- programming
- text-mining
---

Pada post sebelumnya di [Twitter Mining with R : Tweet Analysis, Bagian 2](https://rizkidoank.com/2016/06/12/twitter-mining-with-r-tweet-analysis-bagian-2/), saya sudah mencoba untuk melakukan Text Cleaning untuk dataset yang ada. Selanjutnya, pada bagian ini saya akan mencoba membuat statistik term frequency dan juga membuat wordcloud dari term document frequency.

## Statistik Terms Frequency
Sebelumnya, saya memiliki variabel `tdm` yang merupakan term document frequency. *Nah*, untuk membuat plot statistik frekuensi term saya menggunakan `ggplot2`, terlebih dahulu install paket `ggplot2` dengan perintah `install.package("ggplot2")` di RStudio. Kemudian, setelah terpasang saya membuat grafik dengan kode seperti berikut :

    library(ggplot2)
    term.freq <- rowSums(as.matrix(tdm))
    term.freq <- subset(term.freq, term.freq >= 5)
    df <- data.frame(term = names(term.freq), freq = term.freq)
    ggplot(df, aes(x=term, y=freq)) + geom_bar(stat="identity") +
    xlab("Terms") + ylab("Count") + coord_flip() +
    theme(axis.text=element_text(size=7))

Inti dari kode tersebut adalah membuat grafik bar dengan sumbu `x` berupa term, dan sumbu `y` berupa frekuensi dengan ketentuan frekeunsi yang ditampilkan adalah `term.freq >= 5`. Sehingga, akan dihasilkan grafik sebagai berikut :
![Statistik Terms Frequency](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_03_01.jpg)

Dari grafik tersebut saya dapat mengetahui term apa saja yang banyak muncul dari tweet @RadioElshinta.

## Wordcloud
Sekarang saya akan mencoba membuat wordcloud dari tweet @RadioElshinta. Untuk membuat wordcloud saya gunakan library `RColorBrewer`, maka install dahulu paket jika belum tersedia dengan perintah `install.package("RColorBrewer")`. Setelah itu, saya mencoba membuat wordcloud dengan kode :

    library(RColorBrewer)
    library(wordcloud)
    m <- as.matrix(tdm)
    word.freq <- sort(
        rowSums(m),
        decreasing = T
    )
    pal <- brewer.pal(9, "BuGn")[-(1:4)]
    # plot word cloud
    wordcloud(
        words = names(word.freq),
        freq = word.freq,
        min.freq = 3,
        random.order = F,
        colors = pal
    )

`word.freq <- sort(rowSums(m),decreasing = T)` bermaksud menghitung frequency tiap term, lalu diurutkan *descending*. Kode ini membuat wordcloud dengan frekuensi term minimal adalah 3. Hasil dari eksekusinya adalah sebagai berikut.
![Wordcloud](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_03_02.png)

Itulah wordcloud dan grafik frekuensi term yang telah dibuat, menarik bukan? Selanjutnya, jika memungkinkan saya akan mencoba membuat analisis lebih lanjut, misal seperti sentiment analysis, dan lain-lain. Selamat mencoba!