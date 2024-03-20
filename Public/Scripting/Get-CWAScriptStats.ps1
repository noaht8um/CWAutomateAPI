function Get-CWAScriptStats {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int32]$ScriptId
    )

    $RequestParams = @{
        Endpoint = ('/v1/Statistics/ScriptInfo/' + $ScriptId)
        Method   = 'Get'
    }

    Invoke-CWAAPI @RequestParams
}
