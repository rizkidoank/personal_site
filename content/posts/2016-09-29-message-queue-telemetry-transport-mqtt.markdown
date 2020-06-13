---

title: Message Queue Telemetry Transport (MQTT)
date: '2016-09-29 12:30:02'
tags:
- general
- iot
- networking
- jaringan
---

***Message Queue Telemetry Transport (MQTT)*** adalah protokol layer aplikasi yang didesain khusus untuk *constrained-device* [1]. *Constrained-device* yang dimaksud disini yaitu perangkat yang memiliki keterbatasan disisi *resources*. MQTT menggunakan arsitektur dengan model *topic-based publish-subscribe*.

![publish-subscribe model](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/mqtt_01.png)
Pada MQTT, akan ada setidaknya tiga pemeran utama yaitu *publisher, subscriber, dan broker* (lihat gambar diatas). *Publisher* adalah peran yang memberikan suatu pesan kepada topik tertentu. *Subscriber* yaitu klien yang *subscribe* suatu topik, sehingga ketika *publisher* mengirimkan pesan ke topik tersebut, *subscriber* dengan topik yang sama akan menerima pesan tersebut. Lalu, yang terakhir yaitu *broker*, ia berperan sebagai perantara antara *publisher* dan *subscriber*. Broker akan meneruskan pesan dari *publisher* untuk dikonsumsi oleh *subscriber*.

MQTT menggunakan protokol TCP layaknya HTTP. Tetapi, berbeda dengan HTTP, header pada MQTT lebih ringkas sehingga dapat menghemat sumber daya dan lebih ringan dibandingkan HTTP. Untuk keamanan, MQTT juga mendukung TLS dan otentikasi pengguna.

MQTT juga mendukung Quality of Service dengan tiga level yaitu QoS 0, QoS 1, dan QoS 2. Semakin besar levelnya, maka akan semakin ketat MQTT dalam aturan penerimaan paket dengan catatan akan mungkin terjadi peningkatan *overhead*.

Pada ranah *Internet of Things*, MQTT banyak dijadikan pilihan dalam membuat solusi IoT setelah HTTP. Karena, MQTT cenderung mudah dalam penggunaannya. Contoh broker yang mendukung MQTT antara lain mosquitto, RabbitMQ, HiveMQ, ActiveMQ, dan lain-lain. Sementara itu untuk perangkat yang mendukung IoT juga cukup banyak seperti seri Arduino, ESP8266, Raspberry Pi, OpenWRT router, dan lain-lain.