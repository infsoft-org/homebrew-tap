cask "locaware-cloud-edgeagent" do
  version "0.3.9"
  sha256 "94ca1e5808da8c49023984647413a7bc0bfe935222397139b3d08cc70506f46b"

  url "https://sdk.infsoft.com/macos/LocAware.Cloud.EdgeAgent.#{version}.dmg"
  name "LocAware Cloud Edge Agent"
  desc "Gives LocAware Cloud this computer's Bluetooth and infsoft positioning"
  homepage "https://locaware.cloud/"

  # The agent updates itself (Sparkle); brew upgrade leaves it alone unless --greedy
  auto_updates true
  depends_on macos: :sequoia

  app "LocAware.Cloud.EdgeAgent.app"

  uninstall quit: "com.infsoft.locaware.edgeagent"

  zap trash: "~/Library/Logs/LocAwareEdgeAgent"
end
