---

title: Rendering Javascript dengan Splash
date: '2016-06-16 21:18:30'
tags:
- general
- web-scraping
- containerization
---

## Pengantar Splash
Saat ini banyak cara untuk akuisisi data, salah satu yang sedang populer dikembangkan adalah *web crawling*. Namun, permasalahannya terkendala saat menghadapi situs web dinamis yang menggunakan javascript. 'Browser' yang digunakan umumnya tidak mendukung javascript.

[**Splash**](https://github.com/scrapinghub/splash/) merupakan salah satu solusi untuk menghadapi situs web dinamis. Splash adalah layanan yang digunakan sebagi rendering javascript. Layanan ini dikembangkan oleh [*scrapinghub*](http://scrapinghub.com/) dan mendukung HTTP API untuk interaksi.

## Pemasangan Splash
Jika mengacu pada situs [dokumentasi splash](http://splash.readthedocs.io/en/stable/), terdapat opsi untuk pemasangan Splash dengan [Docker](https://www.docker.com/). Berikut langkah yang saya lakukan untuk memasang Splash :

1. Pastikan Docker terpasang dan layanannya aktif.
2. Selanjutnya, unduh image Splash dengan perintah     
    `docker pull scrapinghub/splash`.
3. Buat dan jalankan kontainer dengan perintah

        docker run -d-p 5023:5023 -p 8050:8050 -p 8051:8051 scrapinghub/splash
    Jika dijalankan `docker ps`, akan tampil *container* baru dengan *image* splash
4. Splash aktif pada port yang di-*expose* yaitu 5023, 8050, dan 8051.

## Splash HTTP API
Setelah aktif, kita dapat akses Splash Web GUI dengan akses `IP_Host:8050` pada browser.

Di laman tersebut ada contoh skrip untuk splash, misal untuk render HTML, PNG, dan HAR. Jika saya masukkan URL pada kotak yang disediakan lalu klik *Render me!*, maka Splash akan melakukan rendering dan menampilkan laman hasil render.

Selain melalui laman web, eksekusi API dapat dilakukan melalui terminal misal disini saya eksekusi perintah :
    
    curl 'http://ec2-54-191-117-175.us-west-2.compute.amazonaws.com:8050/render.json?url=https://www.tokopedia.com/anekalaser/apple-macbook-pro-with-retina-display-mjlt2ida-office&timeout=10&wait=0.5&html=1&png=1'

Maka akan tampil hasil berupa json pada terminal, untuk melihat hasil sebenarnya, silakan eksekusi pada terminal atau akses url tersebut pada browser (VPS mungkin saja mati sewaktu-waktu).

Sementara itu, Splash juga dapat diintegrasikan dengan [Scrapy](http://scrapy.org/) sebagai fetcher. Sekian pengantar Splash dari saya, kedepannya akan dicoba untuk integrasi ke Scrapy. Selamat mencoba!

## Referensi
* Scrapinghub Splash, online : http://scrapinghub.com/splash/
* Splash Documentation, online : http://splash.readthedocs.org/
* Splash Github, online : https://github.com/scrapinghub/splash