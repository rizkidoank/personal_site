---
layout: post
title: Deploy Ghost Blog di CPanel
date: '2016-10-24 08:50:49'
tags:
- sysadmin
- server
- nodejs
- web
- service
---

Ghost adalah blogging platform berbasis nodejs. Blog [rizkidoank.com](https://rizkidoank.com) menggunakan Ghost, dan jujur saja saya sangat menikmati blogging dengan platform ini.

Biasanya Ghost dipasang di VPS atau PaaS seperti Heroku misalnya. Di Indonesia, harga sewa VPS masih cukup tinggi, selain itu performa yang diberikan juga masih lebih lambat dari VPS di provider luar. Oleh karena itu, masih banyak yang memanfaatkan hosting dikarenakan harga yang lebih terjangkau dan pengguna tidak perlu pusing dalam konfigurasi server.

Pada tulisan ini saya akan berbagi cara memasang Ghost Blog di shared hosting dengan CPanel. Berikut adalah langkah pemasangan Ghost di hosting berbasis CPanel.

#### Pemasangan Ghost di CPanel-based Hosting
1. Pastikan hosting mendukung akses SSH
2. Lakukan pemasangan nodejs, untuk referensi silakan baca [Setup Node.JS](https://rizkidoank.com/2016/09/20/setup-node-js-dan-mongodb-di-linux/)
3. Unduh paket Ghost melalui situs resminya

        wget https://ghost.org/zip/ghost-0.11.2.zip
 ![Unduh ghost](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/ghost_cpanel_01.jpeg)
4. Ekstrak dan hapus paket / arsip yang tadi di unduh.

        unzip ghost-0.11.2.zip
        rm ghost-0.11.2.zip
5. Lakukan pemasangan dependensi dengan perintah
        
        cd <ghost_path>
        npm install --production
 ![Ghost installation](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/ghost_cpanel_02.jpeg)

6. Lakukan konfigurasi pada `config.js` sesuai kebutuhan. Pada kondisi default, ghost menggunakan sqlite.
7. Pasang modul `forever` pada nodejs untuk process management node.

        npm install forever
8. Jalankan Ghost dengan perintah berikut di path ghost.

        NODE_ENV=production node_modules/forever/bin/forever start index.js
 Perintah diatas akan menjalankan ghost dengan `forever` pada mode production. Untuk melihat proses yang berjalan di akun,gunakan perintah `forever list`.

 ![Forever processes](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/ghost_cpanel_03.jpeg)
9. Selanjutnya, akses situs yang telah dikonfigurasikan, misal : ~~http://bitlyze.net~~ https://rizkidoank.com
 ![Ghost Home](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/ghost_cpanel_04.jpeg)


NOTE:

- Hosting harus ada phusion passenger untuk dapat menggunakan fitur ini.
- Situs ini juga menggunakan shared hosting, sejauh ini performanya sangat baik.
- Ini hanya salah satu contoh penggunaan nodejs di shared hosting, sangat memungkinkan untuk menjalankan layanan lain misal API services dan lain-lain.