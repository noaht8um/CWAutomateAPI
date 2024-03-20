function Remove-CWAScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$ScriptIds
    )

    $Body = @{
        ScriptIds = $ScriptIds
    }

    $RequestParams = @{
        Endpoint = '/v1/Batch/Scripting/Delete'
        Method   = 'Post'
        Body     = $Body
    }

    $Response = Invoke-CWAAPI @RequestParams

    return $Response
}
