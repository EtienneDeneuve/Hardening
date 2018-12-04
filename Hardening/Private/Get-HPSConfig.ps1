Function Get-HPSConfig {

    <#
        .SYNOPSIS
        n/a

        .DESCRIPTION
        n/a

        .PARAMETER Name
        n/a

        .EXAMPLE
        Get-HPSConfiguration -Name 'AccountPolicy'

        .INPUTS
        System.String

        .OUTPUTS
        System.Object

        .LINK
        https://hardening.thomas-illiet.fr/Private/Get-HPSConfiguration

        .LINK
        https://github.com/thomas-illiet/Hardening/blob/stable/Hardening/Private/Get-HPSConfiguration.ps1

        .NOTES
        - File Name : Get-HPSConfiguration.ps1
        - Author    : Thomas ILLIET
    #>

    [CmdletBinding( HelpUri = "https://hardening.thomas-illiet.fr/Private/Get-HPSConfiguration" )]
    [OutputType( [System.Object] )]
    Param(
        [Parameter( Mandatory = $True )]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Name
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
    }

    process {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"

        $ConfigDirectory = Join-Path -Path ( Get-HPSModulePath ) -ChildPath 'Config'
        $ConfigFile = Join-Path -Path $ConfigDirectory -ChildPath "${Name}.psd1"

        if( Test-Path $ConfigFile ) {
            Import-PowerShellDataFile -Path $ConfigFile
        } else {
            Write-Error "Unable to find the named configuration '${Name}' in the configuration directory"
        }
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
