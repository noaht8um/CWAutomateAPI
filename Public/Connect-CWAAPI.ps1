function Connect-CWAAPI {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Username,

        [Parameter(Mandatory = $true)]
        [SecureString]$Password,

        [Parameter(Mandatory = $true)]
        [string]$ClientId,

        [Parameter(Mandatory = $true)]
        [string]$Server
    )

    $Script:CWAUsername = $Username
    $Script:CWAPassword = $Password
    $Script:CWAClientID = $ClientId
    $Script:CWAServer = $Server

    $Body = @{
        Username = $Username
        Password = $Password | ConvertFrom-SecureString -AsPlainText
    }

    $RequestParams = @{
        Endpoint = '/v1/apitoken'
        Method   = 'Post'
        Body     = $Body
    }

    try {
        $Response = Invoke-CWAAPI @RequestParams
        $Script:CWAToken = $Response.AccessToken | ConvertTo-SecureString -AsPlainText
    } catch {
        Write-Error 'Unable to connect to CWA API'
    }
}
