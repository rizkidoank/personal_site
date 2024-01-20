---
date: 2020-07-24T00:33:34+07:00
title: "Kenapa Saya Memilih Arch Linux untuk Workstation?"
tags:
- linux
- indonesian
---

Linux adalah salah satu sistem operasi yang banyak dikenal oleh pengguna komputer selain Microsoft Windows
dan Apple MacOS. Terlebih saat ini sudah tersedia banyak pilihan distribusi linux yang dikembangkan, bahkan
ada yang dikembangkan oleh perusahaan seperti Ubuntu oleh Canonical, Red Hat Enterprise Linux oleh Red Hat,
SUSE Linux Enterprise oleh SUSE. Lalu sebagai seorang pengembang aplikasi, distribusi apa yang saya pilih untuk
*workstation* saya? Arch Linux! Kenapa? Simak lebih lanjut.

## 1. Sangat Sederhana dan Dapat Disesuaikan
Paket media instalasi Arch Linux standar relatif minimal. Ketika masuk ke media instalasi, kita akan diberikan
*command-line interface*. Biasanya panduan instalasi dasar akan disediakan di direktori *home root*, namun
saya diberi kebebasan bagaimana dan seperti apa sistem akan dipasang. Sebagai contoh, saya bisa memilih untuk:

- Pasang dengan UEFI atau legacy boot
- Pasang dengan RAID, LVM, atau flat
- Pasang desktop environment, atau cukup CLI
- Memilih kakas pengaturan jaringan (systemd-network, NetworkManager, dll)
- dan masih banyak lagi

Dengan alasan tersebut lingkup pemasangan Arch Linux relatif lebih luas, dan dapat lebih optimal jika kita paham
lebih dalam.

## 2. Belajar Memahami Cara Kerja Linux
Instalasi Arch Linux standar memerlukan pemahaman beberapa konsep dan perintah yang ada pada sistem operasi Linux.
Misal, saya perlu paham bagaimana cara melakukan partisi dan jenis-jenis *filesystem*, memahami *bootloader*,
memahami manajemen jaringan, dan masih banyak lagi. Dapat saya akui, saya belajar sangat banyak tentang Linux saat
saya mengenal Arch Linux. Mungkin akan ada sangkalan lain kenapa tidak Slackware atau Gentoo? Menurut saya Arch Linux
ada di antara *end-user friendly* distro dan *geeks-oriented* distro. Saya bisa belajar banyak tentang Linux tanpa
harus pusing dengan kompleksitas dependensi antar paket, kompleksitas dan lamanya kompilasi kode sumber menjadi paket.

## 3. Dokumentasi yang Relatif Lengkap
Saya telah mengenal Arch Linux sejak awal saya kenal Linux. Namun, saya semakin penasaran karena setiap
saya melakukan pencarian tentang cara memasang atau melakukan sesuatu di Linux, beberapa rujukan mengarahkan pada
dokumentasi Arch Linux. Setelah itu, saya iseng membuka laman dokumentasi dan membaca tiap bagian, saya akui 
dokumentasi yang dibuat sangat membantu dan bisa menjadi referensi untuk belajar Linux. Bagaimana jika dibandingkan
dengan `man`? Perintah tersebut memang membantu dan lengkap, tetapi dokumentasi seperti Arch Linux lebih mudah
dipahami oleh saya dan juga tersedia beberapa studi kasus yang mungkin sangat mirip dengan kebutuhan saya.

## 4. Model Rolling Release dan Bleeding Edge
Terdapat beberapa model rilis yang biasa ditemukan pada distribusi Linux seperti periodical, long-term, rolling release.
Periodical misal rilis tiap enam bulan, atau tahunan. Long term release memberikan dukungan jangka panjang, misal hingga 
lima tahun. Sedangkan rolling release tidak terpaku pada versioning tertentu ataupun periode rilis tertentu. Dengan model
rolling release, saya dapat mendapatkan pambaharuan kernel atau paket dengan versi termutakhir. Ini sangat menarik,
terlebih Arch Linux menyediakan paket yang bleeding-edge, hampir selalu tersedia paket termutakhir. Jadi, saya selalu
up-to-date dengan fitur-fitur dan patch terbaru dari paket aplikasi yang terpasang.

## 5. Arch User Repository (AUR)
Selain paket yang ada pada repositori standar. Arch juga memiliki repositori yang dikembangkan oleh pengguna lain, repositori ini dikenal dengan AUR. Pada AUR saya perlu mengunduh PKGBUILD yang berisi deskripsi dan informasi paket, melakukan kompilasi dan pembuatan paket dengan `makepkg`, lalu melakukan instalasi dengan `pacman`. Proses tersebut juga dapat dipermudah dengan paket
untuk manajemen paket lanjutan seperti `yay`.

## 6. Dukungan Komunitas
Arch Linux memiliki dukungan komunitas yang cukup baik. Saya seringkali mendapatkan solusi beberapa permasalahan terkait Linux
di laman diskusi Arch Linux. Selain itu, lihat saja paket yang disediakan selalu up-to-date, dan juga repositori AUR yang
lumayan besar. Sehingga, saya tidak terlalu kesulitan atau khawatir saat menggunakan distro ini.

Nah, itu adalah beberapa alasan kenapa saya menggunakan Arch Linux untuk workstation saya. Berbeda dengan workstation, untuk
penggunaan server saya cenderung kondisional sesuai kebutuhan. Saya akan bahas tentang hal tersebut lain kali.