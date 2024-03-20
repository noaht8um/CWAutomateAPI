function Get-CWAGroupMember {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$GroupId
    )

    $Body = @{
        pageSize = 1000
    }

    $RequestParams = @{
        Endpoint = ('/v2/groups/' + $GroupId + '/computers')
        Method         = 'Get'
        Body           = $Body
        All            = $true
    }

    Invoke-CWAAPI @RequestParams
}
