function Get-CWAScript {
    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        Endpoint = '/v1/Scripts'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
