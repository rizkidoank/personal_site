---

title: Single Linked List
date: '2016-10-11 04:47:08'
tags:
- programming
- computer-science
- algorithm
- cpp
- indonesian
---

### Pengertian Single Linked List
**Linked List** adalah sekumpulan *node* data yang terurut linear atau sekuensial. **Node** adalah istilah untuk elemen pada suatu list. Pada kondisi paling sederhana,*node* memiliki setidaknya dua atribut yaitu **data** dan **referensi** untuk *node* selanjutnya.

![node pada linked list](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/single_linked_01.jpeg)

**Single Linked List** adalah *linked list* dengan *node* yang memiliki data dan *reference link* (biasanya disebut **next**) yang menunjuk ke *node* lain pada *list*. Pada implementasinya, terdapat dua variasi *single linked list* yaitu **circular** dan **non-circular**. Berikut adalah ilustrasi *single linked list non-circular*

![single linked list non-circular](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/single_linked_02.jpeg)

Sedangkan untuk *single linked list circular* adalah sebagai berikut.

![single linked list circular](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/10/single_linked_03.jpeg)

### Operasi pada Single Linked List
Pada *single linked list* dapat dilakukan beberapa operasi, beberapa operasi yang dapat dilakukan yaitu : *insert*, *delete*, *print*.

### Implementasi Single Linked List dengan C++
Implementasi *single linked list* dapat lebih mudah dipahami dengan bahasa yang mendukung pointer. Pada tulisan ini *single linked list* diimplementasikan dengan menggunakan C++. Berikut adalah implementasi dari program.

#### Abstract Data Type
Bagian ini merupakan *header* dari implementasi *single linked list* digunakan untuk definisikan method dan fungsi, serta struktur data tipe. Pada contoh ini struktur tipe data yang digunakan sangat sederhana, yaitu **data** dan **next** (referensi ke *node* lain).
<script src="https://gist.github.com/rizkidoank/08991cd93c7c3552fd51c66f24800175.js"></script>

#### Implementasi Single Linked List
Bagian ini merupakan implementasi untuk *single linked list*, dalam kasus ini adalah *non-circular*. Berkas ini berisi lojik *method* dan fungsi pada *single linked list* dengan bahasa C++.
<script src="https://gist.github.com/rizkidoank/8cb5b1ae9dbb698cd1c643dbfe0aed85.js"></script>

#### Implementasi Utama atau Main Program
Berikut adalah implementasi utama dari *single linked list*, alur program dapat dicek dengan *step debugger* atau jika ingin lebih jelas dapat modifikasi bagian ini sesuai keinginan.
<script src="https://gist.github.com/rizkidoank/99d6605068705bfffc4141f7388f231c.js"></script>

Implementasi *single linked list* dengan C++ telah selesai. Agar lebih jelas, kode tersebut dapat dimodifikasi dan dipelajari. Selamat belajar!

### Catatan
* Fungsi **allocate** berfungsi untuk alokasi memori untuk *node*.
* Fungsi **free** berfungsi untuk *release* memori yang digunakan *node*.
* *Pointer* pada *single linked list* adalah atribut **next** pada *node*.