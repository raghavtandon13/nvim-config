$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}
Invoke-Expression (&starship init powershell)
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Import-Module posh-git
$env:EDITOR = "nvim"

Set-Alias c cls
Set-Alias cat bat
Set-Alias lg lazygit
Set-Alias ls lsd
Set-Alias rm Remove-ItemSafely
Set-Alias vim nvim

function  f { vim(fzf) }
function cdc { set-location "D:\Code" }
function desk { set-location "C:\Users\ragha\Desktop" }
function down { set-location "C:\Users\ragha\Downloads" }
function e { exit }
function exp { $currentDir = Get-Location; Invoke-Item $currentDir }
function fs { Invoke-FuzzyScoop } 
function k { Invoke-FuzzyKillProcess } 
function kk { sudo Invoke-FuzzyKillProcess } 
function ll { lsd.exe --tree --depth=1 }
function pg($name) { Get-Process | Where-Object { $_.Name -like "*$name*" } }
function pk($name) { Get-Process $name -ErrorAction SilentlyContinue | Stop-Process }
function tm { Start-Process "taskmgr.exe" }

function du { 
    param(
        [string]$Location = (Get-Location),
        [string[]]$OptionalParameters = @()
    )
    dust -R -r -d 1 $OptionalParameters $Location 
}
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

function li {
    param($Location = (Get-Location))
    param ([string[]]$OptionalParameters = @())
    lsd -1 --icon never $OptionalParameters 
}

function server {
        Set-Location -Path "$HOME\Downloads"
        ssh -i "cred.pem" ubuntu@ec2-3-27-146-211.ap-southeast-2.compute.amazonaws.com
}
function server2 {
        Set-Location -Path "$HOME\Downloads"
	 ssh -i "cred-2.pem" ec2-user@ec2-13-201-83-62.ap-south-1.compute.amazonaws.com
}
function server3 {
        Set-Location -Path "$HOME\Downloads"
	ssh -i "cred-3.pem" ec2-user@ec2-13-201-75-238.ap-south-1.compute.amazonaws.com
}

function killer {
    $processes = @("edge","msedge", "msedgewebview2", "MSPCManager", "nearby_share", "thunderbird","postman")
        $errors = @()
        foreach ($proc in $processes) { Get-Process $proc -ErrorAction SilentlyContinue | Stop-Process }
}

