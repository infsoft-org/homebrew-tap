cask "locaware-cloud-edgeagent" do
  version "0.3.12"
  sha256 "c0df00d0897796203c31021b767d925c0acfd0b38b64ef6ae21a101a97572152"

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
