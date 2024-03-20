function Get-CWAScheduledScript {
    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        Endpoint = '/v1/Scripting/ScriptSchedules'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
