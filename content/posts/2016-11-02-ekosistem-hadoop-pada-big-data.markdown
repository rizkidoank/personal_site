---

title: Ekosistem Hadoop pada Big Data
date: '2016-11-02 21:35:58'
tags:
- sysadmin
- server
- database
- filesystem
- networking
- service
- big-data
- cluster
---

### Big Data, Hadoop?
Kata Big Data sempat menjadi hype di kalangan scientist dan IT enthusiast. Adapun salah satu yang banyak dibicarakan dan didiskusikan salah satunya terkait dengan infrastruktur Big Data. Bagi yang pernah mencoba belajar infrastruktur Big Data, setidaknya akan terdengar kata seperti Hadoop, Cluster, NoSQL, dan Distributed System (setidaknya itu yang pertama kali terdengar oleh saya saat akan belajar infrastruktur Big Data :D).

### Ekosistem Hadoop
Hadoop salah satu proyek yang dikembangkan oleh Apache Foundation. Ketika berbicara tentang Apache Hadoop yang tergambar adalah sebuah proyek inti itu sendiri. Sementara itu, akan ada istilah Hadoop Ecosystem karena pada aplikasinya ternyata sekumpulan perangkat lunak juga terlibat di ekosistem ini. Sekumpulan perangkat lunak ini dapat saling terhubung atau tidak, tergantung dari aplikasinya bagaimana.

Ekosistem Hadoop sebenarnya sangat luas, tidak hanya terkait pada HDFS,YARN, dan Hive saja misalnya. Akan tetapi banyak alternatif dan kombinasi yang dapat digunakan. Pada tulisan ini saya akan menyampaikan salah satu kombinasi ekosistem Hadoop yang umum digunakan.

### Contoh Ekosistem Hadoop
Pada bagian ini saya akan sampaikan stack salah satu ekosistem Hadoop yang umum digunakan. Terdapat beberapa bagian yaitu Distributed Filesystem, NoSQL Database, SQL Database, Computing Framework.
![HDFS](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/HDFS.PNG)
#### Distributed Filesystem
Umumnya, Distributed Filesystem yang seringkali digunakan yaitu Hadoop Filesystem (HDFS). Ketika bicara tentang Hadoop, istilah HDFS pasti akan terdengar, walaupun sebenarnya banyak pilihan lain Distributed Filesystem. HDFS menjadi pilihan yang digunakan oleh distribusi Hadoop seperti Cloudera, Hortonworks Data Platform, MapR, dan lain-lain.
![YARN](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/YARN.PNG)
#### Computing Framework
Hal yang membedakan di Big Data yaitu pemrosesan yang dilakukan secara paralel pada filesystem terdistribusi. Model pemrograman MapReduce hadir sebagai salah satu model pemrosesan atau komputasi. Apache Hadoop memiliki framework komputasi dengan model MapReduce yang disebut dengan Apache MapReduce (v1) atau Apache YARN (v2).
![HBase Logo](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/hbase_logo_with_orca_large.png)
![HBase Architecture](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/hbase-arch.PNG)
#### NoSQL Database
Bicara tentang Big Data, berkaitan dengan jenis data yang akan diolah. Setidaknya terdapat dua jenis data ditinjau dari strukturnya yaitu data terstruktur dan tidak terstruktur. NoSQL merupakan salah satu bentuk solusi dalam menghadapi data tidak terstruktur. Umumnya basis data yang digunakan pada ekosistem Hadoop yaitu Apache HBase.
![Hive Logo](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/hive.png)
![Arsitektur Hive](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/11/hive-arch.PNG)
#### SQL Database on Hadoop
Pada bagian sebelumnya HBase berperan sebagai sistem basis data NoSQL. Apache Hive hadir sebagai salah satu SQL database on Hadoop yang populer saat ini.

Itulah stack perangkat lunak yang umum digunakan di ekosistem Hadoop. Sebenarnya, masih banyak lagi bagian lain misal untuk Data Streaming, Search Server/Framework. Pada tulisan lain mungkin akan dibagikan juga mengenai masing-masing penggunaannya, semoga saja bisa, hehe. Sekian tulisan kali ini, semoga bermanfaat dan semoga tertarik untuk kaji lebih dalam.

NOTE : Jika ada pertanyaan, saya ingin belajar ekosistem Hadoop atau infrastruktur Big Data, bagaimana bisa memulai? Saya dulu mulai dengan menggunakan distribusi Hadoop seperti Cloudera VM atau Hortonworks Data Platform Sandbox. Selanjutnya, untuk multinode saya gunakan GNS3 dan juga VPS. Tulisan selanjutnya sepertinya ingin menulis bagian ini juga. :D