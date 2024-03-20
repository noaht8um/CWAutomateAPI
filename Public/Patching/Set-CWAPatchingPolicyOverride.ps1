function Set-CWAPatchingPolicyOverride {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [bool]$Enable,

        [Parameter(Mandatory = $true)]
        [int32]$ComputerId
    )

    $RequestParams = @{
        Endpoint = ('/v1/Patching/Policies/Override/' + $ComputerId)
        Method   = 'Delete'
        Body     = $Body
    }

    if ($Enable) {
        # TO DO
    }

    Invoke-CWAAPI @RequestParams
}
