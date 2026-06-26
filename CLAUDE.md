# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリの目的

このリポジトリは [`chezmoi`](https://www.chezmoi.io/) の **source state（管理元）** であり、ランタイムの設定ツリーではない。ここにあるファイルはテンプレートやリネームされたソースで、`chezmoi apply` によって `$HOME` 配下に展開される。`$HOME` 側を直接編集してもこのリポジトリには反映されない — 必ずこのリポジトリ側を編集すること。

ユーザーは日本語で作業する。README とほとんどのドキュメントも日本語。

## よく使うコマンド

```bash
chezmoi diff                       # $HOME との差分をプレビュー
chezmoi apply --dry-run --verbose  # テンプレート展開込みの dry-run
chezmoi apply                      # 実際に適用
chezmoi archive                    # 危険な変更前にバックアップを取る
chezmoi execute-template < dot_zshrc.tmpl  # 単一テンプレートを現在のデータで描画
```

ビルド／lint／test のツールチェインは無い。検証は `chezmoi diff` / `--dry-run` で行う。

小規模な修正を終えたら `chezmoi apply` → `git commit` → `git push` まで行う。

## ファイル命名規約（chezmoi）

新規作成・リネーム時、プレフィックスが配置先パスとモードを決める:

- `dot_foo`        → `~/.foo`
- `private_dot_x`  → `~/.x` (mode `0600`)
- `*.tmpl`         → apply 時に Go の text/template として描画
- `private_*.tmpl` → privateモード **かつ** テンプレート

例: `dot_claude/settings.json.tmpl` → `~/.claude/settings.json`（描画後）。

## テンプレートのデータフロー

テンプレートは **ホストローカル** の `~/.config/chezmoi/chezmoi.toml` から変数を読む。このファイルは意図的にリポジトリには含めない。スキーマは `chezmoi.toml.sample` に記載。テンプレート内の標準パターン:

```gotmpl
{{- $codex := dict -}}
{{- if hasKey . "codex" -}}{{- $codex = index . "codex" -}}{{- end -}}
{{- $extra := list -}}
{{- if hasKey $codex "extra_xxx" -}}{{- $extra = index $codex "extra_xxx" -}}{{- end -}}
```

この `hasKey` による防御的ガードがあることで、該当キーを設定していないマシンでも描画が通る。新しいテンプレート変数を追加する際もこのパターンを維持すること。

## .chezmoiignore のセマンティクス

`.chezmoiignore` は `.codex/**` と `.claude/**` に対して **default-deny / 明示 allow** 方式を取っている:

```
.codex/**
!.codex/
!.codex/config.toml
```

`dot_codex/` や `dot_claude/` 配下に新しいファイルを追加しても、`.chezmoiignore` で明示的に allow しない限り **無言で無視される**。これらの配下に管理対象ファイルを追加するときは、同じコミットで `.chezmoiignore` も更新すること。

## Claude ↔ Codex のポリシー同期

`dot_claude/settings.json.tmpl`（Claude Code の permissions）と `dot_codex/rules/managed.rules.tmpl`（Codex CLI の prefix rules）は **意図的にミラーリング** されている。同じコマンド集合の allow / ask|prompt / deny を、それぞれのツール構文で表現する:

- Claude: `allow` 配列内の `"Bash(git add:*)"`
- Codex:  `prefix_rule(pattern=["git", "add"], decision="allow")`

ユーザーが「このコマンドを許可／禁止して」と言ったら **両方** のファイルを更新する。3 カテゴリの対応は Claude `allow` ↔ Codex `allow`、Claude `ask` ↔ Codex `prompt`、Claude `deny` ↔ Codex `forbidden`。

各リストには末尾にホストローカルの拡張フック（`extra_allow_permissions`、`extra_allow_prefix_rules` など）が追記される。マシン固有のルールは共有リストには入れず、必ず `extra_*` 側に置くこと。

## ホストローカル／管理外ファイル

存在すれば読み込まれるが、このリポジトリでは管理しない:

- `~/.local_zsh_rc` — シークレット、APIキー、マシン固有の zsh 上書き（`dot_zshrc.tmpl` から読み込み）
- `~/.ssh/config.local` — マシン固有 SSH 設定（`private_dot_ssh/private_config.tmpl` で include）
- `~/.config/chezmoi/chezmoi.toml` — テンプレートデータ（上述の `extra_*` リストを含む）

これらの名前と一致するファイルはリポジトリに追加しないこと。一般的なケースは `.gitignore` で既に除外済み。
