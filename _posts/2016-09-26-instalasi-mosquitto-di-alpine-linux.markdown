---
layout: post
title: Instalasi Mosquitto di Alpine Linux
date: '2016-09-26 08:10:38'
tags:
- server
- linux
- iot
---

![mosquitto_logo](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/mosquitto_01.png)

Mosquitto adalah broker MQTT opensource. MQTT adalah protokol konektivitas *Machine-to-Machine (M2M)* atau *Internet of Things*. MQTT dirancang seringan mungkin dengan menggunakan model publish dan subscribe. Untuk lebih lanjut mengenai MQTT dapat dibaca melalui referensi lain, atau ~~mungkin akan saya post juga di blog ini~~ baca tulisan berikut [Message Queue Telemetry Transport (MQTT)](https://rizkidoank.com/2016/09/29/message-queue-telemetry-transport-mqtt/).

Saya akan melakukan pemasangan Mosquitto untuk MQTT broker dengan Alpine Linux dengan mesin virtual. Sedangkan untuk klien publish dan subscribe saya gunakan host utama. Saya memilih kombinasi Mosquitto dan Alpine dikarenakan penggunaannya yang sederhana dan cenderung ringan untuk keperluan lab.

### Instalasi Broker
Berikut adalah langkah untuk memasang Mosquitto MQTT broker di Alpine Linux.
1. Update repositori, pasang editor dan mosquitto

    apk update
    apk add vim
    apk add mosquitto
2. Selanjutnya, buat password file untuk mosquitto. Saat jalankan command ini, saya diminta memasukkan password untuk user yang dibuat.

    mosquitto_passwd -c /etc/mosquitto/pwfile <user_pwfile>
3. Lakukan konfigurasi dengan edit file `mosquitto.conf`

    vim /etc/mosquitto/mosquitto.conf
4. Selanjutnya, uncomment baris-baris berikut

    listener 1883
    log_dest syslog
    log_type error
    log_type warning
    log_type notice
    log_type information
    connection_messages true
    log_timestamp true
    password_file /etc/mosquitto/pwfile
5. Jalankan mosquitto broker

    mosquitto -c /etc/mosquitto/mosquitto.conf
 
 atau

    /etc/init.d/mosquitto start

### Pengujian MQTT Broker
Setelah instalasi Mosquitto broker berhasil, saya akan menguji apakah berfungsi atau tidak broker tadi.

1. Pada host, saya melakukan subscribe topik `rizkidoank/hello`

        mosquitto_sub -h <host_broker> -p 1883 -v -t 'rizkidoank/hello' -u <user_pwfile> -P <pass_pwfile>

2. Selanjutnya, saya melakukan publish message ke topik `rizkidoank/hello`.

        mosquitto_pub -h <host_broker> -t 'rizkidoank/hello' -u <user_pwfile> -P <pass_pwfile> -m 'hello, test'

3. Berikut adalah tangkapan layar untuk message yang diterima oleh subscriber.

![publisher](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/mosquitto_02.png)
*Publisher*

![subscriber](https://rizkidoank.sgp1.digitaloceanspaces.com/rizkidoank/images/2016/09/mosquitto_03.png)
*Subscriber*

Yup! Pemasangan berhasil! Mosquitto kerap digunakan untuk projek IoT karena cenderung mudah. Kita bisa menggunakan MQTT di beragam platform seperti Raspberry Pi, ESP8266, Arduino, dan lain-lain. Selamat mencoba!