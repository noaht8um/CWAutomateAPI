function Set-CWACustomerEdfCheckboxFalse {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ClientId,

        [Parameter(Mandatory = $true)]
        [int32]$EdfId
    )
    $Body = @{
        op    = 'replace'
        path  = '/CheckboxSettings/IsChecked'
        value = $false
    }

    $RequestParams = @{
        Endpoint = ('/v1/clients/' + $ClientId + '/extrafields/' + $EdfId)
        Method   = 'Patch'
        Body     = $Body
    }

    Invoke-CWAAPI @RequestParams
}
