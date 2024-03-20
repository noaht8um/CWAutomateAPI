function ConvertFrom-CWABase64Object {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Base64
    )
    $Bytes = [System.Convert]::FromBase64String($Base64)
    $String = [System.Text.Encoding]::UTF8.GetString($Bytes)
    $Object = [System.Management.Automation.PSSerializer]::Deserialize(($String -replace "`0", ''))
    $Object
}
