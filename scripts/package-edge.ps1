$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content -LiteralPath (Join-Path $projectRoot 'manifest.json') -Raw | ConvertFrom-Json
if ($manifest.manifest_version -ne 3) {
    throw 'Expected a Manifest V3 extension.'
}
if ($manifest.PSObject.Properties.Name -contains 'update_url') {
    throw 'Remove update_url before packaging for Microsoft Edge Add-ons.'
}
if ($manifest.version -notmatch '^\d+(\.\d+){0,3}$') {
    throw 'Invalid extension version.'
}

$files = @('manifest.json', 'popup.html', 'scripts/popup.js', 'scripts/content.js', 'LICENSE')
$files += $manifest.icons.PSObject.Properties.Value
$files = $files | Sort-Object -Unique
foreach ($file in $files) {
    if (-not (Test-Path -LiteralPath (Join-Path $projectRoot $file) -PathType Leaf)) {
        throw "Missing package file: $file"
    }
}

$outputDirectory = Join-Path $projectRoot 'dist'
New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
$outputPath = Join-Path $outputDirectory "auto-scroll-edge-$($manifest.version).zip"
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$stream = [System.IO.File]::Open($outputPath, [System.IO.FileMode]::Create)
try {
    $archive = New-Object System.IO.Compression.ZipArchive($stream, [System.IO.Compression.ZipArchiveMode]::Create, $true)
    try {
        foreach ($file in $files) {
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $archive, (Join-Path $projectRoot $file), $file.Replace('\', '/'),
                [System.IO.Compression.CompressionLevel]::Optimal
            ) | Out-Null
        }
    } finally {
        $archive.Dispose()
    }
} finally {
    $stream.Dispose()
}
Write-Output "Created $outputPath"
