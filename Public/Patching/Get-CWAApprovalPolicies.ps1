function Get-CWAApprovalPolicies {
    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        Endpoint = '/v1/ApprovalPolicies'
        Method   = 'Get'
        Body     = $Body
    }

    Invoke-CWAAPI @RequestParams
}
