---

title: Double Linked List
date: '2016-10-17 08:52:18'
tags:
- programming
- computer-science
- algorithm
- cpp
- indonesian
---

### Pengenalan Double Linked List
Pengertian **Double Linked List** adalah sekumpulan node data yang terurut linear atau sekuensial dengan dua buah *pointer* yaitu **prev** dan **next**.

Double Linked List adalah linked list dengan node yang memiliki data dan dua buah reference link (biasanya disebut next dan prev) yang menunjuk ke node sebelum dan node sesudahnya. Pada implementasinya, terdapat dua variasi double linked list yaitu circular dan non-circular layaknya pada single linked list.

### Operasi pada Double Linked List
Double linked list memiliki beberapa operasi dasar pada list, misalkan penyisipan, penghapusan, menampilkan maju, dan menampilkan mundur.

#### Insert First
Penyisipan di awal list, sehingga *pointer* head juga akan berpindah ke elemen baru.

#### Insert Last
Penyisipan di akhir list, sehingga *pointer* tail juga akan berpindah ke elemen baru.

#### Insert After / Before
Penyisipan *after/before* kurang lebih sama satu sama lain. Pada kasus diatas berlaku juga insert before 3.

#### Delete First
Penghapusan di awal list, *pointer* head akan berpindah ke node selanjutnya,sementara node awal akan di dealokasi.

#### Delete Last
Penghapusan di akhir list, *pointer* tail akan berpindah ke node sebelumnya,sementara node akhir akan di dealokasi.

#### Delete Node
Penghapusan node dengan data tertentu, pada kasus diatas yaitu delete node 2.

### Implementasi Double Linked List dengan C++
Berikut adalah implementasi Double Linked List dengan C++.
#### Abstract Data Type
ADT adalah *header* dan informasi struktur data dari elemen yang akan digunakan, dalam kasus ini yaitu Node.
{{< gist rizkidoank ea52c9a0f7c579d75e6c226c7f38e1e3 >}}
#### Implementasi Method dan Fungsi
Setelah *header* didefinisikan, terdapat implementasi double linked list dengan C++.
{{< gist rizkidoank eaaf9d06ff6a4e9ecab25f7929699a3b >}}

#### Contoh Program Utama
Berikut adalah contoh program utama untuk pengujian dan validasi implementasi double linked list. Program ini dapat dimodifikasi sesuai keinginan, kode yang saya tulis hanyalah contoh saja.
{{< gist rizkidoank 5f4645bf56cf638b59354e9bb50a5ab1 >}}

### Penutup
Implementasi dan kilasan teori terkait double linked list telah selesai. Sebenarnya ada method lain misal seperti delete after atau delete before, hanya saja dalam kasus ini diasumsikan telah diwakili fungsi delete element. Jika ingin memodifikasi atau mengembangkan dan mempelajari, silakan *fork* melalui repositori saya di [Double Linked List rizkidoank](https://github.com/rizkidoank/double_linked_list). Semoga bermanfaat dan sampai berjumpa kembali :D