---

title: Pengantar REST API
date: '2016-09-30 03:19:13'
tags:
- programming
- server
- web
- mobile
---

REST API banyak digunakan saat akan membuat aplikasi. Dengan REST API saya dapat membuat aplikasi yang multiplatform, karena saya tidak perlu implementasikan fungsi-fungsi CRUD (misalnya) pada tiap platform. Saya cukup menggunakan API yang disediakan untuk memanipulasi basis data yang digunakan aplikasi.

![diagram rest api](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/rest_01.png)
Gambar diatas merupakan diagram dari REST API. Biasanya pada REST API memanfaatkan HTTP Request, misal seperti GET untuk ambil data, POST untuk masukkan data, PUT untuk pembaharuan data, DELETE untuk hapus data. Tiap aksi tersebut akan berupa suatu request yang kemudian akan dibalas berupa response. Response yang dikirimkan umumnya saat ini menggunakan JSON.

Saat ini, beberapa platform diperlukan adanya REST API, misal pada mobile apps di Android. Untuk manipulasi basis data eksternal diperlukan adanya API. Lalu, ada juga web apps. Meskipun bisa tanpa API, tetapi saat ini cenderung banyak digunakan, karena lebih mudah diimplementasikan dan tidak tergantung pada bahasa yang digunakan.


**NOTE : kalau ada yang kurang tepat, mohon dikoreksi**

Pada tulisan selanjutnya saya akan mencoba membuat Hashed Password untuk User Model pada REST API dengan NodeJS dan MongoDB.