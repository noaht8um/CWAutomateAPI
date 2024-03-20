$Public = @(Get-ChildItem -Recurse -Path $PSScriptRoot\Public\*.ps1)
$Private = @(Get-ChildItem -Recurse -Path $PSScriptRoot\Private\*.ps1)

foreach ($import in @($Public + $Private)) {
    try {
        . $import.FullName
    } catch {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}
