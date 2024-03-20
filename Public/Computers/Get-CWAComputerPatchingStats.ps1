function Get-CWAComputerPatchingStats {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ComputerId
    )

    $RequestParams = @{
        Endpoint = ('/v1/computers/' + $ComputerId + '/PatchingStats')
        Method   = 'Get'
    }

    Invoke-CWAAPI @RequestParams
}
