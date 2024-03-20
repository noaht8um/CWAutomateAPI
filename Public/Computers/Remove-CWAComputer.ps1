function Remove-CWAComputer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ComputerId
    )

    $RequestParams = @{
        Endpoint = ('/v1/computers/' + $ComputerId)
        Method   = 'Delete'
    }

    Invoke-CWAAPI @RequestParams
}
