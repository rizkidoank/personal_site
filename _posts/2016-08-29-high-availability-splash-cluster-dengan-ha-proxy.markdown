---
layout: post
title: High Availability Splash Cluster dengan HA-Proxy
date: '2016-08-29 09:19:15'
tags:
- sysadmin
- web-scraping
- containerization
---

Pada tulisan sebelumnya di [Integrasi Splash dengan Scrapy](https://rizkidoank.com/2016/08/18/integrasi-splash-dengan-scrapy/), saya mencoba untuk integrasi Splash dengan Scrapy. Awalnya saya menggunakan satu kontainer Splash untuk *crawling*, tetapi ternyata terkendala saat menggunakan *concurrent requests* yang sedikit tinggi dan juga situs dengan *script* yang lumayan berat. Berikut dua isu utama yang sering saya temui saat *crawling*

* *504 Gateway Timeout* - umumnya error ini disebabkan oleh *timeout* saat *fetching* karena faktor tertentu, misal : *script* yang berat.
* *Connection refused* - ini kondisi paling buruk. Pada kasus saya dahulu, *connection refused* disebabkan oleh kontainer Splash yang mati / ter-*kill*. Di kondisi ini saya harus menyalakan ulang kontainer, dan menjalankan ulang *crawler*.

Dari kedua isu diatas, saya mencari solusi untuk menanganinya. Dan, setidaknya saya menemukan solusi yang sampai saat ini saya kira solusi terbaik (dua poin diatas tidak saya temui lagi). Berikut langkah yang saya lakukan.

1. Saya menggunakan Docker untuk konfigurasi ini. Langkah utama yang dilakukan yaitu membuat kontainer HA-Proxy dan *multiple* Splash. Pada docker, terdapat `docker-compose` yang mempermudah dalam *deployment* aplikasi.
2. Buat fail dengan nama `docker-compose.yml` dengan editor teks anda, misal `vim`.
3. Buat konfigurasi Splash Cluster sebagai berikut pada fail `docker-compose.yml` untuk 2 node Splash.

        global
            maxconn 512
            stats socket /tmp/haproxy

        defaults
            log global
            mode http
            compression algo gzip
            compression type text/html text/plain application/json
            timeout connect 3600s
            timeout client 3600s
            timeout server 3600s
        # HAProxy stats
        listen stats
            bind *:8036
            mode http
            stats enable
            stats show-legends
            stats show-desc Splash Cluster
            stats uri /
            stats refresh 15s
            stats auth    admin:admin # otorisasi laman stats


        # Splash Cluster
        frontend http-in
            bind *:8050
            default_backend splash-cluster
            acl staticfiles path_beg /_harviewer/
            acl misc path / /info /_debug /debug

        backend splash-cluster
            option httpchk GET /
            balance leastconn
            retries 3
            option redispatch
            server node-0 node_01:8050 check maxconn 5 inter 2s fall 10 observe layer4
            server node-1 node_02:8050 check maxconn 5 inter 2s fall 10 observe layer4

4. Selanjutnya, di path letak `docker-compose.yml` yang ada, saya jalankan perintah `docker-compose up`. Splash nodes akan aktif beserta HAProxy dan cluster telah terbuat. Untuk berhentikan cluster, anda dapat gunakan `docker-compose stop` atau `docker-compose start` untuk menghidupkan.

5. Untuk melihat statistik HAProxy, dapat diakses melalui peramban di `<IP_ADDRESSS>:8036` dan masukkan user dan password.

Nah, langkah diatas adalah cara membuat Splash HA Cluster dengan Docker. Pada multi-host, anda dapat merubah konfigurasi pada HAProxy sesuai dengan IP node yang aktif.