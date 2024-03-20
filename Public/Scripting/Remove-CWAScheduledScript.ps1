function Remove-CWAScheduledScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$ScheduledScriptId
    )

    $RequestParams = @{
        Endpoint = "/v1/Scripting/ScriptSchedules/$ScheduledScriptId"
        Method   = 'Delete'
        Body     = $Body
    }

    $Response = Invoke-CWAAPI @RequestParams

    return $Response
}
