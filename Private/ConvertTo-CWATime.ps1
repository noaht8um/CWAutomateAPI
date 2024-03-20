function ConvertTo-CWATime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [datetime]$Date
    )

    Get-Date -Date $Date -Format 'yyyy-MM-ddTHH:mm:sszzz'
}
