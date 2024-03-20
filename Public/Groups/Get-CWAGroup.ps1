function Get-CWAGroup {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'WithComputers')]
        [Parameter(Mandatory = $false)]
        [int32]$Id,

        [Parameter(Mandatory = $false)]
        [int[]]$Ids,

        [Parameter(Mandatory = $false, ParameterSetName = 'WithComputers')]
        [Parameter(Mandatory = $false)]
        [switch]$WithComputers
    )

    $Body = @{
        pageSize = 1000
    }

    if ($Ids) { $Body.Item('ids') = ($Ids -join ',') }

    $RequestParams = @{
        Endpoint = '/v1/groups'
        Method   = 'Get'
        Body     = $Body
        All      = $true
    }

    if ($Id) { $Body.Item('ids') = $RequestParams['Endpoint'] += ('/' + $Id) }

    # Uses a special v2 API call to pull computers from group
    if ($WithComputers) {
        $RequestParams.Remove('Endpoint')
        $RequestParams.Item('Endpoint') = ('/v2/groups/' + $Id + '/computers')
    }

    Invoke-CWAAPI @RequestParams
}
