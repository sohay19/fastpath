param(
    [string]$Root = '.',
    [Alias('Snapshot')]
    [string]$SnapshotPath = 'SNAPSHOTS.md',
    [string]$PlanReadme = '',
    [string]$DetailFile = '',
    [int]$LineStart = 0,
    [int]$LineEnd = 0,
    [switch]$NoDetail,
    [switch]$Compact
)

$ErrorActionPreference = 'Stop'

function Resolve-UnderRoot([string]$RelativePath) {
    if (-not $RelativePath) { throw 'empty path' }
    $rootFull = [IO.Path]::GetFullPath((Resolve-Path -LiteralPath $Root).Path).TrimEnd('\')
    $combined = if ([IO.Path]::IsPathRooted($RelativePath)) { $RelativePath } else { Join-Path $rootFull $RelativePath }
    $full = [IO.Path]::GetFullPath($combined)
    if ($full -ne $rootFull -and -not $full.StartsWith($rootFull + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw "path escapes root: $RelativePath"
    }
    return $full
}

function Read-DocLines([string]$RelativePath) {
    Get-Content -LiteralPath (Resolve-UnderRoot $RelativePath) -Encoding UTF8
}

function Clean-FastValue([string]$Value) {
    $clean = $Value.Trim()
    $clean = $clean -replace '^\s*`', '' -replace '`\s*$', ''
    $clean = $clean -replace '^\s*"', '' -replace '"\s*$', ''
    $clean = $clean -replace "^\s*'", '' -replace "'\s*$", ''
    return $clean.Trim()
}

function Get-FastField([string[]]$Lines, [string]$Name, [switch]$Required) {
    $pattern = '^\s*-\s*' + [regex]::Escape($Name) + '\s*:\s*(.+?)\s*$'
    foreach ($line in $Lines) {
        if ($line -match $pattern) { return Clean-FastValue $Matches[1] }
    }
    if ($Required) { throw "missing Fast Path field: $Name" }
    return ''
}

function Test-FastNone([string]$Value) {
    if (-not $Value) { return $true }
    return ($Value.Trim() -match '^(none|null|n/a)(\b|[\.;,])?')
}

function Get-FastIntField([string[]]$Lines, [string]$Name) {
    $raw = Get-FastField $Lines $Name -Required
    if (Test-FastNone $raw) { throw "missing numeric Fast Path field: $Name" }
    if ($raw -notmatch '^\d+$') { throw "invalid numeric Fast Path field: ${Name}: $raw" }
    return [int]$raw
}

$snapshotLines = @(Read-DocLines $SnapshotPath)
$fastStart = [Array]::IndexOf($snapshotLines, '## Fast Path')
if ($fastStart -lt 0) { throw 'Fast Path block missing' }
$fastEnd = $snapshotLines.Count
for ($i = $fastStart + 1; $i -lt $snapshotLines.Count; $i++) {
    if ($snapshotLines[$i] -match '^##\s+') { $fastEnd = $i; break }
}
$fastBlock = @($snapshotLines[$fastStart..($fastEnd - 1)])

if (-not $PlanReadme) { $PlanReadme = Get-FastField $fastBlock 'plan_readme' -Required }
if (-not $NoDetail) {
    if (-not $DetailFile) { $DetailFile = Get-FastField $fastBlock 'detail_file' -Required }
    if (Test-FastNone $DetailFile) { throw 'detail_file is unavailable; use -NoDetail or select a current task first' }
    if ($LineStart -le 0) { $LineStart = Get-FastIntField $fastBlock 'line_start' }
    if ($LineEnd -le 0) { $LineEnd = Get-FastIntField $fastBlock 'line_end' }
    if ($LineStart -lt 1 -or $LineEnd -lt $LineStart) { throw "invalid line range: $LineStart-$LineEnd" }
}

$sourceDetail = if ($DetailFile) { $DetailFile } else { 'none' }
$sourceLines = if ($NoDetail) { 'none' } else { '{0}-{1}' -f $LineStart, $LineEnd }

Write-Output ('FASTPATH_SOURCE snapshot={0} plan_readme={1} detail_file={2} lines={3}' -f $SnapshotPath, $PlanReadme, $sourceDetail, $sourceLines)
if (-not $Compact) {
    Write-Output 'FASTPATH_BEGIN'
    $fastBlock
}
Write-Output 'PLAN_STATE_BEGIN'
$planLines = @(Read-DocLines $PlanReadme)
foreach ($pattern in @('^Completed .* tasks:', '^Current task:', '^Next task:')) {
    $line = @($planLines | Where-Object { $_ -match $pattern } | Select-Object -Last 1)
    if ($line.Count) { $line[0] }
}
if (-not $NoDetail) {
    Write-Output 'DETAIL_BEGIN'
    $detailLines = @(Read-DocLines $DetailFile)
    if ($LineEnd -gt $detailLines.Count) { throw "line_end exceeds detail file length: $LineEnd" }
    for ($lineNo = $LineStart; $lineNo -le $LineEnd; $lineNo++) {
        '{0}: {1}' -f $lineNo, $detailLines[$lineNo - 1]
    }
}
