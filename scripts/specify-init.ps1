Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Bootstrap Spec Kit in an existing repo (Windows / PowerShell).
# Official docs: https://github.github.io/spec-kit/
#
# Prereqs:
# - uv (https://docs.astral.sh/uv/)
# - Python 3.11+
#
# This script is intentionally non-interactive and safe to rerun.

function Require-Command($name) {
  if (-not (Get-Command $name -ErrorAction SilentlyContinue)) {
    throw "Required command not found: $name. Install it and rerun."
  }
}

Require-Command "uv"

$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
  # One-time run without persistent install.
  # We intentionally avoid `specify init` interactive prompts here.
  Write-Host "Spec Kit (specify-cli) is available via uvx. To initialize templates, run:"
  Write-Host "  uvx --from git+https://github.com/github/spec-kit.git specify init --here --script ps --force"
  Write-Host ""
  Write-Host "Then run Spec sync to create the working feature spec:"
  Write-Host "  powershell -ExecutionPolicy Bypass -File scripts/sync-spec.ps1"
} finally {
  Pop-Location
}


