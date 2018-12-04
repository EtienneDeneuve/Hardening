Function Get-HPSModulePath {

    <#
        .SYNOPSIS
        Get current module path

        .DESCRIPTION
        Simple function to get module path with $ModulePath, and allow to makes it easy to test the project functions.

        .EXAMPLE
        Get-HPSModulePath

        .OUTPUTS
        System.String

        .LINK
        https://hardening.thomas-illiet.fr/Private/Get-HPSModulePath/

        .LINK
        https://github.com/thomas-illiet/HardenedPS/blob/stable/Src/Private/Get-HPSModulePath.ps1

        .NOTES
        - File Name : Get-HPSModulePath.ps1
        - Author    : Thomas ILLIET
    #>

    [CmdletBinding( HelpUri = "https://hardening.thomas-illiet.fr/Private/Get-HPSModulePath/" )]
    [OutputType( [System.String] )]
    Param()

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
    }

    process {
        return $Script:ModulePath
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
