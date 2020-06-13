---

title: MariaDB Load Balancing
date: '2016-10-13 03:40:00'
tags:
- sysadmin
- server
- networking
- service
---

MySQL atau MariaDB seringkali digunakan untuk DBMS relasional. Pada penggunaan pribadi atau skala kecil menengah, satu instance MySQL atau MariaDB sudah cukup untuk memenuhi kebutuhan. Namun, pada skala besar, seringkali ditemukan kendala seperti tidak mampu menangani rekues, eksekusi kueri yang lambat, dan lain-lain.

Dalam menanggapi permasalahan tersebut, terdapat beberapa solusi yang dapat diterapkan antara lain tuning di DBMS,tuning di level sistem operasi, scale-up,atau load balancing. Pada tulisan ini saya akan mencoba melakukan load balancing MariaDB.

### Requirements
Perangkat yang digunakan yaitu dua host MariaDB, dan satu host load-balancer, dalam kasus ini saya manfaatkan HA-Proxy. Konfigurasi saya lakukan pada mesin virtual dengan sistem operasi Alpine Linux.

### Pemasangan MariaDB
MariaDB server akan dipasang di dua host, sedangkan host load-balancer akan dipasangkan HA-Proxy dan MariaDB client. Berikut langkah pemasangannya untuk di server mariadb.

    apk update && apk add mariadb mariadb-client # di host mariadb
Sedangkan untuk di load-balancer sebagai berikut.

    apk update && apk add haproxy mariadb-client # di host load balancer

![](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/mariadb_load_01.jpeg)

Selanjutnya, lakukan konfigurasi pada DBMS dan jalankan DBMS. Masuk ke DBMS dan jalankan kueri berikut untuk pengecekan status server oleh haproxy.

    INSERT INTO mysql.user (Host,User) values ('<IP_HAPROXY>','balancer_check');
    GRANT ALL PRIVILEGES ON *.* TO 'balancer'@'<IP_HAPROXY>' IDENTIFIED BY 'password' WITH GRANT OPTION;
    FLUSH PRIVILEGES;"

### Konfigurasi HA-Proxy
Setelah konfigurasi DBMS, kini DBMS dapat diakses melalui host balancer. Langkah selanjutnya yaitu konfigurasi load balancer, saya ubah konfigurasi pada `/etc/haproxy/haproxy.cfg` menjadi seperti berikut :

    global
        log 127.0.0.1 local0 notice
        user haproxy
        group haproxy

    defaults
        log global
        retries 2
        timeout connect 1000
        timeout server 1000
        timeout client 1000

    listen maria-cluster
        bind 127.0.0.1:3306
        mode tcp
        option mysql-check user balancer_check
        balance roundrobin
        server n01 <IP_DB_HOST1>:3306 check
        server n02 <IP_DB_HOST2>:3306 check

Selanjutnya, restart haproxy dan konfigurasi selesai. Konfigurasi diatas tidak menyediakan laman status cluster, hanya menyediakan load balancing-nya saja. Jika ingin menambahkan laman status cluster, dapat ditambahkan konfigurasinya di `haproxy.cfg`.

### Pengujian Load Balancing
Setelah konfigurasi selesai, saya coba akses MariaDB dengan load-balancing di host haproxy.

    mysql -h 127.0.0.1 -u balancer -p

Jika konfigurasinya benar,maka akan muncul prompt input kueri. Pengujian selanjutnya yaitu dengan eksekusi kueri bersamaan (concurrent).

![](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/mariadb_load_02.jpeg)

Dari gambar diatas dapat disimpulkan load balancing sudah berfungsi dengan algoritma balancing roundrobin tanpa bobot. Selamat mencoba dan silakan informasikan jika ada yang kurang tepat. :D