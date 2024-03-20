function Get-CWADeploymentLogin {
    [CmdletBinding(DefaultParameterSetName = 'AllPasswordsClient')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'SinglePassword')]
        [int32]$Id,

        [Parameter(Mandatory = $true, ParameterSetName = 'AllPasswordsClient')]
        [Parameter(Mandatory = $true, ParameterSetName = 'AllPasswordsLocation')]
        [Parameter(Mandatory = $true, ParameterSetName = 'SinglePassword')]
        [int32]$ClientId,

        [Parameter(Mandatory = $true, ParameterSetName = 'AllPasswordsLocation')]
        [int32]$LocationId,

        [Parameter(Mandatory = $false)]
        [switch]$WithPassword
    )

    $Body = @{
        pageSize = 1000
    }

    if ($Id) { $Body.Item('condition') = ('DeploymentLoginId=' + $Id) }

    $RequestParams = @{
        Endpoint = ('/v1/clients/' + $ClientId + '/deploymentlogins')
        Method         = 'Get'
        Body           = $Body
        All            = $true
    }

    if ($WithPassword) {
        $Response = Invoke-CWAAPI @RequestParams
        $RequestParams.Body.Remove('page')
        $RequestParams.Body.Item('includeFields') = 'password'
        $Passwords = Invoke-CWAAPI @RequestParams

        foreach ($item in $Response) {
            $Password = ($Passwords | Where-Object { $_.DeploymentLoginId -eq $item.DeploymentLoginId }).Password
            Add-Member -InputObject $item -MemberType NoteProperty -Name 'Password' -Value $Password
        }
        if ($LocationId) { return $Response | Where-Object { $_.Location.LocationId -eq $LocationId } }
        return $Response
    }

    $Response = Invoke-CWAAPI @RequestParams

    if ($LocationId) { return $Response | Where-Object { $_.Location.LocationId -eq $LocationId } }

    return $Response
}
