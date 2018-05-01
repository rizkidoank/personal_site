---
layout: post
title: SparkR Installation and Setup on RStudio
date: '2016-12-10 12:17:37'
tags:
- r
- programming
- statistics
- data-science
---

**Apache Spark** adalah mesin pemrosesan data yang cepat yang saat ini umum digunakan pada *big data environment* dan untuk pembelajarn mesin. Spark mendukung beberapa bahasa seperti Java, Scala, Python dan saat ini hadir untuk bahasa R.

Spark dapat dipasang pada mode lokal maupun mode cluster. Dalam tulisan ini akan dipaparkan pemasangan SparkR pada mode lokal. Berikut adalah langkah pemasangan SparkR + RStudio.

1. Pastikan RStudio, R, dan Java JDK telah terpasang. Ringkasan tentang RStudio dapat dibaca pada tulisan [RStudio : IDE untuk R](https://rizkidoank.com/2016/06/11/rstudio-ide-untuk-r/), jika belum terpasang silakan pasang melalui manajemen paket atau *installer* pada situs resminya. ![RStudio IDE](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/rstudio-ide.PNG)

2. Unduh Apache Spark, saya gunakan Apache Spark + Prebuilt Hadoop. ![Download Spark](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/spark-download.PNG)
3. Ekstrak Spark pada lokasi tertentu.
4. Buka RStudio
5. Selanjutnya, pada skrip atau *R shell*, tuliskan perintah.

        if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
          Sys.setenv(SPARK_HOME = "../Documents/spark/")
        }
        library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
        sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "1g"))
6. SparkR session telah aktif. Selanjutnya SparkR shell aktif dan dapat digunakan.

Note :

1. SPARK_HOME adalah lokasi dari spark yang telah di ekstrak.
2. Jika terdapat kesalahan, silakan cek driver memory, kecilkan memori, dalam tulisan ini digunakan driver memory sebesar 1GB.
3. Alternatif lain bisa gunakan paket *sparklyr*, untuk instruksi lebih lanjut dapat diakses di http://spark.rstudio.com/