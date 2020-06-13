---
title: Introduction to Twitter Mining with R
date: '2016-06-11 16:20:01'
tags:
- r
- programming
- general
- text-mining
---

## Pengantar
### Twitter dan Twitter Apps
![Twitter Logo](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/twitter.svg)

**Twitter** adalah media sosial berbasis teks dengan maksimal huruf sebanyak 140 dalam satu tulisan (disebut *tweet*). Twitter kerapkali digunakan sebagai sumber data untuk diolah karena akuisisi data tidak terlalu kompleks jika dibandingkan media sosial lain.

![Akun twitter saya, @rizki_doank94](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/intro_twitter_mining_01.jpg)
Untuk mengambil data pada twitter, kita dapat memanfaatkan <a href="https://apps.twitter.com" target="_blank">**Twitter Application**</a>. Ikuti langkah berikut:

1. Buka [**Twitter Apps**](https://apps.twitter.com).
2. Buat app baru dengan klik *create new app*.
3. Isi detail app, lanjutkan.
4. App baru akan dibuat, contohnya adalah gambar berikut.

![Twitter Apps](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/intro_twitter_mining_02.jpg)

## Outline Tutorial
Pada tulisan ini, saya akan mencoba untuk melakukan analisis data dengan dataset yang diperoleh dari twitter menggunakan R. Sebelumnya, berikut adalah kakas yang saya gunakan :

* [RStudio](https://rizkidoank.com/2016/06/11/rstudio-ide-untuk-r/)
* Twitter API
* Paket-paket R
 * *twitteR, tm*

Secara utuh, seri tutorial ini akan melakukan **Analisis Tweet**, termasuk pada mengambil data (tweet), *cleaning data*, *term frequency, wordcloud, sentiment analysis*.

*Nah*, itu adalah sepintas yang berkaitan dengan tutorial untuk **Tweet Mining dengan R**. Selamat membaca!

## Tautan Tutorial
* Bagian 1 : [Twitter Mining with R : Tweet Analysis, Bagian 1](https://rizkidoank.com/2016/06/11/twitter-mining-with-r-tweet-analysis-bagian-1/)
* Bagian 2 : [Twitter Mining with R : Tweet Analysis, Bagian 2](https://rizkidoank.com/2016/06/12/twitter-mining-with-r-tweet-analysis-bagian-2/)
* Bagian 3 : [Twitter Mining with R : Tweet Analysis, Bagian 3](https://rizkidoank.com/2016/06/13/twitter-mining-with-r-tweet-analysis-bagian-3/)
* Bagian 4 : Sentiment Analysis, not yet implemented