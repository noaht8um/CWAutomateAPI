function Get-CWAPatchingPolicyOverrides {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [switch]$WithComputers
    )

    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        Endpoint = '/v1/Patching/Policies/Override'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    $Response = Invoke-CWAAPI @RequestParams

    if ($WithComputers) {
        return Get-CWAComputer | Where-Object { $_.Id -in $Response.ComputerId }
    }

    return $Response
}
