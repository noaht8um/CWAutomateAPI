function Remove-CWAGroupMember {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$ComputerIds,

        [Parameter(Mandatory = $true)]
        [int32]$GroupId
    )

    $Body = @{
        EntityType = 'Computer'
        GroupId    = $GroupId
        EntityIds  = $ComputerIds
    }

    $RequestParams = @{
        Endpoint = '/v1/Batch/Groups/RemoveEntities'
        Method   = 'Post'
        Body     = $Body
    }

    $Response = Invoke-CWAAPI @RequestParams

    return $Response
}
