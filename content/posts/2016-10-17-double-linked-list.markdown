---

title: Double Linked List
date: '2016-10-17 08:52:18'
tags:
- programming
- computer-science
- algorithm
- cpp
---

### Pengenalan Double Linked List
Pengertian **Double Linked List** adalah sekumpulan node data yang terurut linear atau sekuensial dengan dua buah *pointer* yaitu **prev** dan **next**.
![Node pada Double Linked List](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_01.jpeg)

Double Linked List adalah linked list dengan node yang memiliki data dan dua buah reference link (biasanya disebut next dan prev) yang menunjuk ke node sebelum dan node sesudahnya. Pada implementasinya, terdapat dua variasi double linked list yaitu circular dan non-circular layaknya pada single linked list.

![Double linked list](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_02.jpeg)

Gambar diatas adalah salah satu contoh double linked list dengan dua buah pointer pembantu yaitu *head* dan *tail*.

### Operasi pada Double Linked List
Double linked list memiliki beberapa operasi dasar pada list, misalkan penyisipan, penghapusan, menampilkan maju, dan menampilkan mundur.

#### Insert First
![Insert First](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_03.jpeg)
Penyisipan di awal list, sehingga *pointer* head juga akan berpindah ke elemen baru.

#### Insert Last
![Insert Last](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_04.jpeg)
Penyisipan di akhir list, sehingga *pointer* tail juga akan berpindah ke elemen baru.

#### Insert After / Before
![Insert After / Before](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_05.jpeg)
Penyisipan *after/before* kurang lebih sama satu sama lain. Pada kasus diatas berlaku juga insert before 3.

#### Delete First
![Delete First](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_06.jpeg)
Penghapusan di awal list, *pointer* head akan berpindah ke node selanjutnya,sementara node awal akan di dealokasi.
#### Delete Last
![Delete Last](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_07.jpeg)
Penghapusan di akhir list, *pointer* tail akan berpindah ke node sebelumnya,sementara node akhir akan di dealokasi.
#### Delete Node
![Delete Node](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/double_linked_08.jpeg)
Penghapusan node dengan data tertentu, pada kasus diatas yaitu delete node 2.

### Implementasi Double Linked List dengan C++
Berikut adalah implementasi Double Linked List dengan C++.
#### Abstract Data Type
ADT adalah *header* dan informasi struktur data dari elemen yang akan digunakan, dalam kasus ini yaitu Node.
<script src="https://gist.github.com/rizkidoank/ea52c9a0f7c579d75e6c226c7f38e1e3.js"></script>
#### Implementasi Method dan Fungsi
Setelah *header* didefinisikan, terdapat implementasi double linked list dengan C++.
<script src="https://gist.github.com/rizkidoank/eaaf9d06ff6a4e9ecab25f7929699a3b.js"></script>
#### Contoh Program Utama
Berikut adalah contoh program utama untuk pengujian dan validasi implementasi double linked list. Program ini dapat dimodifikasi sesuai keinginan, kode yang saya tulis hanyalah contoh saja.
<script src="https://gist.github.com/rizkidoank/5f4645bf56cf638b59354e9bb50a5ab1.js"></script>

### Penutup
Implementasi dan kilasan teori terkait double linked list telah selesai. Sebenarnya ada method lain misal seperti delete after atau delete before, hanya saja dalam kasus ini diasumsikan telah diwakili fungsi delete element. Jika ingin memodifikasi atau mengembangkan dan mempelajari, silakan *fork* melalui repositori saya di [Double Linked List rizkidoank](https://github.com/rizkidoank/double_linked_list). Semoga bermanfaat dan sampai berjumpa kembali :D