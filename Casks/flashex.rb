cask "flashex" do
  # version and sha256 are written by scripts/update-cask.sh from dist/<version>/
  # in the (private) source repository; do not edit them by hand.
  version "0.1.3"
  sha256 "b7ae97a1a92ef269e751f41e147a76203e8138e94cb07620a300d2149bbd6346"

  url "https://github.com/palo-kunovsky-flash/flashex-app/releases/download/v#{version}/Flashex-#{version}.dmg"
  name "Flashex"
  desc "Fast terminal built for AI coding agents"
  homepage "https://github.com/palo-kunovsky-flash/flashex-app"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Flashex updates itself (signed updates, see the app's README).
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Flashex.app"
  # The `flashex` command (agent hooks, notifications, splits from scripts).
  binary "#{appdir}/Flashex.app/Contents/MacOS/flashex"

  # Flashex is ad-hoc signed, not notarized (no paid Apple Developer ID), so
  # Gatekeeper would block the first open of a quarantined copy. Homebrew has
  # already checked the dmg against the sha256 above when this runs.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Flashex.app"]
  end

  zap trash: [
    "~/.config/flashex",
    "~/Library/Application Support/flashex",
    "~/Library/Caches/flashex",
    "~/Library/Logs/flashex",
    "~/Library/Preferences/dev.flashex.app.plist",
    "~/Library/Saved Application State/dev.flashex.app.savedState",
  ]
end
