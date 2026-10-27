cask "libertty" do
  version "0.3.9"
  sha256 "9965dbe88fe85f83886e05efc9510e7591fce761c840c987afd0a940501de76a"

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

  # Ad-hoc signed, not notarized: Gatekeeper would refuse to open it (if
  # this can't be done, macOS asks once, as for the DMG).
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
