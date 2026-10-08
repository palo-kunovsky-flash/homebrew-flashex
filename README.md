# Homebrew tap for Flashex

[Flashex](https://github.com/palo-kunovsky-flash/flashex-app) is a fast macOS terminal built for AI coding agents.

```sh
brew install --cask palo-kunovsky-flash/flashex/flashex
```

That is the same as `brew tap palo-kunovsky-flash/flashex` followed by `brew install --cask flashex`.

- **Requires** an Apple Silicon Mac and macOS 13 Ventura or later.
- **Installs** `Flashex.app` into `/Applications` and links the `flashex` command (from inside the app bundle) into Homebrew's `bin`.
- **Updates:** Flashex updates itself and verifies each update with its own signature, so the cask is marked `auto_updates`. `brew upgrade --cask --greedy flashex` updates through Homebrew instead.
- **Uninstall:** `brew uninstall --cask flashex`. `brew uninstall --zap --cask flashex` also removes settings, session, logs and caches (`~/.config/flashex`, `~/Library/Application Support/flashex`, `~/Library/Logs/flashex`, `~/Library/Caches/flashex`).

## Why the cask removes the quarantine flag

Flashex is free and is not notarized by Apple: it has no paid Apple Developer ID, only an ad-hoc signature. Gatekeeper would therefore refuse to open a freshly downloaded copy until you confirm it once by hand. To spare you that step, the cask's `postflight` runs

```sh
xattr -dr com.apple.quarantine /Applications/Flashex.app
```

after Homebrew has downloaded the dmg from the official GitHub release and checked its SHA-256 against the one in the cask. Removing the quarantine flag is not allowed in the official `homebrew/cask` repository, and `brew audit` may warn about it. It is fine in a personal tap like this one, and it is the reason this tap exists. If you prefer Gatekeeper to ask, install the dmg by hand from [Releases](https://github.com/palo-kunovsky-flash/flashex-app/releases) instead.

## Maintenance

`Casks/flashex.rb` is generated from the release files: `version` and `sha256` are filled in by the release scripts of the (private) source repository, and `livecheck` follows the latest GitHub release of `flashex-app`. Please report problems in [flashex-app issues](https://github.com/palo-kunovsky-flash/flashex-app/issues).
