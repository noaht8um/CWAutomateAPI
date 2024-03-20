function Get-CWAEdf {
    [CmdletBinding(DefaultParameterSetName = 'Client')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerAll')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerValue')]
        [int32]$ComputerId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ClientAll')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ClientValue')]
        [int32]$ClientId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ContactAll')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ContactValue')]
        [int32]$ContactId,

        [Parameter(Mandatory = $true, ParameterSetName = 'LocationAll')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LocationValue')]
        [int32]$LocationId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ComputerValue')]
        [Parameter(Mandatory = $true, ParameterSetName = 'LocationValue')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ClientValue')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ContactValue')]
        [int32]$EdfId
    )

    $RequestParams = @{
        Method = 'Get'
    }

    if ($ComputerId) {
        $RequestParams['Endpoint'] = ('/v1/computers/' + $ComputerId + '/extrafields')
    }

    if ($LocationId) {
        $RequestParams['Endpoint'] = ('/v1/locations/' + $LocationId + '/extrafields')
    }

    if ($ClientId) {
        $RequestParams['Endpoint'] = ('/v1/clients/' + $ClientId + '/extrafields')
    }

    if ($ContactId) {
        $RequestParams['Endpoint'] = ('/v1/contacts/' + $ContactId + '/extrafields')
    }


    $Response = Invoke-CWAAPI @RequestParams

    if ($EdfId) {
        $Edf = $Response | Where-Object { $_.ExtraFieldDefinitionId -eq $EdfId }
        Write-Debug ('EDF Title: ' + $Edf.Title)
        if ($Edf.CheckboxSettings) {
            return $Edf.CheckboxSettings.IsChecked
}
        if ($Edf.TextFieldSettings) {
            return $Edf.TextFieldSettings.Value
        }
        if ($Edf.DropdownSettings) {
            return $Edf.DropdownSettings.SelectedValue
        }
    }

    return $Response
}
