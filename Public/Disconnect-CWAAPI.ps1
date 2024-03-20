function Disconnect-CWAAPI {
    $Body = @{
        SecurityToken = $Script:CWAToken | ConvertFrom-SecureString -AsPlainText
    }
    $Body = $Body | ConvertTo-Json

    $ContentType = 'application/json'

    $Headers = @{
        Authorization = "Bearer $($Script:CWAToken | ConvertFrom-SecureString -AsPlainText)"
        ClientID      = $Script:CWAClientID
    }

    $Method = 'Post'

    $Uri = "https://$Server/cwa/api/v1/ApiToken/Disable"

    $RESTRequest = @{
        Body        = $Body
        ContentType = $ContentType
        Headers     = $Headers
        Method      = $Method
        URI         = $Uri
    }

    try {
        Invoke-RestMethod @RESTRequest
    } catch {
        Write-Host 'Error disconnecting from the API'
        Write-Error $_.Exception.Message
    }
}
