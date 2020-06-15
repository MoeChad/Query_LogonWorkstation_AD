function Get-LogonWorkstation {
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [string]$Username
    )

    try {
        $Account = Get-ADUser -Identity $Username -Properties LogonWorkstations | Select-Object -ExpandProperty LogonWorkstations
        Write-Verbose -Message ('Located User {0}' -f $Username)
    }
    catch {
        Throw('Unable to locate user {0}' -f $Username)
    }

    $Account -split ',' | ForEach-Object {
    $Computer = Get-ADComputer -Identity $_ -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Enabled
        [PSCustomObject]@{
            ComputerName = $_
            Enabled = [bool]$Computer.Enabled
            }
        } | Export-csv -Path data.csv
}
