# 修正後テストプラン（macOS + WSL2 Ubuntu）

## 事前条件

- `chezmoi` が利用可能であること
- テストは管理対象ユーザーで実行すること

## 1. 構文テスト（zsh）

`dot_zshenv.tmpl` と `dot_zshrc.tmpl` を各OS条件でレンダリングし、以下を実行:

```bash
zsh -n ~/.zshenv
zsh -n ~/.zshrc
```

期待結果: どちらも終了コード 0

## 2. テンプレート分岐テスト

`chezmoi execute-template` で `darwin` / `linux` 条件を検証する。  
確認ポイント:

- Darwin 時のみ `/opt/homebrew/bin` と `UseKeychain` が出力される
- Linux 時は上記が出力されない

## 3. dry-run テスト

```bash
chezmoi diff
chezmoi apply --dry-run --verbose
```

期待結果: 想定外の上書きがない

## 4. 冪等性テスト

```bash
chezmoi apply
chezmoi apply
chezmoi diff
```

期待結果: 2回目適用後に差分がない

## 5. macOS 実機テスト

確認項目:

- `zsh -i -c exit` がエラーなく終了
- `ssh -G example.com` の出力に `usekeychain yes` が含まれる
- `nvm`, `pyenv`, `gcloud` 未導入時でも起動失敗しない

## 6. WSL2 Ubuntu 実機テスト

確認項目:

- `zsh -i -c exit` がエラーなく終了
- `ssh -G example.com` で `usekeychain` 関連エラーが出ない
- mac 固有パス（`/opt/homebrew/bin`）に依存しない

## 7. 管理外ファイルテスト

`~/.local_zsh_rc` と `~/.ssh/config.local` をそれぞれ:

- 置かない場合: 起動エラーなし
- 置く場合: 設定が反映される

## 8. Git管理テスト

```bash
git status --short
```

期待結果:

- 機密情報・ローカル専用ファイルが追跡対象に入らない
- `README.md`, `TEST_PLAN.md`, `doc/` は `.chezmoiignore` で配布対象外

## 9. 回帰テスト

確認項目:

- エイリアス `ll`, `jgrep`, `svim` が動作
- 履歴設定（`hist_ignore_space`, `hist_ignore_all_dups`）が有効
