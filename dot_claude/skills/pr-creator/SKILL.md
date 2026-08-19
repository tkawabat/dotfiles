---
name: pr-creator
description: 現在のブランチを push して Pull Request を作成するスキル。「PR 作って」「pr作成」「PR 出して」「プルリク」「Draft PR」「push して PR」で起動
argument-hint: "[target-branch]"
allowed-tools: [Bash, Read, Grep, Glob]
---

# pr-creator

現在のブランチを GitHub に push し、Draft Pull Request を作成する。

## 実行フロー

### Step 1: 現在状態の確認

ブランチ名と未コミットの変更を確認する。

### Step 2: 変更分析

base（引数やユーザー指定があればそれ、なければ default ブランチ）から HEAD までの diff とコミットログを読み、変更の性質と影響範囲を把握する。疑問点があれば push 前にユーザー確認

### Step 3: ブランチを push

upstream 未設定で失敗した場合はユーザーに確認。

### Step 4: PR テンプレート確認

`.github/PULL_REQUEST_TEMPLATE.md` 等のテンプレートがあれば構造に従う。今回の変更に該当するセクションのみ埋め、該当しないセクションは削除せず未記入で残す。チェックボックスも同様に、対象外の項目は削除せず未チェックのまま残す。

### Step 5: Pull Request 作成

DRAFT で作成する。

```bash
gh pr create --draft --base <base> --title "<concise-title>" --body "$(cat <<'EOF'
<detailed-description>
EOF
)"
```

既存 PR がある場合はそのリンクを提示

## PR タイトル

- 命令形・72 文字以内
- 具体的に: `Update user feature` ではなく `Add email validation to user profile`
- 既存のコミット規約があれば変更種別を合わせる

## PR 本文（テンプレートがない場合）

```markdown
## Summary
[何を、なぜ変更したか]

## Changes
- [主要な変更]

## Testing
[テスト内容があれば]

## Notes
[破壊的変更・依存・重点レビュー箇所などがあれば]
```

命令形で書く。背景を知らないレビュアーにも伝わる文脈を含め、冗長な水増しはしない。関連 Issue（`fixes #123` 等）があれば明記する。
