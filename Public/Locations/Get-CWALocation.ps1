function Get-CWALocation {
    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        Endpoint = '/v1/locations'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
