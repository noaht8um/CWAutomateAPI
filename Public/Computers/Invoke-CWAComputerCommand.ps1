function Invoke-CWAComputerCommand {
    [CmdletBinding(DefaultParameterSetName = 'PowerShell')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [object[]]$Computer,

        [Parameter(ParameterSetName = 'PresetCommand', Mandatory = $true)]
        [ValidateSet('Scanning Services', 'FasTalk', 'Change Service Login')]
        [string]$Command,

        [Parameter(ParameterSetName = 'PowerShell', Mandatory = $true)]
        [string]$PowerShell,

        [Parameter(ParameterSetName = 'PowerShell')]
        [switch]$PowerShellCore
    )

    begin {
        $PendingCommands = [System.Collections.Generic.List[hashtable]]::new()
        $CompletedCommands = [System.Collections.Generic.List[int32]]::new()
        if ($PowerShell) {
            $CommandId = 2
            #$ScriptString = $PowerShell.ToString()
            #$ScriptString = ($ExecutionContext.InvokeCommand.ExpandString($PowerShell))
            $ScriptString = $PowerShell
            $Base64 = [Convert]::ToBase64String( [Text.Encoding]::Unicode.GetBytes($ScriptString))
            $Prefix = "powershell.exe!!! -Command `"&{[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes([Management.Automation.PSSerializer]::Serialize([ScriptBlock]::Create([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('"
            $Suffix = "'))).Invoke())))}`""
            $Parameters = $Prefix + $Base64 + $Suffix
        }

        if ($Command) {
            switch ($Command) {
                'Scanning Services' { $CommandId = 28 }
                'FasTalk' { $CommandId = 35 }
                'Change Service Login' { $CommandId = 111 }
            }
            $Parameters = 1
        }

        $Body = @{
            Command    = @{
                Id = $CommandId
            }
            Parameters = @($Parameters)
        }
    }

    process {
        foreach ($C in $Computer) {
            $Id = $C.Id
            # Issue command and return command id
            $Body['ComputerId'] = $Id
            $RequestParams = @{
                Endpoint = "/v1/Computers/$Id/CommandExecute"
                Method   = 'Post'
                Body     = $Body
            }

            $CommandId = (Invoke-CWAAPI @RequestParams).Id
            $FasTalkStatus = $C.IsFasTalk

            # Enable FasTalk if it's not already enabled
            if ((!$FasTalkStatus) -and ($Command -ne 'FasTalk')) {
                # Quick and dirty enable fastalk
                Invoke-CWAAPI -Method 'Post' -Endpoint "/v1/Computers/$Id/CommandExecute" -Body @{ComputerId = $Id; Command = @{Id = 35 }; Parameters = @(1) } | Out-Null
            }

            $CommandHash = @{
                Computer  = $C
                CommandId = $CommandId
            }

            $PendingCommands.Add($CommandHash)
        }
    }

    end {
        $AttemptCount = 0
        do {
            foreach ($Object in $PendingCommands) {
                # Don't check commands where we've already got the results.
                if ($Object.CommandId -in $CompletedCommands) { continue }

                # Get command status body
                $RequestParams = @{
                    Endpoint = "/v1/Computers/$($Object.Computer.Id)/CommandExecute/$($Object.CommandId)"
                    Method   = 'Get'
                }

                $CommandResult = Invoke-CWAAPI @RequestParams
                if ($CommandResult.Status -eq 'Success') {
                    $CompletedCommands.Add($Object.CommandId)
                    $Output = [PSCustomObject]@{
                        Computer = $Object.Computer
                        Raw      = $CommandResult
                    }
                    if (($PowerShell) -and ($CommandResult.Output -ne 'ERR')) {
                        #$Output['Output'] = $CommandResult.Output | ConvertFrom-CWABase64Object
                        $Output = $Output | Select-Object @{Name = 'Output'; Expression = { $CommandResult.Output | ConvertFrom-CWABase64Object } }, *
                    } else {
                        #$Output['Output'] = $CommandResult.Output
                        $Output = $Output | Select-Object @{Name = 'Output'; Expression = { $CommandResult.Output } }, *
                    }
                    $Output
                }
                Start-Sleep 1
            }
            $AttemptCount++
        } while (($AttemptCount -ge 60) -or ($CompletedCommands.Count -lt $PendingCommands.Count))
    }
}
