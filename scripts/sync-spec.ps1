Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Spec.md is the SSOT.
# This script syncs it into the Spec Kit feature spec directory so Spec-driven workflows
# can operate on a canonical `spec.md` file while keeping `Spec.md` as the source of truth.

$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root "Spec.md"
$featureDir = Join-Path $root ".specify\specs\000-apd"
$dest = Join-Path $featureDir "spec.md"

if (-not (Test-Path $source)) {
  throw "Spec.md not found at: $source"
}

New-Item -ItemType Directory -Force -Path $featureDir | Out-Null

$header = @"
<!--
GENERATED FILE — DO NOT EDIT.
SSOT: /Spec.md
Run: powershell -ExecutionPolicy Bypass -File scripts/sync-spec.ps1
-->

"@

$content = Get-Content -Path $source -Raw -Encoding UTF8
Set-Content -Path $dest -Value ($header + $content) -Encoding UTF8

Write-Host "Synced SSOT Spec.md -> $dest"


