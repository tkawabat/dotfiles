# dotfiles (chezmoi)

このリポジトリは `chezmoi` の source state として運用します。  
`install.sh` は廃止し、適用は `chezmoi` のみを使います。

## 初回セットアップ

### 1. chezmoi をインストール

- macOS: `brew install chezmoi`
- Ubuntu/WSL2: `sudo snap install chezmoi --classic` または公式手順

### 2. dotfiles を適用

```bash
chezmoi init --apply https://github.com/<your-account>/dotfiles.git
```

ローカル clone から適用する場合:

```bash
chezmoi init --apply /path/to/dotfiles
```

## 日常運用

差分確認:

```bash
chezmoi diff
```

適用前の dry-run:

```bash
chezmoi apply --dry-run --verbose
```

適用:

```bash
chezmoi apply
```

## ロールバック

直近バックアップから戻す:

```bash
chezmoi archive
```

必要に応じて archive に保存されたバックアップを取り出して復旧します。  
または、リポジトリの既知コミットに戻して `chezmoi apply` を再実行します。

## 管理外ファイル（機密・端末固有）

このリポジトリでは機密情報を管理しません。

- `~/.local_zsh_rc`: API key やローカル上書き設定
- `~/.ssh/config.local`: 端末固有の SSH 設定

これらは存在する場合のみ読み込まれます。
