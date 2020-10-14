---

title: Setup Node.JS dan MongoDB di Linux
date: '2016-09-20 03:25:53'
tags:
- programming
- linux
- nodejs
- database
- indonesian
---

Node.JS dan MongoDB adalah perangkat lunak populer saat ini. Platform Node.JS dan Database MongoDB banyak digunakan untuk membuat aplikasi real-time. Pada kesempatan ini saya akan melakukan setup dan konfigurasi Node.JS dan MongoDB di Linux.

![NodeJS](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/setup_nodejs_mongodb_01.png)
## Setup Node.JS
Beberapa distribusi Linux sudah terdapat paket Node.JS di repositorinya. Tetapi, kali ini saya akan memasangnya dengan Node Version Manager (NVM) oleh [creationix](https://github.com/creationix/nvm). Karena, NVM memungkinkan user menggunakan beberapa versi node.js dan lebih baik dalam manajemen paket (tidak mengganggu sistem, pemasangan paket global tidak perlu akses root).

1. Buka Terminal
2. Jalankan perintah berikut di Terminal.

        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
3. Selanjutnya NVM akan terpasang di user environment melalui `~/.bashrc`.
4. Buka kembali Terminal baru atau logout dulu dari session. Pasang Node.JS dengan perintah `nvm install stable` untuk versi `stable`.
5. Gunakan node.js yang terpasang dengan perintah `nvm use stable`. Sekarang, node.js versi stable telah terpasang dan dapat digunakan.
6. Gunakan `node -v` untuk memastikan node.js sudah terpasang.

![](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/setup_nodejs_mongodb_02.png)
## Setup MongoDB
Beberapa distribusi Linux sudah tersedia paket MongoDB. Berikut adalah cara memasang MongoDB di CentOS 6.

### MongoDB di CentOS
1. Buka Terminal
2. Jalankan `nano /etc/yum/repos.d/mongodb.repo`.
3. Isi berkas repo sebagai berikut :

        [mongodb-org-3.2]
        name=MongoDB Repository
        baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
        gpgcheck=1
        enabled=1
        gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
4. Pasang MongoDB dengan perintah `sudo yum install -y mongodb-org`.
5. MongoDB telah terpasang, jalankan MongoDB dengan perintah `sudo service mongod start` untuk CentOS 6.
6. Untuk akses shell MongoDB, gunakan perintah `mongo`.

### MongoDB Navigator
Untuk melakukan manajemen data di MongoDB bisa menggunakan shell bawaannya. Selain itu, ada beberapa pilihan lain yang cukup bagus dan membantu. Beberapa contohnya yaitu `robomongo` dan `DBeaver Enterprise Edition`.

Sekian tutorial kali ini. Semoga bermanfaat.