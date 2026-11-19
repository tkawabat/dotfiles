#!/usr/bin/env python3
"""
excludedCommands のコマンドをほかのコマンドとつなぐと、
excludedCommands に当てはまらなくなり、サンドボックスの中で動いて失敗する。
AI はつなぎがちで CLAUDE.md の注意だけでは防げないので、実行前に止める。
"""

import fnmatch
import json
import os
import shlex
import sys

SEPARATORS = {"&&", "||", ";", "&", "\n", ";;"}


def load_patterns(cwd: str) -> list[str]:
    dirs = {os.environ.get("CLAUDE_PROJECT_DIR", ""), cwd}
    paths = [os.path.expanduser("~/.claude/settings.json")]
    for d in filter(None, dirs):
        paths += [
            os.path.join(d, ".claude", "settings.json"),
            os.path.join(d, ".claude", "settings.local.json"),
        ]
    patterns: list[str] = []
    for p in paths:
        try:
            with open(p) as f:
                patterns += json.load(f).get("sandbox", {}).get("excludedCommands", [])
        except (OSError, ValueError, AttributeError):
            continue
    return patterns


def split_segments(command: str) -> list[list[str]]:
    lexer = shlex.shlex(command, posix=True, punctuation_chars=";&|\n")
    lexer.whitespace = " \t\r"
    lexer.whitespace_split = True
    segments: list[list[str]] = [[]]
    for token in lexer:
        if token in SEPARATORS:
            segments.append([])
        else:
            segments[-1].append(token)
    return [s for s in segments if s]


def first_command(segment: list[str]) -> str:
    words: list[str] = []
    for token in segment:
        if token in {"|", "|&", "||"}:
            break
        words.append(token)
    return " ".join(words)


def is_excluded(command: str, patterns: list[str]) -> bool:
    for pattern in patterns:
        # "git *" は引数なしの "git" 単体にも当てはめるため、末尾の " *" を外して前方一致でも見る。
        if pattern.endswith(" *"):
            prefix = pattern[:-2]
            if command == prefix or command.startswith(prefix + " "):
                return True
        if fnmatch.fnmatchcase(command, pattern):
            return True
    return False


def main() -> int:
    try:
        payload = json.load(sys.stdin)
        command = payload["tool_input"]["command"]
        segments = split_segments(command)
    except (ValueError, KeyError, TypeError):
        return 0

    if len(segments) < 2:
        return 0

    patterns = load_patterns(payload.get("cwd", ""))
    if not patterns:
        return 0

    commands = [first_command(s) for s in segments]
    excluded = [c for c in commands if is_excluded(c, patterns)]
    if not excluded or len(excluded) == len(commands):
        return 0

    names = sorted({c.split(" ", 1)[0] for c in excluded})
    print(
        f"{' / '.join(names)} は sandbox.excludedCommands のコマンドなので、"
        "ほかのコマンドと &&・||・; でつながず、単独の Bash 呼び出しで実行してください。"
        "つなぐとサンドボックスの中で動いて失敗します。"
        "ディレクトリは cd ではなく git -C <dir> / pnpm -C <dir> / gh -R <owner/repo> などで指定してください。",
        file=sys.stderr,
    )
    return 2


if __name__ == "__main__":
    sys.exit(main())
