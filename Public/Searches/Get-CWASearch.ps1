function Get-CWASearch {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$Ids
    )

    $Body = @{
        pageSize = 1000
    }

    if ($Ids) { $Body.Item('ids') = ($Ids -join ',') }

    $RequestParams = @{
        Endpoint = '/v1/searches'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
