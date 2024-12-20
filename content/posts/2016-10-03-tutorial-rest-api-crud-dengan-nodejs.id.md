---
title: Tutorial REST API CRUD dengan NodeJS
date: '2016-10-03 08:12:00'
tags:
- programming
- server
- web
- api
- service
- indonesian
---

Setelah mengenal REST API pada post sebelumnya di [Pengantar REST API](https://rizkidoank.com/2016/09/30/pengantar-rest-api/), saya akan membuat contoh REST API untuk CRUD dengan contoh model yaitu User.

### Desain REST API
Berikut adalah desain API yang akan saya buat,
| **HTTP Method** | **Path**             | **Action** | **Description**          |
|-----------------|----------------------|------------|--------------------------|
| GET             | /api/users           | index      | get all users            |
| POST            | /api/users           | create     | create a user            |
| GET             | /api/users/:username | show       | show a user informations |
| PUT             | /api/users/:username | update     | update user informations |
| DELETE          | /api/users/:username | delete     | delete a user            |

### System Requirements
Untuk dapat membuat API ini, saya menggunakan perangkat sebagai berikut:

- NodeJS LTS dengan NVM, pemasangan dapat dibaca di [Setup NodeJS dan MongoDB di Linux](https://rizkidoank.com/2016/09/20/setup-node-js-dan-mongodb-di-linux/).
- MongoDB, dapat gunakan tautan yang sama untuk contoh pemasangannya.
- Postman, dapat diunduh melalui [getpostman](https://www.getpostman.com/).

### Langkah Pengerjaan
#### Inisialisasi
1. Pastikan NodeJS dan MongoDB telah aktif.
2. Buat direktori baru, lalu masuk ke direktori tersebut dan inisialisasi proyek NodeJS. Isikan informasi sesuai keinginan anda.
    ```bash
    mkdir rest-api;cd rest-api
    npm init
    ```
3. Pasang paket `bcrypt, body-parser, express, mongoose, validator` dengan `npm`
    ```bash
    npm install --save bcrypt body-parser express mongoose validator
    ```
4. Buat skrip baru dengan nama `server.js` atau sesuai keinginan.

#### Membuat Model User
1. Pada root proyek, buat direktori baru dan masuk ke direktori tersebut.
    ```bash    
    mkdir -p app/models
    cd app/models
    ```
2. Buat skrip dengan nama `user.js` untuk model User.
3. Berikut adalah isi skrip untuk model User.
    ```js
    /**
     * USER Model
        * attributes  : username (unique), password, name, email, date_joined
        * description :    username should be unique,
        *                  password encrypted by hash with bcrypt,
        *                  email should be valid format,
        *                  date_joined is the date when user register / created
        * **/
    var mongoose = require('mongoose'),
        Schema = mongoose.Schema,
        bcrypt = require('bcrypt'),
        bcrypt_rounds = 5;

    var validator = require('validator');

    var user_schema = new Schema({
        username:{
            type:String,
            required:true,
            index:{
                unique:true
            }
        },
        password:{
            type:String,
            required:true
        },
        name:{
            type:String,
            required:true
        },
        email:{
            type:String,
            required:true,
            validate:{
                validator: function (str) {
                    return validator.isEmail(str);
                },
                message: 'email not valid'
            }
        },
        date_joined:{
            type:Date,
            default:Date.now()
        }
    });

    user_schema.pre('save',function (next) {
        var user = this;
        if(user.isModified('password')){
            bcrypt.genSalt(bcrypt_rounds,function (err,salt) {
                if(err) return next(err);
                bcrypt.hash(user.password,salt,function (err,hash) {
                    if(err) return next(err);
                    user.password = hash;
                    next();
                })
            })
        } else return next();
    });

    user_schema.methods.isPassMatch = function (pass, callback) {
        bcrypt.compare(pass,this.password,function (err,isMatch) {
            if(err) return callback(err);
            callback(null,isMatch);
        });
    };

    module.exports = mongoose.model('User',user_schema);
    ```

Pada model User, terdapat atribut `username, password, name, email` dan `date_joined`. `username` berperan sebagai field unik. Sementara itu, untuk password saya lakukan *hashing* dengan modul `bcrypt` dan membuat method pengecekan password. Selanjutnya, ada `email` yang dengan terdapat validator apakah input sesuai format email atau tidak. Lalu, ada `date_joined` yang merupakan waktu user terdaftar pada sistem. Terakhir, ada `name` yang isinya adalah nama dari user tersebut.

#### Membuat REST API Server
1. Pada root proyek, edit skrip `server.js`.
2. Berikut adalah isi dari `server.js`
    ```js
    /**
     * Created by rizki on 10/1/16.
        */
    /**
     * REST API Sample
        * Sample model : User
        * Description : sample REST API using nodejs with expressjs, providing CRUD operations.
        */

    // 1. call needed packages and defines port and some instances
    var express = require('express'),
        app = express(),
        bodyParser = require('body-parser');
    var port = 8080;
    var router = express.Router();

    // model instances
    var User = require('./app/models/user');

    // 2. use body parser to get data from HTTP request
    app.use(bodyParser.urlencoded({
        extended:true
    }));
    app.use(bodyParser.json());

    // 3. create connection to mongodb
    var mongoose = require('mongoose');
    mongoose.connect('mongodb://localhost:27017/sample');

    // 4. API Routes
    // this one is root routes, just a simple response
    router.get('/',function (req,res) {
        res.json({
            message:"Welcome to REST API Sample"
        });
    });

    // model related routes
    // POST : create a user
    // GET : get all users
    router.route('/users')
        .post(function (req,res) {
            var user = new User();
            user.username = req.body.username;
            user.password = req.body.password;
            user.name = req.body.name;
            user.email = req.body.email;
            user.save(function (err) {
                if(err) res.send(err);
                else res.json({
                    message:'new user created'
                });
            });
        })
        .get(function (req,res) {
            User.find(function (err,users) {
                if(err) res.send(err);
                else res.json(users);
            });
        });

    // GET : get a user
    // PUT : updating user attributes
    // DELETE : delete user
    router.route('/users/:username')
        .get(function (req,res) {
            User.findOne({
                username:req.params.username
            },function (err,user) {
                if(err) res.send(err);
                else res.json(user);
            });
        })
        .put(function (req,res) {
            User.findOne({
                username:req.params.username
            },function (err,user) {
                if(err) res.send(err);
                else{
                    user.username = req.body.username;
                    user.password = req.body.password;
                    user.name = req.body.name;
                    user.email = req.body.email;
                    user.save(function (err) {
                        if(err) res.send(err);
                        else res.json({
                            message:'user updated'
                        });
                    });
                }
            });
        })
        .delete(function (req,res) {
            User.remove({
                username:req.params.username
            }, function (err,user) {
                if(err) res.send(err);
                else res.json({
                    message:'user deleted'
                })
            });
        });


    app.use('/api',router); // prefix for 'router'
    app.listen(port); // this service will listen on port defined at point 1
    console.log('services started at port : '+port);
    ```

3. Jalankan API services dengan perintah `node server.js`
4. Services akan aktif di port 8080 jika menggunakan skrip diatas.

#### Testing REST API Service
Testing API ini saya menggunakan Postman

##### POST : /api/users
Di tahap ini saya memilih method POST, kemudian saya masuk ke tab **Body** dan pilih radio **x-www-form-urlencoded**. Selanjutnya, saya tambahkan *key-value* atribut yang akan saya kirimkan. Jika pengisian atribut telah selesai, klik **Send**.
#### GET : /api/users
Di aksi ini, saya menggunakan method GET. Berikut tampilan ketika saya kirimkan rekues `GET /api/users`.
#### GET : /api/users/:username
Gunakan method GET dengan path `/api/users/<username>`, misal: `/api/users/rizkidoank`, maka akan ditampilkan informasi user untuk username `rizkidoank` saja jika ada.
#### PUT : /api/users/:username
Gunakan method PUT, lalu pada tab **Body**, tambahkan *key-value* informasi yang akan diubah. Jika berhasil, data user akan diperbaharui, begitu pula hash passwordnya. Berikut contoh saat dilakukan update user.
#### DELETE : /api/users/:username
Gunakan method DELETE dengan path `/api/users/<username>`. Jika berhasil, maka akan tampil response user terhapus, begitupun didalam basis data juga akan terhapus.

### Penutup
*Nah*, tulisan kali ini cukup panjang sepertinya. Jika anda tertarik mencoba atau mempelajari, anda dapat mengikuti panduan ini. Saya juga menyimpan proyek ini di *github* pribadi saya di [sini](https://github.com/rizkidoank/rest_api_sample). Selamat mencoba, semoga bermanfaat :smile: