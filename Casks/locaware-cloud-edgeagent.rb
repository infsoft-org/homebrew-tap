cask "locaware-cloud-edgeagent" do
  version "0.3.11"
  sha256 "ef8186ad5962742c4ef3d16a0eb9f34e966d496843c1e5b48b227d6262a3fc6b"

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
