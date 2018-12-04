Function Compare-HPSSecurityPolicy {

    <#
        .SYNOPSIS
        n/a

        .DESCRIPTION
        n/a

        .PARAMETER ReferenceObject
        n/a

        .PARAMETER DifferenceObject
        n/a

        .PARAMETER Detail
        n/a

        .EXAMPLE
        Compare-HPSSecurityPolicy -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject

        .INPUTS
        System.Object

        .OUTPUTS
        System.Object

        .LINK
        https://hardening.thomas-illiet.fr/Private/Compare-HPSSecurityPolicy/

        .LINK
        https://github.com/thomas-illiet/Hardening/blob/stable/Hardening/Private/Compare-HPSSecurityPolicy/.ps1

        .NOTES
        - File Name : Compare-HPSSecurityPolicy.ps1
        - Author    : Thomas ILLIET
    #>

    [CmdletBinding( HelpUri = "https://hardening.thomas-illiet.fr/Private/Compare-HPSSecurityPolicy/" )]
    [OutputType( [System.Object] )]
    Param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Object]
        $ReferenceObject,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Object]
        $DifferenceObject,

        [Parameter()]
        [System.boolean]
        $Detail = $false
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
    }

    process {
        $CompareResult = Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject -Property 'Name', 'Value' -IncludeEqual
        if ( $Detail -eq $False ) {
            if ( ( $CompareResult | Where-Object {$_.SideIndicator -eq '<='} ).count -eq 0 ) {
                return $true
            }
            else {
                return $false
            }
        }
        else {
            return $CompareResult | Where-Object { ( $_.SideIndicator -eq '<=' ) -or ( $_.SideIndicator -eq '==' ) }
        }
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
