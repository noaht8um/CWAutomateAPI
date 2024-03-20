function Add-CWAContact {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$FirstName,
        [Parameter(Mandatory)]
        [string]$LastName,
        [Parameter(Mandatory)]
        [string]$EmailAddress,
        [Parameter(Mandatory)]
        [hashtable]$Client
    )

    $Body = @{
        FirstName    = $FirstName
        LastName     = $LastName
        EmailAddress = $EmailAddress
        Client       = $Client
        IsManaged    = $false
        IsActivated  = $false
        Password     = ('!@#$%^&*0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz'.tochararray() | Sort-Object { Get-Random })[0..31] -join ''
    }

    $RequestParams = @{
        Endpoint = ('/v2/Contacts')
        Method         = 'Post'
        Body           = $Body
    }

    $RequestParams | ConvertTo-Json -Depth 100

    Invoke-CWAAPI @RequestParams
}
