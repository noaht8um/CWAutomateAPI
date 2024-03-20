function Add-CWAGroupMember {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$ComputerIds,

        [Parameter(Mandatory = $true)]
        [string]$GroupId
    )

    $Body = @{
        EntityType = 1
        TargetType = 7
        TargetId   = $GroupId
        EntityIds  = $ComputerIds
    }

    $RequestParams = @{
        Endpoint = '/v1/Batch/Commands/SendTo'
        Method   = 'Post'
        Body     = $Body
    }

    $Response = Invoke-CWAAPI @RequestParams

    return $Response
}
