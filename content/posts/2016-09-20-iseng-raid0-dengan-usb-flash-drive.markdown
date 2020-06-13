---

title: Iseng, RAID0 dengan USB Flash Drive
date: '2016-09-20 08:49:09'
tags:
- sysadmin
- server
- filesystem
---

RAID adalah teknik *striping, mirroring, atau paritas* untuk membentuk penyimpanan yang handal dengan memanfaatkan beberapa disk. Terdapat beberapa jenis level pada RAID, di tulisan selanjutnya mungkin saya bisa memaparkan beberapa :D.

*Nah*, Biasanya RAID diimplementasikan dengan disk seperti HDD ataupun SSD. Sekarang, saya ingin mencoba membuat RAID dengan dua buah Flash Drive dengan RAID0.

### Barang dan Bahan
Barang yang dibutuhkan yaitu dua buah Flash Drive. Berikut Flash Drive yang saya gunakan, masing-masing DISK1 dan DISK2.
![Flash Drive percobaan](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_01.jpg)

Bahan yang dibutuhkan yaitu OS Linux, mdadm, fdisk, iozone Benchmark. Untuk bagian ini, sudah saya pasang di komputer saya.

### Initial Test DISK1 & DISK2
Langkah pertama yang saya lakukan yaitu benchmarking DISK1 dan DISK2.

1. Kosongkan disk dan buat partition table baru.
2. Buat partisi baru dengan filesystem EXT4.
3. Mount partisi.
4. Lakukan testing dengan perintah

        iozone -s 1G -f /mnt/sdb1/TEST
        iozone -s 1G -f /mnt/sdc1/TEST

Pada pengujian yang saya lakukan, hasilnya seperti berikut.

![DISK1](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_02.png)
![DISK2](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_03.png)

### Pembuatan RAID0 dengan Flash Drive
Setelah pengujian dilakukan untuk kedua Flash Drive, sekarang saya membuat RAID0 dari kedua Flash Drive tadi.

1. Buat ulang partition table, lalu buat partisi baru dengan tipe `fd (Linux RAID)`.

 ![fdisk drive](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_04.png)
2. Cek disk dengan mdadm,

        mdadm --examine /dev/sdb1 /dev/sdc1`
 ![mdadm examine](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_05.png)
3. Buat RAID0,

        mdadm --create /dev/md0 --level=stripe --raid-devices=2 /dev/sd[b-c]1

 ![mdadm create](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_06.png)
4. Saya bisa cek RAID yang baru saja dibuat dengan perintah

        cat /proc/mdstat
        mdadm --detail /dev/md0
 ![mdstat](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_07.png)
 ![mdadm detail](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_08.png)
5. Lalu, mount dan selanjutnya saya benchmark dengan iozone.

        iozone -s 1G -f /mnt/md0/TEST

Berikut adalah hasil benchmark RAID0 Flash Drive dengan iozone.
![RAID0 iozone](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_09.png)

Dan jika dibandingkan dengan hasil benchmark sebelumnya, dihasilkan data seperti berikut untuk size file 1GB. Masing-masing terurut dari DISK1, DISK2, dan DISKRAID.
![Results](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/raid0_disk_10.png)

Sekian iseng-iseng hari ini, intinya pembuatan RAID0 berhasil dengan hasil yang tidak begitu signifikan. Hal ini bisa saja dikarenakan jumlah disk yang kurang banyak sehingga tidak begitu terlihat perbedaannya, atau karena keterbatasan dari USB Bus. Selamat mencoba :D