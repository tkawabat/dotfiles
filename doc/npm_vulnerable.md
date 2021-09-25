## 脆弱性対応

### npm audit fixで治らないとき
1. npm auditで確認
1. package-lock.jsonを編集
    * 安全なバージョンが入っていない場合
        * npm installで必要なバージョンを入れる
    * 安全なバージョンが入ったら
        * 脆弱性があるバージョンの記述を全部消す
            * dependencies, requiresはバージョンを書き換える
            * 脆弱性があるバージョンのインストールは全部消す
1. 対象のディレクトリを消す
    * 方法１：node_modules/以下を探して消す
        * npm lsで探して、依存パッケージ以下を消す
    * 方法２：再インストール
        * rm -rf node_modules/ && npm i
        * また入ることがあるので、もう一度上の工程をやって消す
1. npm dedupe
    * 依存関係の整理？
1. npm auditで確認
    * 治ってるはず
