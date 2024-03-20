function Update-CWAUser {
    [CmdletBinding(DefaultParameterSetName = 'Password')]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$Id,

        [Parameter(Mandatory = $true, ParameterSetName = 'Password')]
        [securestring]$Password,

        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]$Name,

        [Parameter(Mandatory = $true, ParameterSetName = 'FirstName')]
        [string]$FirstName,

        [Parameter(Mandatory = $true, ParameterSetName = 'LastName')]
        [string]$LastName,

        [Parameter(Mandatory = $true, ParameterSetName = 'EmailAddress')]
        [string]$EmailAddress
    )

    $Body = @{
        op = 'replace'
    }

    if ($Password) {
        $Body['path'] = 'Password'
        $Body['value'] = $Password | ConvertFrom-SecureString -AsPlainText
    }

    if ($Name) {
        $Body['path'] = 'Name'
        $Body['value'] = $Name
    }

    if ($FirstName) {
        $Body['path'] = 'FirstName'
        $Body['value'] = $FirstName
    }

    if ($LastName) {
        $Body['path'] = 'LastName'
        $Body['value'] = $LastName
    }

    if ($EmailAddress) {
        $Body['path'] = 'EmailAddress'
        $Body['value'] = $EmailAddress
    }

    $RequestParams = @{
        Body        = $Body
        BodyAsArray = $true
        Endpoint    = ('/v1/Users/' + $Id)
        Method      = 'Patch'
    }

    Invoke-CWAAPI @RequestParams
}
