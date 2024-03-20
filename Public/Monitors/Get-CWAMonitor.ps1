function Get-CWAMonitor {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [int32]$ClientId,

        [Parameter(Mandatory = $false)]
        [string]$MonitorName,

        [Parameter(Mandatory = $false)]
        [switch]$RemoteMonitors
    )

    # Build up condition
    $Conditions = [System.Collections.Generic.List[string]]::new()
    if ($RemoteMonitors) { $Conditions.Add('IsInternalMonitor = False') }
    if ($ClientId) { $Conditions.Add('AffectedEntities.RemoteMonitorAffectedClient.Id IN (' + $ClientId + ')') }
    if ($MonitorName) { $Conditions.Add('Name = "' + $MonitorName + '"') }

    $ConditionString = $Conditions -join ' AND '

    $Body = @{
        pageSize  = 1000
        condition = $ConditionString
    }

    $RequestParams = @{
        Endpoint = '/v1/monitors'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
