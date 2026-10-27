# manifest: https://sdk.infsoft.com/macos/LocAware.Cloud.EdgeAgent.json
cask "locaware-cloud-edgeagent" do
  version "__VERSION__"
  sha256 "__SHA256__"

  url "https://sdk.infsoft.com/macos/LocAware.Cloud.EdgeAgent.#{version}.dmg"
  name "LocAware Cloud - EdgeAgent"
  desc "Gives LocAware Cloud this computer's Bluetooth and infsoft positioning"
  homepage "https://locaware.cloud/"

  # The agent updates itself (Sparkle); brew upgrade leaves it alone unless --greedy
  auto_updates true
  depends_on macos: :sequoia

  app "LocAware Cloud - EdgeAgent.app"

  uninstall quit: "com.infsoft.locaware.edgeagent"

  zap trash: "~/Library/Logs/LocAwareEdgeAgent"
end
