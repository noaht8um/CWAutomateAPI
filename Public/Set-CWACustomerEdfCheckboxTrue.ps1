function Set-CWACustomerEdfCheckboxTrue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ClientId,

        [Parameter(Mandatory = $true)]
        [int32]$EdfId
    )
    $body = @{
        op    = 'replace'
        path  = '/CheckboxSettings/IsChecked'
        value = $true
    }

    ConvertTo-Json $body

    Invoke-CWAAPI -endpoint "clients/$ClientId/extrafields/$EdfId" -method 'PATCH' -body $body | Out-Null
}
