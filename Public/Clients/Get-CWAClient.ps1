function Get-CWAClient {
    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        All      = $true
        Body     = $Body
        Endpoint = '/v1/clients'
        Method   = 'Get'
    }

    Invoke-CWAAPI @RequestParams
}
