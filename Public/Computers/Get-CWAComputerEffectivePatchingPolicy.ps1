function Get-CWAComputerEffectivePatchingPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ComputerId
    )

    $RequestParams = @{
        Endpoint = ('/v1/computers/' + $ComputerId + '/EffectivePatchingPolicy')
        Method   = 'Get'
    }

    Invoke-CWAAPI @RequestParams
}
