cask "libertty" do
  version "0.7.0"
  sha256 "252bb1a3c99bfb7728db70e7a9abe5706dfdd1cb1e20d06ce903d01aff4ee187"

  url "https://github.com/ziwangprincex/Libertty/releases/download/v#{version}/Libertty-#{version}.zip"
  name "Libertty"
  desc "Native terminal emulator built on libghostty-vt"
  homepage "https://github.com/ziwangprincex/Libertty"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Libertty updates itself (Libertty ▸ Check for Updates), with signed updates.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Libertty.app"
  binary "#{appdir}/Libertty.app/Contents/Resources/bin/libertty"

  # Not notarized (signed with Libertty's own certificate): Gatekeeper would
  # refuse to open it (if this can't be done, macOS asks once, as for the DMG).
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Libertty.app"], must_succeed: false
  end

  uninstall quit: "dev.libertty.terminal"

  zap trash: [
    "~/.config/libertty",
    "~/Library/Application Support/Libertty",
    "~/Library/Caches/dev.libertty.terminal",
    "~/Library/HTTPStorages/dev.libertty.terminal",
    "~/Library/Logs/Libertty",
    "~/Library/Preferences/dev.libertty.terminal.plist",
    "~/Library/Saved Application State/dev.libertty.terminal.savedState",
    "~/Library/WebKit/dev.libertty.terminal",
  ]
end
