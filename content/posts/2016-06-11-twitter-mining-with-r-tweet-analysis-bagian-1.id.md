---
title: 'Twitter Mining with R : Tweet Analysis, Bagian 1'
date: '2016-06-11 17:41:08'
tags:
- r
- programming
- text-mining
- indonesian
---

## Pengantar
Pada tulisan sebelumnya, [**Introduction to Twitter Mining with R**](https://rizkidoank.com/2016/06/11/introduction-to-twitter-mining-with-r/) telah dipaparkan pengantar tentang Text Mining pada Twitter dengan R. Pada tulisan ini akan dibahas tentang **Tweet Analysis**. Secara utuh, yang akan saya lakukan adalah :

* Mengambil data tweet dengan R menggunakan paket *twitteR*.
* *Text cleaning* dengan paket *tm* pada R.
* Menampilkan *Terms Frequency*
* Membuat wordcloud berdasar term yang didapat.

## Mengambil Data Tweets
Sebelumnya, pastikan telah membuat Twitter App seperti pada tulisan [sebelumnya](https://rizkidoank.com/2016/06/11/introduction-to-twitter-mining-with-r/). Kemudian, pada tulisan ini saya menggunakan RStudio.

    # Load library
    library(twitteR)

    # Inisialisasi variabel twitter api
    cons_key <- '<consumer_key>'
    cons_sec <- '<consumer_secret>'
    acc_token <- '<access_token>'
    acc_sec <- '<access_secret>'

    # Atur otentikasi twitter api
    setup_twitter_oauth(
      consumer_key = cons_key,
      consumer_secret = cons_sec,
      access_token = acc_token,
      access_secret = acc_sec
    )
    # Load tweet dari user @infocianjur
    # sebanyak 2000 data, termasuk RT dan reply
    tweets_data <- userTimeline(
        "infocianjur",
        n=2000,
        includeRts=TRUE,
        excludeReplies=FALSE
    )
    # Konversi ke dataframe
    tweets_data.df <- twListToDF(tweets_data)

Setelah dijalankan, maka pada tab environment akan tampil variabel *tweets_data*.
![Data Tweets](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_01_01.jpg)
Sementara itu, pada *tweets_data.df* akan terlihat variabel yang ada dalam dataframe *tweets_data*. Untuk menampilkan salah satu tweet (misal tweet ke 100 teratas), dapat jalankan perintah `writeLines(tweets_data.df$text[100])`

![Contoh tweet ke 100](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter_mining_part_01_02.jpg)

Data untuk analisis telah didapatkan, pada langkah selanjutnya yaitu *Text Cleaning* terhadap data yang telah kita dapatkan.

**Catatan :** perlu dicatat jika mengacu pada [dokumentasi twitter](https://dev.twitter.com/rest/public/search), dikatakan :
> The Twitter Search API searches against a sampling of recent Tweets published in the past 7 days.

Sehingga, data yang dapat diambil terbatas pada data 7 hari kebelakang jika menggunakan Twitter API. Sehingga, untuk mendapat hasil yang baik ambil data dari pengguna yang sering tweet seperti akun berita, informasi, orang bawel, dan sejenisnya.