function Get-CWAContact {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [int32]$ClientId
    )

    # Build up condition
    $Conditions = [System.Collections.Generic.List[string]]::new()

    if ($ClientId) { $Conditions.Add('Client.ClientId = ' + $ClientId) }

    $Body = @{
        pageSize = 1000
    }

    if ($Conditions.Count -gt 0) {
        $ConditionString = $Conditions -join ' AND '
        $Body.Item('condition') = $ConditionString
    }

    $RequestParams = @{
        Endpoint = '/v2/Contacts'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
