cask "libertty" do
  version "0.3.0"
  sha256 "9fd3e10669eb56ebcf67b10608edf39f60e9b47efd97a20109243bac50779f83"

  url "https://github.com/ziwangprincex/libertty/releases/download/v#{version}/Libertty-#{version}.zip"
  name "Libertty"
  desc "Fast native terminal built on libghostty-vt"
  homepage "https://github.com/ziwangprincex/libertty"

  # Libertty updates itself (Libertty ▸ Check for Updates), with signed updates.
  auto_updates true
  depends_on macos: ">= :sonoma"

  app "Libertty.app"
  binary "#{appdir}/Libertty.app/Contents/Resources/bin/libertty"

  # Ad-hoc signed, not notarized: Gatekeeper would refuse to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Libertty.app"]
  end

  uninstall quit: "dev.libertty.terminal"

  zap trash: [
    "~/.config/libertty",
    "~/Library/Application Support/Libertty",
    "~/Library/Caches/dev.libertty.terminal",
    "~/Library/Logs/Libertty",
    "~/Library/Preferences/dev.libertty.terminal.plist",
  ]
end
