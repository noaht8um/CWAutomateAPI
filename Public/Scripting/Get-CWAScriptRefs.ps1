function Get-CWAScriptRefs {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int32]$ScriptId
    )

    $RequestParams = @{
        Endpoint = ('/v1/Scripts/' + $ScriptId + '/References')
        Method   = 'Get'
    }

    Invoke-CWAAPI @RequestParams
}
