---
layout: post
title: Akses File di Platform Blog Ghost
date: '2016-06-15 22:59:25'
tags:
- general
- sysadmin
- server
- nginx
- linux
---

Setelah saya menggunakan Ghost untuk blog ini, rasanya cukup nyaman. Ghost jauh lebih ringan dan sederhana dibandingkan blogging platform yang pernah saya pakai sebelumnya. Hanya saja, terdapat kendala saat ingin mengunggah berkas selain gambar di Ghost.

Unggah berkas seringkali digunakan pada beberapa posting, misal seperti pada posting [Twitter Mining with R : Tweet Analysis, Bagian 2](https://rizkidoank.com/2016/06/12/twitter-mining-with-r-tweet-analysis-bagian-2/), disitu saya ingin melampirkan berkas berupa dataset dan berkas stopword Indonesia. Saya sempat bingung untuk mengunggah ke server.

Namun, setelah dipikirkan akhirnya bisa juga. Saya manfaatkan NGINX pada kontainer saya untuk menampilkan berkas yang diunggah ke server. Berikut caranya :

1. `docker exec -it nginx-stable-alpine /bin/sh`
2. `vi /etc/nginx/conf.d/default.conf`
3. Tambahkan blok berikut.

        location /static/ {  
            alias /usr/share/nginx/html/static/;
        }
4. Simpan, dan keluar dari kontainer, lalu restart `docker restart nginx-stable-alpine`.
5. Karena data volume `/usr/share/nginx/html/` terdapat pada `/var/www/html` di server, maka yang diperlukan adalah unggah berkas yang dibutuhkan ke `/var/www/html/static`
6. Akses berkas dengan cara telusuri `http(s)://namadomain/static/namaberkas`. Contoh : https://rizkidoank.com/static/stopwords.txt

*Nah*, sekarang saya dapat melampirkan berkas dengan sematkan tautan berkas di Ghost. Selamat mencoba! 