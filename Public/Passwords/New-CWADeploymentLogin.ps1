function New-CWADeploymentLogin {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ClientId,

        [Parameter(Mandatory = $true)]
        [securestring]$Password,

        [Parameter(Mandatory = $false)]
        [int32]$LocationId,

        [Parameter(Mandatory = $false)]
        [string]$Notes,

        [Parameter(Mandatory = $true)]
        [string]$Title,

        [Parameter(Mandatory = $false)]
        [string]$Url,

        [Parameter(Mandatory = $true)]
        [string]$Username
    )

    $Body = @{
        Client   = @{ ClientId = $ClientId }
        Password = (ConvertFrom-SecureString -SecureString $Password -AsPlainText)
        Title    = $Title
        Username = $Username
    }

    if ($LocationId) { $Body.Location['LocationId'] = $LocationId }
    if ($Notes) { $Body['Notes'] = $Notes }
    if ($Url) { $Body['Url'] = $Url }

    $RequestParams = @{
        Endpoint = ('/v1/clients/' + $ClientId + '/deploymentlogins')
        Method         = 'Post'
        Body           = $Body
    }

    Invoke-CWAAPI @RequestParams
}
