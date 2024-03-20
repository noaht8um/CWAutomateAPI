function Invoke-CWAScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int32]$ScriptId,

        [Parameter(Mandatory = $true)]
        [int[]]$ComputerIds,

        [Parameter(Mandatory = $false)]
        [bool]$SkipOfflineAgents = $true,

        [Parameter(Mandatory = $false)]
        [int32]$Priority = 12,

        [Parameter(Mandatory = $false)]
        [string]$StartDate = (ConvertTo-CWATime -Date (Get-Date))
    )

    $Body = @{
        EntityType         = 1
        EntityIds          = $ComputerIds
        ScriptId           = $ScriptId
        Schedule           = @{
            ScriptScheduleFrequency = @{
                ScriptScheduleFrequencyId = 1
            }
        }
        Parameters         = @()
        UseAgentTime       = $false
        StartDate          = $StartDate
        OfflineActionFlags = @{
            SkipsOfflineAgents = $SkipOfflineAgents
        }
        Priority           = $Priority
    }

    $RequestParams = @{
        Body     = $Body
        Endpoint = '/v1/Batch/ScriptSchedule'
        Method   = 'Post'
    }

    $Response = Invoke-CWAAPI @RequestParams

    if ($Response.ContainsUnsuccessfulResults) { return $Response }

    return $Response.ScriptResults
}
