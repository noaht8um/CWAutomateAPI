function Update-CWAToken {
    $RequestParams = @{
        Endpoint = '/v1/apitoken/refresh'
        Method   = 'Post'
        Body     = $Script:CWAToken | ConvertFrom-SecureString -AsPlainText
    }

    $Response = Invoke-CWAAPI @RequestParams

    $Script:CWAToken = $Response.AccessToken | ConvertTo-SecureString -AsPlainText

}