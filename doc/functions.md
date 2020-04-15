#


## deploy

```
$ firebase use act-arena
$ firebase projects:list
$ firebase deploy --only functions
$ firebase use act-arena-dev-27e15
```

## firebase cli
* 台本
    1. google docsからtsvでダウンロード
    1. dev

    ```
    $ ts-node src/cli.ts arenaScenario -d && ts-node src/cli.ts arenaScenario -f work/scenario.tsv
    ```

    1. prod

    ```
    $ export GOOGLE_APPLICATION_CREDENTIALS=<prod用認証json>
    $ ts-node src/cli.ts arenaScenario -d && ts-node src/cli.ts arenaScenario -f work/scenario.tsv
    $ export GOOGLE_APPLICATION_CREDENTIALS=<dev用認証json>
    ```



## 詰まったところ
* deployすると成功する、けど変更が反映されない
    * ファイルパスを変えた
    * しかし古いbuild結果が残っていてそちらがdeployされ続けていた
    * package.jsonのmainの項目に注意
