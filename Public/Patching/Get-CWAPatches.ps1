function Get-CWAPatches {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ApprovalPolicyId
    )

    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        Endpoint = ('/v1/Patching/Policies/Approval/' + $ApprovalPolicyId + '/Patches/Microsoft')
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    Invoke-CWAAPI @RequestParams
}
