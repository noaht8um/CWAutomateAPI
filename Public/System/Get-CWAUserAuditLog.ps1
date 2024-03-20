function Get-CWAUserAuditLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [datetime]$AfterDate
    )

    $Body = @{
        pageSize = 1000
        orderBy  = 'id desc'
    }

    $RequestParams = @{
        Endpoint = '/v1/useraudits'
        Method   = 'Get'
        Body     = $Body
    }

    $Response = Invoke-CWAAPI @RequestParams

    if ($AfterDate) {
        if ($Response) {
            $Page = 2
            $CombinedResponse += $Response
            while ($Response | Where-Object { $_.DateCreated -gt $AfterDate }) {
                $RequestParams.Body.Item('page') = $Page
                $Response = Invoke-CWAAPI @RequestParams
                $CombinedResponse += $Response
                $Page++
            }
            return ($CombinedResponse | Where-Object { $_.DateCreated -gt $AfterDate } | Sort-Object -Property Id)
        }
    }

    return $Response
}
