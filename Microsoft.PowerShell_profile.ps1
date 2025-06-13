# Prompt looks like this:
# 🌵 D:\Home\AppData\Local\nvim  main
# ➜
function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\" 
    }

    $reset = "`e[0m"
    $dim = "`e[38;5;245m"           # Dim gray for path
    $lavender = "`e[38;2;203;166;247m"  # Hex #cba6f7

    # Git branch
    $branch = ""
    try {
        $gitDir = git rev-parse --git-dir 2>$null
        if ($LASTEXITCODE -eq 0) {
            $branchName = git symbolic-ref --short HEAD 2>$null
            if ($branchName) {
                $branch = " $lavender $branchName$reset"
            }
        }
    } catch {}

    return "🌵 $osc7$p$reset$branch`n➜ "
}

$env:EDITOR = "nvim"
$env:BAT_PAGING = "never"
Set-Alias c cls
Set-Alias cat bat
Set-Alias lg lazygit
Set-Alias ls ls-better
Set-Alias rm Remove-ItemSafely
Set-Alias vim nvim

function f { vim(fzf) }
function which { scoop which $args }
function cdc { set-location "D:\Code" }
function desk { set-location "C:\Users\ragha\Desktop" }
function down { set-location "C:\Users\ragha\Downloads" }
function e { exit }
function exp { $currentDir = Get-Location; Invoke-Item $currentDir }
function fs { Invoke-FuzzyScoop }
function k { Invoke-FuzzyKillProcess }
function kk { sudo Invoke-FuzzyKillProcess }
function ll { lsd.exe --tree --depth=1 }
function ls-better { lsd.exe -lAF --blocks date --blocks size --blocks git --blocks name $args }

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

function server {
    Set-Location -Path "$HOME\Downloads"
    ssh -i "cred.pem" ubuntu@ec2-13-236-84-117.ap-southeast-2.compute.amazonaws.com
}
function server2 {
    Set-Location -Path "$HOME\Downloads"
    ssh -i "cred-2.pem" ec2-user@ec2-13-201-83-62.ap-south-1.compute.amazonaws.com
}
function server3 {
    Set-Location -Path "$HOME\Downloads"
    ssh -i "cred-3.pem" ec2-user@ec2-3-108-59-42.ap-south-1.compute.amazonaws.com
}
function serverls {
    Set-Location -Path "$HOME\Downloads"
    ssh -i "ls-main.pem" ec2-user@ec2-13-233-136-167.ap-south-1.compute.amazonaws.com
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
    $excludedDirs = "Windows", "node_modules", "venv", "Games", "TV", ".cache", ".bun", "scoop", "Microsoft", "nvim-data", "Packages", "Temp", "node-gyp", "gopls", "go-build", "Postman", ".git", "Rainmeter", ".obsidian", "obsidian", "$RECYCLE.BIN", "go", "powerlevel10k", ".expo", ".logseq", ".local", "ZenProfile", "zig", "WindowsPowerShell", "PowerShell", ".zsh", "Mongodb Compass"
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

function scoop-Update {
    scoop update
    echo(scoop status)
    scoop status | % {scoop update $_.Name}
    scoop cache rm * && scoop cleanup * && scoop checkup
}

function winget-Update {
    winget upgrade
    Get-WinGetPackage | ? IsUpdateAvailable | % {winget update $_.Id}
    Get-WinGetPackage | ? IsUpdateAvailable | % {winget install $_.Id --force}
}
