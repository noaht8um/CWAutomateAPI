function Get-CWAInternalMonitorResults {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$MonitorName
    )

    # Build up condition
    $Conditions = [System.Collections.Generic.List[string]]::new()
    $Conditions.Add('Name like "%' + $MonitorName + '%"')

    $ConditionString = $Conditions -join ' AND '

    $Body = @{
        'pageSize'  = 1000
        'condition' = $ConditionString
    }

    $RequestParams = @{
        Endpoint = '/v1/InternalMonitorResults'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
