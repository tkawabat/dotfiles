# sentry
* クラッシュレポート

## sentryを入れるとxcodeのビルドがエラーになる
* Build Phase -> Upload Debug Symbols to Sentry -> nodeへのパスを通す

## sentry.propeties
* android, iosディレ以下に配置
    * 自動生成される
* tokenがあるのでgitには追加しない
* tokenは以下
    * https://sentry.io/settings/account/api/auth-tokens/

```

defaults.url=https://sentry.io/
defaults.org=<オーガナイザ名>
defaults.project=<プロジェクト名>
auth.token=<トークン>
cli.executable=node_modules/@sentry/cli/bin/sentry-cli
```
