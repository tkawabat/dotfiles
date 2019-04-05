# MongoDB

* install
    * http://may46onez.hatenablog.com/entry/2018/09/08/134428

```
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
$ echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
$ sudo apt update
$ sudo apt install mongodb-org
```

* export

```
$ mongoexport --host random-matching-free-0-shard-0/random-matching-free-0-shard-00-00-hkex0.mongodb.net:27017,random-matching-free-0-shard-00-01-hkex0.mongodb.net:27017,random-matching-free-0-shard-00-02-hkex0.mongodb.net:27017 --ssl --username admin --authenticationDatabase admin --db random_matching_test --collection=users --out users_`date "+%Y%m%d_%H%M%S"`.txt
```

* import

```
$ mongoimport --host random-matching-free-0-shard-0/random-matching-free-0-shard-00-00-hkex0.mongodb.net:27017,random-matching-free-0-shard-00-01-hkex0.mongodb.net:27017,random-matching-free-0-shard-00-02-hkex0.mongodb.net:27017 --ssl --username admin --authenticationDatabase admin --db random_matching_test --collection users --file users_hogehoge.txt
```
