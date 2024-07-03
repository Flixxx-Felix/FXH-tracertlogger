<#
.SYNOPSIS
    PowerShell Traceroute Logger Script.

.DESCRIPTION
    The script monitors the network routing to different or individual addresses. It can be used for monitoring or problem analysis.

.NOTES
    File: FXH-tracertlogger.ps1
    Author: Felix Haller
    Date: July 3, 2024
    Version: 1.0

.CREDITS
    - Developed by: Felix Haller (https://github.com/Flixxx-Felix)

.LINK
    GitHub Repository: https://github.com/Flixxx-Felix/FXH-tracertlogger
#>

### Variables ###
$urls = @()
$enableLoop = Read-Host "Should the script be executed repeatedly? (true/false)"
$filePath = "C:\Users\$env:username\Desktop\fxh-tracertlog.txt"

### Loop for entering URLs ###
while ($true) {
    $url = Read-Host "Enter URLs (or Enter to exit)"
    
    if ([string]::IsNullOrWhiteSpace($url)) {
        break
    }

    $urls += $url
}

Write-Host "The following URLs are monitored:`$urls" | Out-File -FilePath $filePath -Append

Write-Host "`Routing monitoring started"

if ($enableLoop -ne $True){
    foreach ($url in $urls) {
        # Query and document system time
        Get-Date -Format "dd.MM.yyyy HH:mm:ss K" | Out-File -FilePath $filePath -Append

        # Execute and document Tracert
        tracert $url | Out-File -FilePath $filePath -Append
    }
} else {
    # Script wird wiederholt ausgeführt, bis zum manuellen Stop
    while ($enableLoop -eq $True) {
        foreach ($url in $urls) {
            # Query and document system time
            Get-Date -Format "dd.MM.yyyy HH:mm:ss K" | Out-File -FilePath $filePath -Append
    
            # Execute and document Tracert
            tracert $url | Out-File -FilePath $filePath -Append
        }
        # Prevent DoS Attacks, 15 Minutes sleep
        Start-Sleep -Seconds 900 
    }
}
