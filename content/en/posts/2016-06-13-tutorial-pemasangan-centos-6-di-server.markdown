---

title: Tutorial Pemasangan CentOS 6 di Server
date: '2016-06-13 04:54:09'
tags:
- sysadmin
- server
- indonesian
---

CentOS adalah distribusi linux berbasis Red Hat Enterprise Linux (RHEL). CentOS dikelola oleh komunitas dan dapat diunduh secara gratis dari situs resminya. Manajemen paket yang digunakan adalah RPM, sama halnya dengan RHEL. CentOS umum digunakan untuk server. Pada post ini, saya akan berbagi mengenai Tutorial Instalasi CentOS 6. Dalam hal ini, akan digunakan CentOS 6.7 Minimal yang dapat diunduh di situs CentOS.


Tutorial menggunakan mesin virtual KVM dengan spesifikasi satu core CPU, memori 1GB, satu NIC, HDD 15GB. Perlu diketahui, alokasi memori dibawah 1GB hanya dapat menggunakan pemasangan berbasis teks. Dalam tutorial ini, saya akan menggunakan Logical Volume Manager (LVM) untuk partisi harddisk.

## Instalasi CentOS
### Boot CD Installer

Masuk ke installer melalui image yang telah diunduh.

![Bootloader Installer](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-01.jpg)
Pilih skip pada pengecekan media instalasi. Selanjutnya, anda akan diarahkan ke laman utama instalasi.

![Check integritas data installer](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-02.jpg)
![Laman utama instalasi](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-03.jpg)

### Pemilihan Bahasa, Hostname, Zona Waktu, dan Password Root

Langkah selanjutnya, lanjutkan dan pilih bahasa yang ingin digunakan

![Pemilihan bahasa](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-04.jpg)

Lanjutkan dengan memilih Basic Storage Devices.

![Laman utama partisi](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-05.jpg)
Jika muncul peringatan, pilih Yes. Perlu diingat bahwa data pada harddisk terkait akan terhapus.

![Penghapusan tabel partisi](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-06.jpg)
Diikuti dengan pemberian nama host, menentukan zona waktu, dan kata sandi root.

![Pemberian nama host](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-07.jpg)
![Pemilihan zona waktu](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-08.jpg)
![Membuat kata sandi root](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-09.jpg)
### Partisi Harddisk

Pada tahap partisi, diasumsikan menggunakan LVM. Langkah yang ditempuh adalah sebagai berikut :

Pilih layout custom


![Laman layout partisi](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-10.jpg)
Buat partisi standar untuk mount point /boot dengan tipe filesystem ext2. Boot digunakan untuk menyimpan kernel dan bootloader yang akan digunakan untuk booting ke sistem.


![Membuat partisi standar](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-11.jpg)
 

![Membuat partisi boot](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-12.jpg)
Selanjutnya, buat LVM dengan ukuran Physical Volume adalah sisa dari ruang harddisk yang tersedia.

![Membuat LVM](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-13.jpg)

![Membuat PV](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-14.jpg)
Membuat PV dengan ukuran maksimal
Buatlah Volume Group untuk membuat Logical Volume swap dan root.


![Membuat VG](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-15.jpg)
Buatlah Logical Volume untuk swap dengan ukuran tertentu, dalam tutorial ini yaitu 1 GB.

![Membuat swap pada LVM](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-16.jpg)
Selanjutnya, buat Logical Volume untuk root dengan ukuran penuh.

![Membuat root pada LVM](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-17.jpg)

Konfirmasi penulisan tabel partisi dengan memilih format jika diminta.


![Konfirmasi penulisan tabel partisi](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-18.jpg)
### Pemasangan Bootloader

Selanjutnya, pilih saja next. Pada tutorial ini, bootloader dipasang di Master Boot Record.


![Pemasangan Bootloader](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-19.jpg)
### Instalasi Selesai

Instalasi telah selesai, pilih reboot. Selanjutnya anda akan disuguhkan dengan laman masuk ke sistem.


![Instalasi selesai](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-20.jpg)

![Laman utama pasca instalasi](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/06/centos-21.jpg)
 
Tutorial pemasangan CentOS telah selesai. Selamat mencoba!