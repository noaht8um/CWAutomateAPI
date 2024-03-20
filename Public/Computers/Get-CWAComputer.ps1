function Get-CWAComputer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [int32]$Id,

        [Parameter(Mandatory = $false)]
        [int32]$ClientId,

        [Parameter(Mandatory = $false)]
        [int32]$ContactId
    )

    # Build up condition
    $Conditions = [System.Collections.Generic.List[string]]::new()

    if ($ContactId) { $Conditions.Add('Contact.Id = ' + $ContactId) }
    if ($ClientId) { $Conditions.Add('Client.Id = ' + $ClientId) }

    $Body = @{
        pageSize = 1000
    }

    if ($Conditions.Count -gt 0) {
        $ConditionString = $Conditions -join ' AND '
        $Body.Item('condition') = $ConditionString
    }

    $RequestParams = @{
        Endpoint = '/v1/computers'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    if ($Id) {
        $RequestParams['Endpoint'] = "/computers/$Id"
        $RequestParams['All'] = $false
    }

    Invoke-CWAAPI @RequestParams
}
