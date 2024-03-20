function Invoke-CWAAPI {
    [CmdletBinding(DefaultParameterSetName = 'Endpoint')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Endpoint')]
        [string]$Endpoint,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Delete', 'Get', 'Post', 'Put', 'Patch')]
        [string]$Method,

        [Parameter(Mandatory = $false)]
        [hashtable]$Headers = @{},

        [Parameter(Mandatory = $false)]
        [object]$Body,

        [Parameter(Mandatory = $false)]
        [switch]$All,

        [Parameter(Mandatory = $false)]
        [switch]$BodyAsArray,

        [Parameter(Mandatory = $false)]
        [string]$Proxy
    )

    $BaseUri = "https://$Script:CWAServer/cwa/api"

    $Uri = ($BaseUri + $Endpoint)

    $Headers['ClientID'] = $Script:CWAClientID
    if ($Script:CWAToken) {
        $Headers['Authorization'] = "Bearer $($Script:CWAToken | ConvertFrom-SecureString -AsPlainText)"
    }

    $Request = @{
        URI     = $Uri
        Headers = $Headers
        Method  = $Method
        Body    = $Body
    }

    if ($Proxy) { $Request.Proxy = $Proxy }

    if ($Method -ne 'Get') {
        $Request.ContentType = 'application/json'
        $Request.Body = ConvertTo-Json -InputObject $Body -Depth 100 -Compress
        if ($BodyAsArray) {
            $Request.Body = ConvertTo-Json -InputObject @($Body) -Depth 100 -Compress
        }
    }

    $Response = Invoke-RestMethod @Request

    if ($All -and $Response) {
        $Response
        # Pagination
        $Page = 1
        do {
            $Page++
            $Request.Body.Item('page') = $Page
            $Response = Invoke-RestMethod @Request
            $Response
            #$AllResponses.Add($Response)
        } while ($Response)
    } else {
        $Response
    }

    # TO DO
    # Call /apitoken/refresh when API token needs a refresh
}
