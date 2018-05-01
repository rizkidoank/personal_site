---
layout: post
title: Integrasi Splash dengan Scrapy
date: '2016-08-18 06:05:01'
---

Pada tulisan sebelumnya di **[Rendering Javascript dengan Splash](https://rizkidoank.com/2016/06/16/rendering-javascript-dengan-splash/)** saya telah menulis pengantar dari Splash. Splash adalah salah satu *javascript rendering service* berbasis WebKit dan layanan ini bersifat *headless*.

Scrapy merupakan salah satu *web scraper framework* berbasis python yang cukup populer. Pada kondisi default, scrapy tidak mampu melakukan *javascript rendering* / *dynamic webpage load*, sehingga diperlukan pihak aplikasi tambahan seperti Selenium atau Splash.

Pada tulisan ini saya akan memaparkan cara integrasi Scrapy dengan Splash sebagai *dynamic webpage rendering service*. Berikut cara integrasinya.

### Pemasangan Splash
Diasumsikan project dan encironment scrapy telah terbuat. Langkah pertama yang dilakukan yaitu memasang splash dengan perintah :

    pip install scrapy-splash
### Konfigurasi Splash
Setelah splash terpasang, selanjutnya lakukan konfigurasi pada scrapy.
1. Di `settings.py` pada scrapy, tambahkan parameter baru :
    
    SPLASH_URL = 'http://127.0.0.1:8050'
2. Tambahkan `DOWNLOAD_MIDDLEWARES` , `SPIDER_MIDDLEWARES`, `DUPEFILTER_CLASS` pada `settings.py`,

        DOWNLOADER_MIDDLEWARES={
        'scrapy_splash.SplashCookiesMiddleware': 720,
        'scrapy_splash.SplashMiddleware': 725,
	    'scrapy.downloadermiddlewares.httpcompression.HttpCompressionMiddleware': 810,
    }
	SPIDER_MIDDLEWARES={
	    'scrapy_splash.SplashDeduplicateArgsMiddleware': 100,
	}
    DUPEFILTER_CLASS='scrapy_splash.SplashAwareDupeFilter'
    HTTPCACHE_STORAGE = 'scrapy_splash.SplashAwareFSCacheStorage'
3. Selanjutnya, pada *spider* anda, ubah `start_requests` untuk menggunakan Splash.
    
    splash_args = {
        'html':1,
        'images':0,
        'png':0,
    }

    def start_requests(self):
        for url in self.start_urls:
            yield SplashRequest(
                url=url,
                callback=self.parse_info,
                endpoint='render.json',
                args=self.splash_args
            )
4. Pemasangan dan integrasi selesai. Scrapy akan menggunakan Splash untuk *webpage rendering*, untuk selectornya masih sama, atau dapat menggunakan 'BeautifulSoup 4'

#### References
## Referensi
* Scrapinghub Splash, online : http://scrapinghub.com/splash/
* Splash Documentation, online : http://splash.readthedocs.org/
* Splash Github, online : https://github.com/scrapinghub/splash
* Scrapy-splash Github, online : https://github.com/scrapy-plugins/scrapy-splash
