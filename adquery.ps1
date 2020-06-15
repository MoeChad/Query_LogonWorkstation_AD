function Get-LogonWorkstation {
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [string]$UserName
    )

    try {
        $Account = Get-AdUser -Identity $Username -Properties LogonWorkstations | Select-Object -ExpandProperty Logonworkstations
        Write-Verbose -Message ('Located user {0}' -f $UserName) 
    }
    catch {
        Throw ('Unable to locate user {0}' -f $UserName)
    }

    $Account -split ',' | ForEach-Object {
    $Computer = Get-ADComputer -Identity $_ -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Enabled
        if($computer -eq $True) {
        New-Object -TypeName PSCustomObject -Property @{
            MachineName = $_;
           'In Active Directory' = 'True';
        }
    }

        else {
            New-Object -TypeName PSCustomObject -Property @{
            MachineName = $_;
           'In Active Directory' = 'False';
           }
        }
    } |Export-Csv -path C:\Powershell\data.csv

}
  

        
