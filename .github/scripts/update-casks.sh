#!/bin/bash
# Renders Casks/<name>.rb from .github/cask-templates/<name>.rb with the version and sha256 of the newest release.
#
# Each template names its release manifest in its first line (`# manifest: <url>`): a JSON file the app's release
# pipeline publishes next to its download, {"version": "1.2.3", "sha256": "<64 hex>", "url": "<the versioned file>"}.
# A cask changes only when the manifest names another version or checksum, the file at its url has that checksum, and
# that url is the one the template builds for the version - so a manifest can never point a cask anywhere else.
#
# Writes the commit message to $1 when something changed.
set -euo pipefail
cd "$(dirname "$0")/../.."
message_file=${1:-/dev/null}
changed=()
failed=0

fail() {
  echo "::error file=$template::$cask: $1"
  failed=1
}

for template in .github/cask-templates/*.rb; do
  cask=$(basename "$template" .rb)
  target="Casks/$cask.rb"
  manifest=$(sed -n '1s/^# manifest: //p' "$template")
  if [[ -z $manifest ]]; then fail "the first line names no manifest"; continue; fi

  # The query keeps a CDN from answering with an older manifest
  if ! json=$(curl -fsSL --retry 3 "$manifest?t=$(date +%s)"); then
    if [[ -f $target ]]; then fail "$manifest did not answer"; else echo "$cask: not released yet"; fi
    continue
  fi
  version=$(jq -r '.version // empty' <<< "$json")
  sha256=$(jq -r '.sha256 // empty' <<< "$json")
  url=$(jq -r '.url // empty' <<< "$json")
  # Both go into a Ruby file: only what a version and a checksum can be
  if ! [[ $version =~ ^[0-9]+(\.[0-9]+)*$ ]]; then fail "manifest version '$version' is not a version"; continue; fi
  if ! [[ $sha256 =~ ^[0-9a-f]{64}$ ]]; then fail "manifest sha256 '$sha256' is not a sha256"; continue; fi

  current_version=$(sed -n 's/^  version "\(.*\)"$/\1/p' "$target" 2>/dev/null || true)
  current_sha256=$(sed -n 's/^  sha256 "\(.*\)"$/\1/p' "$target" 2>/dev/null || true)
  if [[ $current_version == "$version" && $current_sha256 == "$sha256" ]]; then
    echo "$cask: $version is current"
    continue
  fi

  expected_url=$(sed -n 's/^  url "\(.*\)"$/\1/p' "$template")
  expected_url=${expected_url//'#{version}'/$version}
  if [[ $url != "$expected_url" ]]; then fail "manifest url $url is not $expected_url"; continue; fi

  download=$(mktemp)
  if ! curl -fsSL --retry 3 -o "$download" "$url"; then fail "$url did not download"; rm -f "$download"; continue; fi
  actual=$(sha256sum "$download" | cut -d' ' -f1)
  rm -f "$download"
  if [[ $actual != "$sha256" ]]; then fail "$url has sha256 $actual, the manifest says $sha256"; continue; fi

  mkdir -p Casks
  sed -e '1d' -e "s/__VERSION__/$version/" -e "s/__SHA256__/$sha256/" "$template" > "$target"
  ruby -c "$target" > /dev/null
  echo "$cask: ${current_version:-new} -> $version"
  changed+=("$cask $version")
done

if (( ${#changed[@]} )); then
  { printf '%s' "${changed[0]}"; (( ${#changed[@]} > 1 )) && printf ', %s' "${changed[@]:1}"; echo; } > "$message_file"
fi
exit $failed
