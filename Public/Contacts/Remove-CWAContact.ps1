function Remove-CWAContact {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('Id')]
        [int32]$ContactId
    )

    begin {
        $RequestParams = @{
            Method = 'Delete'
        }
    }

    process {
        foreach ($Id in $ContactId) {
            Write-Debug "Removing Contact with ID: $Id and Email: $($_.EmailAddress)"
            $RequestParams['Endpoint'] = ('/v2/Contacts/' + $Id)
            Invoke-CWAAPI @RequestParams
        }
    }
}
