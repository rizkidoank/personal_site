---
layout: post
title: Remote Desktop Real Display dengan VNC
date: '2016-10-14 06:03:16'
tags:
- sysadmin
- server
- linux
- networking
- service
---

Beberapa minggu lalu sempat ramai berita tentang videotron di Jakarta Selatan yang di "retas" oleh seseorang. Berdasarkan dari berita-berita terakhir, pelaku melakukan aksinya dikarenakan tahu akses ke videotron tersebut karena saat ia melintas, *username* dan *password* terlihat di videotron tersebut.

Sebenarnya, kejadian tersebut cukup menggelitik bagi saya. *Nah*, pada tulisan ini saya akan berbagi salah satu solusi yang mungkin bisa diterapkan pada videotron tersebut tanpa khawatir akses terlihat.

**VNC (Virtual Network Computing)** adalah sistem *desktop sharing* yang memanfaatkan protokol *Remote Frame Buffer*. VNC terdapat klien dan server, pada server umumnya VNC akan membuat *virtual X11 server* yang kemudian dapat diakses dengan menggunakan klien VNC untuk mengakses *virtual desktop* tersebut.

Bagaimana jika saya ingin mengakses *desktop* tetapi di *real / physical display*? ***x11vnc*** dapat menjadi solusinya. Berikut langkah pemasangan `x11vnc` dan penggunaannya.

### Pemasangan `x11vnc` Server
Pada sisi server,saya menggunakan Arch Linux dengan Desktop Environment MATE. Untuk memulai pemasangan, buka `mate-terminal` lalu unduh dan pasang `x11vnc`.

    sudo pacman -Syy x11vnc

Kemudian, jalankan server `x11vnc` dengan perintah

    x11vnc -storepasswd
    x11vnc -usepw
    x11vnc -display :0
    
    ![Konfigurasi password x11vnc](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/x11vnc_01.jpeg)

Pada perintah diatas,`:0` adalah display yang akan digunakan, silakan sesuaikan kebutuhan. Biasanya saat di jalankan, server X11 VNC akan menggunakan port `5900`,untuk opsi lain silakan lihat di `x11vnc --help`.

![contoh x11vnc server saat dijalankan](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/x11vnc_02.jpeg)

### Pengujian X11 VNC
Pemasangan selesai, sekarang saya akan akses server melalui host lain. Untuk akses VNC saya menggunakan *vinagre*, silakan gunakan klien VNC lain sesuai kebutuhan.

![informasi about vinagre](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/x11vnc_03.jpeg)

Pada `vinagre`, buat profil koneksi baru dengan tipe VNC, lalu masukkan IP dan port yang digunakan. Jika pemasangan sudah benar, maka server sudah dapat diakses.

![mencoba x11vnc](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/x11vnc_04.jpeg)

Selesai! Sekarang tidak perlu khawatir lagi *username* dan *password* tampil di videotron. Karena `x11vnc` tidak menampilkan *window* dengan informasi akun, hanya berjalan sebagai *services*.