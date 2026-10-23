cask "claude-remote-host" do
  version "1.7.0"
  sha256 "85a969dea46abad34fed854437c7a5b53c452a822640a00da5bf35280b35fa9a"

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
