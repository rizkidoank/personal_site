---

title: Pengalaman Membuat E-Commerce Scraper dengan Scrapy
date: '2016-11-03 05:01:42'
tags:
- programming
- web-scraping
- service
---

Beberapa bulan ini saya mengembangkan proyek berupa dasbor untuk monitoring toko online dari beberapa e-commerce. Salah satu bagian penting yang ada di proyek ini yaitu crawler / scraper. Crawler digunakan untuk akuisisi data yang selanjutnya akan diolah menjadi data penjualan terintegrasi untuk pemilik toko.

Saat ini ada beberapa framework crawler yang banyak digunakan misal saja Apache Nutch yang memiliki keunggulan untuk dapat bekerja pada Hadoop Cluster (versi 2), dan Scrapy yang berbasis Python dan mendukung mode terdistribusi dengan frontera (HBase). Pada awal dijalankannya proyek ini, saya menggunakan Scrapy sebagai framework crawlernya. Kenapa Scrapy? Pertama saya mulai riset dari skala kecil, kedua Scrapy cukup mudah dalam pengaplikasiannya, ketiga dapat dilakukan scaling out tanpa merubah banyak kode.

![Scrapy Frontpage](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/scapy.PNG)
Scrapy adalah framework untuk ekstraksi data dari website. Scrapy dibangun dengan menggunakan Python. Pada Scrapy terdapat scheduler yang mengatur bagaimana crawling nanti berjalan, lalu ada Spider yang akan melakukan scraping ke laman situs tertentu, ada downloader yang mengunduh situs yang kemudian akan di parsing oleh spider, dan terakhir ada item pipeline yaitu jalur untuk penyimpanan item, yang saya gunakan yaitu json atau dikirimkan ke MongoDB.

Implementasi crawler dapat dilihat melalui repo saya di https://github.com/rizkidoank/shopwatch. Saat ini mendukung bukalapak dan tokopedia, masih akan dikembangkan lagi. Berikut contoh data yang diperoleh dengan crawler yang dibuat.
![Tokopedia Item](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/14522369_120300000387791878_287015246_o.png)
Sedangkan berikut adalah contoh tampilan saat ditampilkan di dasbor. Untuk dasbor saya gunakan Banana, sehingga data dari MongoDB perlu di pipeline ke Solr dahulu. Kedepannya akan menggunakan dasbor custom.
![Banana Dashboard](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/14488922_120300000346061494_118797559_o.png)
Dikarenakan kebanyakan situs telah dinamis menggunakan Javascript, downloader biasa saja rasanya tidak cukup. Ya, memang masih dapat memanfaatkan dan mencari AJAX request atau API nya. Tetapi, untuk berjaga-jaga dan tujuan pengembangan, saya menggunakan Splash yang dipasang secara terdistribusi. Splash digunakan saat tidak ada cara lain untuk mendapatkan atribut tertentu. Mungkin ada yang punya ide lain untuk crawling situs dinamis yang lebih cepat? Silakan bagikan jiga berkenan :D. Atau mungkin jika ada yang tertarik untuk mengembangkan bersama, mari.

Selanjutnya saya paparkan kesulitan yang ditemui saat melakukan pengembangan.

- Situs e-Commerce sebagian besar dinamis dengan Javascript, beberapa atribut perlu di-retrieve dengan load javascript terlebih dahulu. Dapat diatasi dengan Splash, hanya saja masih lebih lambat dibandingkan dengan HTTP request yang plain. Pada Tokopedia, saya dapat manfaatkan XHR request sehingga scraping bisa lebih cepat.
- Memilih atribut yang tepat, tiap situs memiliki atribut yang berbeda-beda. Kalau atribut umum seperti nama, harga, dan deskripsi rasanya tidak masalah. Namun, masalahnya saya ingin agar seluruh atribut penting dapat diambil agar dapat diolah nanti, pemilihan atribut ini perlu orang yang mengerti proses bisnisnya.
- Penentuan selektor perlu dilakukan lebih jeli, sebisa mungkin selektor tidak rumit, tetapi tepat memilih atribut yang diinginkan. Nah, bagian ini saya butuh waktu cukup lama karena seringkali saat test running, di laman tertentu selektor tersebut tidak ada. Haha.
- Kehandalan downloader, Splash saat ini saya rasa masih paling cocok. Namun,seringkali Splash dapat crash. Maka dari itu, saya melakukan clustering Splash dengan HAProxy.
- Politeness vs Velocity. Ini juga jadi salah satu dilemma, karena ketika Scrapy di konfigurasikan dengan concurrent request yang terlalu tinggi, diperlukan bandwidth yang lebih besar juga, sementara itu efek samping lain adalah IP kemungkinan dapat di blok karena dianggap melakukan flooding. Solusi untuk ini bisa menggunakan Rotating IP, saya manfaatkan Tor. Tetapi, dikarenakan jaringan Tor yang banyak hop, scraping menjadi lambat dan sangat mungkin terjadi request timeout.