function free {
    $totalMem = (Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory
    $freeMem = (Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory * 1KB
    $usedMem = $totalMem - $freeMem
    "Total: {0:N2} GB, Used: {1:N2} GB, Free: {2:N2} GB" -f ($totalMem / 1GB), ($usedMem / 1GB), ($freeMem / 1GB)
}

function size {
    param(
            [string]$Path,
            [string]$Unit = "KB"
         )
        $sizeInBytes = (Get-ChildItem -Path $Path -Recurse | Measure-Object -Property Length -Sum).Sum
        switch ($Unit.ToUpper()) {
            "KB" { $size = $sizeInBytes / 1KB }
            "MB" { $size = $sizeInBytes / 1MB }
            "GB" { $size = $sizeInBytes / 1GB }
            Default { $size = $sizeInBytes / 1KB }
        }
    return "$size $unit"
}


function edge_clear {
    $FolderPath = "~\AppData\Local\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage"
    Get-ChildItem -Path $FolderPath -Recurse | Remove-Item -Force -Recurse
}


function v {
    param([string]$startPath = "D:/")
    Set-Location $startPath
    $excludedDirs = "Windows", "node_modules", "venv", "Games", "TV", ".cache", "scoop", "Microsoft", "nvim-data", "Packages", "Temp", "node-gyp", "gopls", "go-build", "Postman", ".git", "Rainmeter", ".obsidian", "obsidian", "$RECYCLE.BIN", "go"
    $excludeArgs = $excludedDirs | ForEach-Object { '--exclude', $_ }
    $result = fd . $startPath $excludeArgs -L -H | fzf --expect="alt-z"
    if ($result) {
        $joinedSubRes = ($result | ForEach-Object { $_.ToString() }) -join " "
        $rest = $joinedSubRes.Substring(6)
        if ($joinedSubRes.Substring(0, 6) -eq "alt-z ") {
            Write-Host ($rest -replace '\\[^\\]+$','' )
            $choice = "none","search","explore", "vim", "open", "cat" | fzf --height=10% --layout=reverse --prompt "Choose an app: "
            Set-Location ($rest -replace '\\[^\\]+$','' )
            switch ($choice) {
		"none" {}
		"search" { Invoke-PsFzfRipgrep a }
		"explore" { explorer.exe . }
                "vim" { vim $rest }
                "open" { Invoke-Item $rest }
                "cat" { bat $rest }
            }
        } else {
            $extension = [System.IO.Path]::GetExtension($joinedSubRes).ToLower()
            $nonTextExtensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".mp4", ".avi", ".mkv", ".mov", ".wmv", ".mp3", ".wav", ".flac", ".ogg")
            Set-Location ($joinedSubRes.Substring(1) -replace '\\[^\\]+$','')
            if ($nonTextExtensions -contains $extension) {
                Invoke-Item $joinedSubRes.Substring(1)
            } else {
                vim $joinedSubRes.Substring(1)
            }
        }
    }
}

function n {
    Set-Location "D:/Notes"
    nvim .
}

function Phone-Reboot {
    param ([string]$DeviceNumber)
    $adbCommand = "adb connect 192.168.1.62:$DeviceNumber"
    $adbOutput = Invoke-Expression $adbCommand
    if ($adbOutput -match "connected to 192.168.1.62:$DeviceNumber") {
        adb reboot
        Write-Host "Device rebooted successfully."
    } else {
        Write-Host "Connection failed."
    }
}

function scoop-Update {
    scoop update
    echo(scoop status)
    scoop status | % {scoop update $_.Name}
    scoop cache rm * && scoop cleanup * && scoop checkup
}

function winget-Update {
    Get-WinGetPackage | ? IsUpdateAvailable | % {winget update $_.Id}
}


function Get-FileSizeInfo {
    param(
        [Parameter(Mandatory=$true)]
        [string]$filter  # Makes the filter argument mandatory
    )

    $spinner = @('\', '|', '/', '-')
    $spinnerIndex = 0

    # Show the loading spinner in a background job
    $spinnerJob = Start-Job -ScriptBlock {
        while ($true) {
            $global:spinnerIndex++
            $global:spinnerIndex %= 4
            Write-Host -NoNewline "$($global:spinner[$global:spinnerIndex]) Loading... "
            Start-Sleep -Milliseconds 200
            Write-Host -NoNewline "`r"
        }
    }

    try {
        # Main logic for fetching file size information
        Get-ChildItem -Recurse -Filter $filter -ErrorAction SilentlyContinue | Select-Object FullName, @{Name="Size"; Expression={
            if ($_.PSIsContainer) {
                $size = (Get-ChildItem $_.FullName -Recurse | Measure-Object -Property Length -Sum).Sum
            } else {
                $size = $_.Length
            }
            $size
        }}, @{Name="ReadableSize"; Expression={
            if ($_.PSIsContainer) {
                $size = (Get-ChildItem $_.FullName -Recurse | Measure-Object -Property Length -Sum).Sum
            } else {
                $size = $_.Length
            }
            if ($size -gt 1GB) { "{0:N2} GB" -f ($size / 1GB) }
            elseif ($size -gt 1MB) { "{0:N2} MB" -f ($size / 1MB) }
            elseif ($size -gt 1KB) { "{0:N2} KB" -f ($size / 1KB) }
            else { "$size Bytes" }
        }} | Sort-Object Size -Descending | Select-Object FullName, ReadableSize
    } finally {
        # Stop the spinner once done
        Stop-Job -Job $spinnerJob
    }
}


