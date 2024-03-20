function Get-CWAUser {
    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        All      = $true
        Body     = $Body
        Endpoint = ('/v1/Users')
        Method   = 'Get'
    }

    Invoke-CWAAPI @RequestParams
}
