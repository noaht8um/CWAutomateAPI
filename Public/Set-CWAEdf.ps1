function Set-CWAEdf {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$EdfId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ClientCheckbox')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ClientDropdown')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ClientTextField')]
        [int32]$ClientId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerCheckbox')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerDropdown')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerTextField')]
        [int32]$ComputerId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ContactCheckbox')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ContactDropdown')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ContactTextField')]
        [int32]$ContactId,

        [Parameter(Mandatory = $true, ParameterSetName = 'LocationCheckbox')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LocationDropdown')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LocationTextField')]
        [int32]$LocationId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ClientCheckbox')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerCheckbox')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ContactCheckbox')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LocationCheckbox')]
        [ValidateSet('Checked', 'Unchecked')]
        [string]$Checkbox,

        [Parameter(Mandatory = $true, ParameterSetName = 'ClientDropdown')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerDropdown')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ContactDropdown')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LocationDropdown')]
        [string]$Dropdown,

        [Parameter(Mandatory = $true, ParameterSetName = 'ClientTextField')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerTextField')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ContactTextField')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LocationTextField')]
        [string]$TextField
    )

    $RequestParams = @{
        'Method'      = 'Patch'
        'BodyAsArray' = $true
    }

    if ($ClientId) {
        $RequestParams['Endpoint'] = ('/v1/clients/' + $ClientId + '/extrafields/' + $EdfId)
    }

    if ($ComputerId) {
        $RequestParams['Endpoint'] = ('/v1/computers/' + $ComputerId + '/extrafields/' + $EdfId)
    }

    if ($ContactId) {
        $RequestParams['Endpoint'] = ('/v1/contacts/' + $ContactId + '/extrafields/' + $EdfId)
    }

    if ($LocationId) {
        $RequestParams['Endpoint'] = ('/v1/locations/' + $LocationId + '/extrafields/' + $EdfId)
    }


    if ($Checkbox) {
        if ($Checkbox -eq 'Checked') { $Value = $true } else { $Value = $false }
        $RequestParams.Item('Body') = @{
            op    = 'replace'
            path  = '/CheckboxSettings/IsChecked'
            value = $Value
        }
    }

    if ($TextField) {
        $RequestParams.Item('Body') = @{
            op    = 'replace'
            path  = '/textFieldSettings/value'
            value = $TextField
        }
    }

    # TO DO
    #if ($Dropdown) {
    #    $RequestParams.Item('Body') = @{
    #        op    = 'replace'
    #        path  = '/CheckboxSettings/IsChecked'
    #        value = $false
    #    }
    #}

    Invoke-CWAAPI @RequestParams
}
