function Update-CWADeploymentLogin {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$Id,

        [Parameter(Mandatory = $true)]
        [int32]$ClientId,

        [Parameter(Mandatory = $false)]
        [securestring]$Password,

        [Parameter(Mandatory = $false)]
        [int32]$LocationId,

        [Parameter(Mandatory = $false)]
        [string]$Notes,

        [Parameter(Mandatory = $false)]
        [string]$Title,

        [Parameter(Mandatory = $false)]
        [string]$Url,

        [Parameter(Mandatory = $false)]
        [string]$Username
    )

    $Existing = Get-CWADeploymentLogin -ClientId $ClientId -Id $Id -WithPassword

    $Body = @{
        DeploymentLoginId = $Id
        Client            = @{ ClientId = $ClientId }
        Password          = $Existing.Password
        Location          = @{ LocationId = $Existing.Location.LocationId }
        Notes             = $Existing.Notes
        Title             = $Existing.Title
        Url               = $Existing.Url
        Username          = $Existing.Username
    }

    if ($Password) { $Body['Password'] = (ConvertFrom-SecureString -SecureString $Password -AsPlainText) }
    if ($LocationId) { $Body.Location['LocationId'] = $LocationId }
    if ($Notes) { $Body['Notes'] = $Notes }
    if ($Title) { $Body['Title'] = $Title }
    if ($Url) { $Body['Url'] = $Url }
    if ($Username) { $Body['Username'] = $Username }

    $RequestParams = @{
        Endpoint = ('/v1/clients/' + $ClientId + '/deploymentlogins/' + $Id)
        Method         = 'Put'
        Body           = $Body
    }

    Invoke-CWAAPI @RequestParams
}
