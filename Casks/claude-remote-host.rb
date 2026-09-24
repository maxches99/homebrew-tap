cask "claude-remote-host" do
  version "1.2.1"
  sha256 "f7ff580c0b4154ddb2459b1d22ce84ebc8d13cf3a9e6723cebef387736f1bcf4"

  url "https://github.com/maxches99/claude-client/releases/download/v#{version}/ClaudeRemote-Host.zip"
  name "ClaudeRemote Host"
  desc "Menu-bar host that lets the ClaudeRemote iPhone app drive Claude Code on this Mac"
  homepage "https://github.com/maxches99/claude-client"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "ClaudeRemote Host.app"

  # The build is ad-hoc signed (no Apple developer account), so Gatekeeper would refuse a quarantined copy.
  # Dropping the flag here is what `brew install --no-quarantine` would do, without asking the user.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ClaudeRemote Host.app"],
                   must_succeed: false
  end

  uninstall quit: "dev.maxches.ccremote"

  zap trash: [
    "~/Library/Application Support/ccremote",
    "~/Library/Logs/ccremote.log",
  ]
end
