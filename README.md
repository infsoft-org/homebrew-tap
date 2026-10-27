# infsoft Homebrew tap

Homebrew casks for infsoft software on macOS.

```sh
brew tap infsoft-org/tap
```

| Name | What it is | Install |
| --- | --- | --- |
| LocAware Cloud Edge Agent | Menu bar app: LocAware Cloud's way to the Mac's positioning and Bluetooth | `brew install --cask infsoft-org/tap/locaware-cloud-edgeagent` |

Update everything with `brew upgrade`, remove one with `brew uninstall --cask <name>` (`--zap` also removes its files).

## LocAware Cloud Edge Agent

Gives [LocAware Cloud](https://locaware.cloud/) what a web page cannot reach on your Mac: your position from infsoft's
indoor and outdoor positioning, and the Mac's Bluetooth - for example to send as a beacon in LocAware Cloud's Beacon
Simulator. It answers only LocAware Cloud pages, only on this Mac (127.0.0.1), and runs only while a page asks.

```sh
brew install --cask infsoft-org/tap/locaware-cloud-edgeagent
```

- macOS 15 (Sequoia) or later, Apple silicon or Intel
- Direct download: <https://sdk.infsoft.com/macos/LocAware.Cloud.EdgeAgent.dmg>

## About this repository

The casks in `Casks/` are written by the workflow "Update casks" (`.github/workflows/update-casks.yml`) - please do not
edit them by hand. Every hour it reads the manifest each app's release publishes next to its download, checks the
download against the manifest's sha256 and renders the cask from its template in `.github/cask-templates/`. A new app
is a template whose first line names its manifest (`# manifest: <url>`). For questions, contact infsoft support.

## License

The files contained in this repository are licensed under the MIT License (`LICENSE`).

The casks in this repository install proprietary applications that are distributed separately and are not licensed
under the terms of this repository.

Use of these applications requires a valid purchased license. For the LocAware Cloud Edge Agent, the license is part of
LocAware Cloud, which provides the API key the agent needs.

Unauthorized use or distribution of these applications is prohibited.

For licensing, purchase requests, or additional information, contact [contact@infsoft.com](mailto:contact@infsoft.com).
