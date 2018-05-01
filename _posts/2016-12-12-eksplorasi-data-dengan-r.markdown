---
layout: post
title: Eksplorasi Data dengan R
date: '2016-12-12 04:07:14'
tags:
- r
- machine-learning
- statistics
- data-science
---

Dalam *data science* sebelum dilakukan analisis data lebih lanjut, ada baiknya dilakukan dahulu eksplorasi data. Eksplorasi data juga disarankan untuk yang baru memasuki *data science*. Dengan eksplorasi data, dapat diketahui apa saja atribut pada dataset, bagaimana nilai-nilai yang ada dalam dataset, distribusi data, atau keterhubungan suatu atribut dengan atribut lainnya.

Pada tulisan ini saya mencoba untuk eksplorasi data dan beberapa visualisasinya untuk dataset [Iris](http://archive.ics.uci.edu/ml/datasets/Iris) dari UCI Machine Learning Repository. Berikut adalah ekplorasi data yang saya lakukan untuk dataset iris.

1. Load Dataset
Dataset Iris dapat di load langsung melalui R, karena sudah ada didalam R, cukup dengan perintah `data(iris)` saja. Jika ingin load manual, silakan unduh melalui laman dataset iris, kemudian gunakan `read.csv` untuk membaca dataset.
2. Mengenal Struktur Dataset
Struktur dataset juga merupakan hal yang perlu diketahui agar dapat lebih jelas akan diapakan dataset tersebut, atau membantu dalam pemisahan data numerik dan non-numerik.

        str(iris) #menampilkan strutur dataset
        head(iris) #menampilkan data teratas
        iris.num <- iris[,1:4] #memisah atribut numerik dengan atribut spesies 
 
 ![struktur dataset iris](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/struktur.png)

 Diketahui pada dataset iris terdapat atribut *Sepal Length, Sepal Width, Petal Length, dan Petal Width* dengan tipe data *number*, serta terdapat atribut *Species* yang memiliki tiga nilai yaitu *setosa, versicolor, dan virginica* sesuai dengan deskripsi pada laman resminya. Berdasarkan informasi tersebut, saya memisah empat atribut pertama ke variabel `iris.num`, keempat atribut ini akan menentukan spesies.

3. Statistik Dataset
Pada data yang ada juga dapat diketahui statistik dari data tersebut, misal: mean, median, quantile, variansi, kovariansi, korelasi. Misal, dari dataset ini saya ingin mengetahui nilai statistika deskriptif dan variansinya.

        summary(iris) #menampilkan mean, median, quantile, dan frekuensi spesies.
        var(iris.num) #menampilkan variansi atribut satu dengan lainnya.

 ![summary dataset iris](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/summary.png)

4. Visualisasi
Informasi berupa data numerik memang diperlukan, tetapi terkadang sulit memahami atau menggambarkannya. Sehingga, seringkali visualisasi data juga dilakukan untuk lebih mudah memahami data. Berikut saya membuat pie chart, boxplot, dan pairs plot untuk dataset iris.

        #membuat pie chart untuk spesies
        pie(table(iris$Species))

        #mengatur pelatakan grafik
        par(mfrow=c(2,2),oma=c(1,1,1,1))
        #membuat histogram tiap atribut
        hist(iris$Sepal.Length,col = "grey")
        hist(iris$Sepal.Width,col = "grey")
        hist(iris$Petal.Length,col = "grey")
        hist(iris$Petal.Width,col = "grey")

        #atur peletakan grafik
        par(mfrow=c(2,2),mar=c(2,2,2,2))
        #membuat boxplot tiap atribut terhadap spesies
        boxplot(Sepal.Length ~ Species, main = "Box Plot Sepal Length - Species", data = iris, xlab = "Species", ylab = "Sepal.Length")

        boxplot(Sepal.Width ~ Species, main = "Box Plot Sepal Width - Species", data = iris, xlab = "Species", ylab = "Sepal.Width")

        boxplot(Petal.Length ~ Species, main = "Box Plot Petal Length - Species", data = iris, xlab = "Species", ylab = "Petal.Length")

        boxplot(Petal.Length ~ Species, main = "Box Plot Petal Width - Species", data = iris, xlab = "Species", ylab = "Petal.Width")
        
        #membuat pairs plot tiap atribut terhadap spesies
        iris.jitter <- apply(iris.num,2,function(o){jitter(o)})
        iris.jitter <- apply(iris.num,2,function(o){jitter(o)})
        pairs(iris.jitter,main="Pairs Plot of Iris Data",pch=21,bg = c("red", "green", "blue")[unclass(iris$Species)])

 ![pie chart iris](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/pie_iris.png)

 Dari grafik tersebut, terdapat tiga spesies yang masing-masing memiliki frekuensi yang sama, berdasarkan dari statistiknya yaitu 50.

 ![histogram iris](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/histogram_iris.png)
 grafik histogram tiap atribut.

 ![boxplot iris](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/boxplot_iris.png)
 Box plot untuk dataset iris. Terdapat empat sub grafik, dari grafik ini saya dapat melihat ciri-ciri dari masing-masing spesies dari panjang dan lebar sepal, dan panjang dan lebar petal.

 ![pairs plot](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/12/pairs_plot_iris.png)
 Pairs plot dapat digunakan untuk melihat relasi hubungan antar variabel.

Itulah eksplorasi data yang saya lakukan untuk dataset iris. Mungkin masih banyak informasi yang dapat dicari, tapi saya hanya menemukan itu saja yang ditemukan untuk saat ini. Untuk kode sumber lengkapnya silakan gunakan srip dibawah.

<script src="https://gist.github.com/rizkidoank/e3fc558cc3c01b1f966cc59aae09fffb.js"></script>

