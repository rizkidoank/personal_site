---
layout: post
title: Memasang Oracle JDK di Linux
date: '2016-10-10 08:03:58'
tags:
- programming
- sysadmin
- linux
---

Oracle JDK (*Java Development Kit*) adalah *development kit* Java yang disediakan oleh Oracle. Oracle JDK banyak digunakan untuk proyek berbasis Java di skala enterprise, Oracle JDK juga menyediakan *library* yang hanya tersedia dibawah distribusi paket ini.

Pada distribusi Linux, JDK yang disediakan pada repositori adalah OpenJDK. Pada beberapa kondisi, OpenJDK tidak dapat digunakan oleh aplikasi tertentu. Pada tulisan ini saya akan berbagi cara memasang Oracle JDK di sistem operasi Linux dengan sampel distribusi yaitu Ubuntu.

### Langkah Pemasangan Oracle JDK
#### Unduh Paket Oracle JDK
Untuk dapat mengunduh Oracle JDK, saya mengunduh melalui situs resminya di Oracle.
![situs resmi Oracle JDK](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/jdk_01.jpeg)
Jika menggunakan Desktop cukup unduh menggunakan peramban yang dimiliki. Pastikan memilih paket yang sesuai, dalam kasus ini saya menggunakan **Ubuntu 64 Bit**, sehingga saya unduh paket **Linux x64 Tarball (tar.gz)**.

Jika menggunakan server yang umumnya bersifat *headless*, paket dapat diunduh melalui *mirror* di situs lain, atau unduh melalui situs resmi dengan *downloader*, misal: *wget*. Perlu diperhatikan, Oracle JDK hanya dapat diunduh jika pengguna menerima *license agreement*.

    wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz

#### Ekstrak dan Pasang JDK
Setelah unduhan selesai, selanjutnya yaitu ekstrak dan pemasangan JDK. Berikut perintah yang digunakan untuk ekstrak dan pemasangan.

    tar xf jdk-8u101-linux-x64.tar.gz
    sudo mv -Rf jdk1.8.0_102 /opt/jdk
    
Jika berhasil, Oracle JDK akan terpasang di **/opt/jdk**.
#### Konfigurasi Oracle JDK
Pemasangan telah berhasil, langkah selanjutnya yaitu konfigurasi. Jika menggunakan CentOS, cukup melakukan pemasangan paket \*.rpm dan selesai. Namun,jika menggunakan distribusi lain, misal Ubuntu, saya perlu konfigurasi agar Oracle JDK dapat digunakan sebagai *default*.
  
    update-alternatives --install /usr/bin/java java /opt/jdk/bin/java 100
    update-alternatives --install /usr/bin/java javac /opt/jdk/bin/javac 100

Selanjutnya set *JDK_HOME* ke *path* JDK yang telah terpasang.

    echo export JDK_HOME=/opt/jdk >> ~/.bashrc
Konfigurasi telah selesai, jika berhasil Oracle JDK dapat digunakan,silakan cek dengan `java -version`. Jika memerlukan program lain, misal `jps` anda dapat tambahkan dengan `update-alternatives` atau tambahkan path `JDK_HOME/bin` ke variabel `PATH` melalui `bashrc`.

Pemasangan Oracle JDK ini juga dapat diimplementasikan di distribusi lain. Selamat mencoba dan semoga bermanfaat.