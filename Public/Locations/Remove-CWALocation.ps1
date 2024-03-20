function Remove-CWALocation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$Id
    )

    $RequestParams = @{
        Endpoint = ('/v1/locations/' + $Id)
        Method   = 'Delete'
    }

    Invoke-CWAAPI @RequestParams
}
