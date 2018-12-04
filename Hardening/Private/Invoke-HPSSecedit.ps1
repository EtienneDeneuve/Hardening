Function Invoke-HPSSecedit {

    <#
        .SYNOPSIS
        n/a

        .DESCRIPTION
        n/a

        .PARAMETER Arguments
        n/a

        .PARAMETER SeceditPath
        n/a

        .EXAMPLE
        Invoke-HPSSecEdit -Arguments "/configure /db ${tempDB} /cfg ${FilePath}"

        .INPUTS
        System.String

        .OUTPUTS
        System.Object

        .LINK
        https://hardening.thomas-illiet.fr/Private/Invoke-HPSSecedit/

        .LINK
        https://github.com/thomas-illiet/Hardening/blob/stable/Hardening/Private/Invoke-HPSSecedit.ps1

        .LINK
        https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.process

        .LINK
        https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.processstartinfo

        .NOTES
        - File Name : Invoke-HPSSecedit.ps1
        - Author    : Thomas ILLIET
    #>

    [CmdletBinding( HelpUri = "https://hardening.thomas-illiet.fr/Private/Invoke-HPSSecedit/" )]
    [OutputType( [System.Object] )]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Arguments,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $SeceditPath = "C:\Windows\System32\Secedit.exe"
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
    }

    process {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"

        if ( Test-Path -Path $SeceditPath ) {

            $StandardOut = @()

            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Configure secedit process"
            $StartInfo = New-Object System.Diagnostics.ProcessStartInfo
            $StartInfo.FileName = $SeceditPath
            $StartInfo.Arguments = $Arguments
            $StartInfo.RedirectStandardOutput = $True
            $StartInfo.StandardOutputEncoding = [System.Text.Encoding]::UTF8
            $StartInfo.UseShellExecute = $False
            $Startinfo.CreateNoWindow = $True

            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Start secedit process"
            $Process = New-Object System.Diagnostics.Process
            $Process.StartInfo = $StartInfo
            $Process.Start() | Out-Null

            # Add standard output in variable $StandardOut
            while ( $process.StandardOutput.Peek() -gt -1 ) {
                Write-Verbose "[$($MyInvocation.MyCommand.Name)] $($process.StandardOutput.ReadLine())"
                $StandardOut += $process.StandardOutput.ReadLine()
            }

            # Instructs the Process component to wait indefinitely for the associated process to exit.
            $Process.WaitForExit()

            # Gets the exit code of the process.
            if ( $Process.ExitCode -eq 0 ) {
                Write-Verbose "[$($MyInvocation.MyCommand.Name)] The operation completed successfully."
            }
            else {
                Write-Error "Incorrect function : $StandardOut"
            }

            # Return Secedit Output
            Return $StandardOut
        }
        else {
            Write-Error "[$($MyInvocation.MyCommand.Name)] Could not find the secedit executable : $SecEditPath"
        }
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
