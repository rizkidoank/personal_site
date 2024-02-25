---

title: Stream Twitter Statuses with Tweepy 
date: '2018-12-15 20:47:00'
tags:
- data-collection
- tutorial
- python
- english
---

Flashback to several years ago when I was using Twitter and learn text mining. At that time, I used python
 to collects twitter statuses with specific keywords / terms defined and then stored all of those statuses
to csv as dataset for text mining learning. In this article, I will share how to stream twitter statuses
with python using tweepy module but in this article, I only print the status without store it to a file or 
database.

## Requirements

- Python 3, you might use Python 2. But I recommend to use Python 3 since Python 2 going to reach its EOL.
- `tweepy` module, install using `pip install tweepy`
- Twitter Apps key and tokens, create your in [here](https://developer.twitter.com/en/apps)

## Go to the Code
Here is my code to stream tweets in twitter:
```pthon
from tweepy.streaming import StreamListener
from tweepy import Stream
from tweepy import OAuthHandler
from tweepy import API
import os
import time

CONSUMER_KEY = os.environ['TWITTER_CONSUMER_KEY']
CONSUMER_SECRET = os.environ['TWITTER_CONSUMER_SECRET']
ACCESS_TOKEN = os.environ['TWITTER_ACCESS_TOKEN']
ACCESS_TOKEN_SECRET = os.environ['TWITTER_ACCESS_TOKEN_SECRET']
KEYWORDS = ['cianjur']


class TweetListener(StreamListener):
    def __init__(self, batch_size):
        super(TweetListener, self).__init__()
        self.tweets = []
        self.batch_size = batch_size
        self.count = 0

    def on_status(self, status):
        if status.retweeted or ('RT' in str(status.text).split(' ')):
            return
        self.tweets.append(status)
        if len(self.tweets) >= self.batch_size:
            self.tweets = []
            print("sleep 5 secs")
            time.sleep(5)
        self.count = self.count + 1
        print(status.text)
        return True

    def on_error(self, status_code):
        if status_code == 420:
            print("Rate Limited")
            return False


def auth_twitter():
    auth = OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
    auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
    return auth


if __name__ == '__main__':
    auth = auth_twitter()
    api = API(auth, wait_on_rate_limit=True)

    stream_listener = TweetListener(batch_size=10)
    stream = Stream(auth=api.auth, listener=stream_listener)

    stream.filter(track=KEYWORDS)
```
The code itself is quite simple and straightforward, let's move to next section for more
details.

## Explanation
```python
from tweepy.streaming import StreamListener
from tweepy import Stream
from tweepy import OAuthHandler
from tweepy import API
import os
import time
```
First part are importing required modules to be used in the process. `StreamListener` is a listener that will
receives all messages routed by `Stream` established session. `OAuthHandler` used for authentication purpose.
The `API` is twitter API wrapper provided by `tweepy`.

```python
CONSUMER_KEY = os.environ['TWITTER_CONSUMER_KEY']
CONSUMER_SECRET = os.environ['TWITTER_CONSUMER_SECRET']
ACCESS_TOKEN = os.environ['TWITTER_ACCESS_TOKEN']
ACCESS_TOKEN_SECRET = os.environ['TWITTER_ACCESS_TOKEN_SECRET']
KEYWORDS = ['cianjur']
```

The next part are constants for the script, it's including twitter apps credentials and in this case, the stream
keywords. Please note that I retrieved the credentials from environment variables, so you need to `export` the variable
to your environment by `export TWITTER_xxx_xxx=content` for all vars.

```python
class TweetListener(StreamListener):
    def __init__(self, batch_size):
        super(TweetListener, self).__init__()
        self.tweets = []
        self.batch_size = batch_size
        self.count = 0

    def on_status(self, status):
        if status.retweeted or ('RT' in str(status.text).split(' ')):
            return
        self.tweets.append(status)
        if len(self.tweets) >= self.batch_size:
            self.tweets = []
            print("sleep 5 secs")
            time.sleep(5)
        self.count = self.count + 1
        print(status.text)
        return True

    def on_error(self, status_code):
        if status_code == 420:
            print("Rate Limited")
            return False
```

This is the class that inherited from `StreamListener`. I created `__init__` method to add several class variable like
`tweets` to store list of tweet, `batch_size` to define maximum tweets stored in a batch. Batch useful if you're going 
to pass the `tweets` to another stage, in example to messaging queue, it's actually not useful for this article, so you
might remove it if necessary. The last are `count` that will store number of tweets that already receives, useful if 
you're going to limit tweets size.

Next is `on_status` in here, I basically only receive tweet that not a retweet status and print the content. 
When tweets size limit the batch size, it will reset the list and sleep for five secs to prevent to many request in 
specific window time there might be a better solution for this, lol.

The last is `on_error`, its basically just exit if the streamer got rate limited. For more response codes, go to 
[here](https://developer.twitter.com/en/docs/basics/response-codes.html)

```python
def auth_twitter():
    auth = OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
    auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
    return auth


if __name__ == '__main__':
    auth = auth_twitter()
    api = API(auth, wait_on_rate_limit=True)

    stream_listener = TweetListener(batch_size=10)
    stream = Stream(auth=api.auth, listener=stream_listener)

    stream.filter(track=KEYWORDS)
```
The last part are `auth_twitter`, this function used to authenticate twitter apps using oauth. And the
most important part is the main method. The processes are authentication, create a stream listener, establish stream 
session, and finally start the stream by filter with specific keywords/terms.

## Running the Code
```python
(twitter-stream) ➜  twitter-stream pipenv run python twitter_stream/stream.py
Ini bukti dukungan masyarakat thdp penindakan koruptor yg dilakukan @KPK_RI. Maju terus KPK, rakyat mendukungmu.
https://t.co/o2y1rMWDmN
@ridwankamil muhun kang sngt wajar. Ts lami masrakat cianjur trtindas ti jmn p cecep tp t walakaya, alhamdulillaah ihdinassirootol-mustaqiim
Empat kardus dan satu koper dibawa dari Disdik Cianjur #ElshintaWeekend https://t.co/dX9BRJsmkI
Proklamasi jilid 2 Kemerdekaan dari Korupsi.
Dampak Dari penangkapan #Bupaticianjur Hampir semua yang berkaitan dengan "Cianjur Jago" dirusak " bingung akutu :( https://t.co/gqRLDmsN6H
Graduation Video
Universitas Putra Indonesia
Yayasan Pendidikan Yuyun Moeslim Taher
Cianjur,  tanggal 1 Desember 20… https://t.co/qTk4E5VNDr
```
if everything works, you'll see the tweets stream in your console. Please do ignore the tweets, I run it not in a good 
time for `cianjur` keyword. Haha