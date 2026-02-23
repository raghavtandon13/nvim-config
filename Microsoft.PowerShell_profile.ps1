# $env:SHELL_ICON = "🌵"
# Invoke-Expression (&starship init powershell)
# function Invoke-Starship-PreCommand {
#     $current_location = $executionContext.SessionState.Path.CurrentLocation
#     if ($current_location.Provider.Name -eq "FileSystem") {
#         $ansi_escape = [char]27
#         $provider_path = $current_location.ProviderPath -replace "\\", "/"
#         $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
#     }
#     $width = $Host.UI.RawUI.WindowSize.Width
#     $color = "`e[38;2;57;53;82m"
#     $reset = "`e[0m"
#     $line = $color  + ('-' * $width) + $reset
#     $host.ui.Write($prompt)
# }
#
#
# $env:EDITOR = "nvim"
# $env:BAT_PAGING = "never"
# $env:Path += ";$HOME\utils"
# Set-PSReadLineOption -PredictionSource HistoryAndPlugin
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Import-Module git-completion
#
# Set-Alias c cls
# Set-Alias cat bat
# Set-Alias lg lazygit
# Set-Alias ls ls-better
# Set-Alias rm Remove-ItemSafely
Set-Alias vim nvim

# function cal { ~/utils/calendar.ps1  }
# function f { vim(fzf) }
# function which { scoop which $args }
# function cmcounts { 
#     set-location "D:\Code\cred-back\"
#     node helpers\utils\greaatest.js $args
# }
# function cdc { set-location "D:\Code" }
# function desk { set-location "C:\Users\ragha\Desktop" }
# function down { set-location "C:\Users\ragha\Downloads" }
# function e { exit }
# # function exp { $currentDir = Get-Location; Invoke-Item $currentDir }
# function exp { $currentDir = Get-Location; C:\Users\ragha\AppData\Local\Voidstar\FilePilot\FPilot.exe $currentDir }
# function fs { Invoke-FuzzyScoop }
# function k { Invoke-FuzzyKillProcess }
# function kk { sudo Invoke-FuzzyKillProcess }
# function ll { lsd.exe --tree --depth=1 }
# function ls-better { lsd.exe -lAF --blocks date --blocks size  --blocks name $args }
# function lc { nvim leetcode.nvim }
#
# function silicon-make {
#     param(
#         [Parameter(Mandatory)]
#         [string]$File,
#         [string]$Output = ("img-{0}.png" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
#     )
#
#     silicon $File `
#         --output $Output `
#         --no-window-controls `
#         --no-round-corner `
#         --no-line-number `
#         --line-pad 10 `
# 	--theme OneHalfDark `
#         --background '#161616' `
#         --pad-horiz 0 `
#         --pad-vert 0
# }
#
#
# function du {
#     param(
#         [string]$Location = (Get-Location),
#         [string[]]$OptionalParameters = @()
#     )
#     dust -R -r -d 1 $OptionalParameters $Location
# }
#
# function y {
#     $tmp = [System.IO.Path]::GetTempFileName()
#     yazi $args --cwd-file="$tmp"
#     $cwd = Get-Content -Path $tmp
#     if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
#         Set-Location -LiteralPath $cwd
#     }
#     Remove-Item -Path $tmp
# }
#
# function free {
#     $totalMem = (Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory
#     $freeMem = (Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory * 1KB
#     $usedMem = $totalMem - $freeMem
#     "Total: {0:N2} GB, Used: {1:N2} GB, Free: {2:N2} GB" -f ($totalMem / 1GB), ($usedMem / 1GB), ($freeMem / 1GB)
# }
#
# function size {
#     param(
#         [string]$Path,
#         [string]$Unit = "KB"
#     )
#     $sizeInBytes = (Get-ChildItem -Path $Path -Recurse | Measure-Object -Property Length -Sum).Sum
#     switch ($Unit.ToUpper()) {
#         "KB" { $size = $sizeInBytes / 1KB }
#         "MB" { $size = $sizeInBytes / 1MB }
#         "GB" { $size = $sizeInBytes / 1GB }
#         Default { $size = $sizeInBytes / 1KB }
#     }
#     return "$size $unit"
# }
#
# function edge_clear {
#     $FolderPath = "~\AppData\Local\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage"
#     Get-ChildItem -Path $FolderPath -Recurse | Remove-Item -Force -Recurse
# }
#
# function v {
#     param([string]$startPath = "D:/")
#     Set-Location $startPath
#     $excludedDirs = '$RECYCLE.BIN', '.bun', '.cache', '.expo', '.git', '.local', '.logseq', '.obsidian', '.pm2', '.prettierd', '.zsh', 'CrashDumps', 'Games', 'go', 'go-build', 'gopls', 'Microsoft', 'Mongodb Compass', 'node-gyp', 'node_modules', 'NoSQLBooster', 'nvim-data', 'obsidian', 'Packages', 'Postman', 'powerlevel10k', 'PowerShell', 'Rainmeter', 'raycast-x', 'scoop', 'Softdeluxe', 'target', 'Temp', 'tlrc', 'TV', 'uv', 'venv', 'wezterm', 'Windows', 'WindowsPowerShell', 'ZenProfile', 'zig' , 'Edge Extension' ,'dll'
#     $excludedFileTypes = '.dll', '.exe', '.mp4', '.mkv', '.mov', '.avi', '.mp3', '.wav', '.flac', '.zip', '.rar', '.7z', '.png', '.jpg', '.jpeg', '.gif', '.bmp', '.iso'
#     $excludeArgs = $excludedDirs | ForEach-Object { '--exclude', $_ }
#     $excludeFileArgs = $excludedFileTypes | ForEach-Object { '--exclude', "*$_" }
#     $result = fd . $startPath $excludeArgs $excludeFileArgs  -L -H | fzf --expect="alt-z"
#     if ($result) {
#         $joinedSubRes = ($result | ForEach-Object { $_.ToString() }) -join " "
#         $rest = $joinedSubRes.Substring(6)
#         if ($joinedSubRes.Substring(0, 6) -eq "alt-z ") {
#             Write-Host ($rest -replace '\\[^\\]+$','' )
#             $choice = "none","search","explore", "vim", "open", "cat" | fzf --height=10% --layout=reverse --prompt "Choose an app: "
#             Set-Location ($rest -replace '\\[^\\]+$','' )
#             switch ($choice) {
#                 "none" {}
#                 "search" { Invoke-PsFzfRipgrep a }
#                 "explore" { explorer.exe . }
#                 "vim" { vim $rest }
#                 "open" { Invoke-Item $rest }
#                 "cat" { bat $rest }
#             }
#         } else {
#             $extension = [System.IO.Path]::GetExtension($joinedSubRes).ToLower()
#             $nonTextExtensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".mp4", ".avi", ".mkv", ".mov", ".wmv", ".mp3", ".wav", ".flac", ".ogg")
# Set-Location ($joinedSubRes.Substring(1) -replace '\\[^\\]+$','')
#             if ($nonTextExtensions -contains $extension) {
#                 Invoke-Item $joinedSubRes.Substring(1)
#             } else {
#                 vim $joinedSubRes.Substring(1)
#             }
#         }
#     }
# }
#
# function n {
#     Set-Location "D:/Notes"
#     nvim .
# }
#
# function get-dlls {
# 	param ( [string]$app)
# 	objdump -p $app | rg -i "DLL Name" | sort -u | rg -i "DLL Name"
# }
#
# function t {
#     Set-Location "D:/Notes"
#     nvim .
# }
#
# function scoop-Update {
#     scoop update
#     echo(scoop status)
#     scoop status | % {scoop update $_.Name}
#     scoop cache rm * && scoop cleanup * && scoop checkup
# }
#
# function winget-Update {
#     winget upgrade
#     Get-WinGetPackage | ? IsUpdateAvailable | % { winget update $_.Id --accept-package-agreements --accept-source-agreements }
#     Get-WinGetPackage | ? IsUpdateAvailable | % { winget install $_.Id --force --accept-package-agreements --accept-source-agreements }
# }
#
# function aws-servers {
#     $regions = @("ap-south-1", "ap-southeast-2")
#     foreach ($region in $regions) {
#         Write-Host "`nRegion: $region" -ForegroundColor Cyan
#         aws ec2 describe-instances --region $region --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" --output table
#     }
# }
#
# function aws-restart {
#     param ( [Parameter(Mandatory = $true)] [string]$InstanceName)
#     $regions = @("ap-south-1", "ap-southeast-2")
#     $found = $false
#
#     foreach ($region in $regions) {
#         Write-Host "`nSearching in region: $region" -ForegroundColor Yellow
#         $instanceId = aws ec2 describe-instances --region $region --filters "Name=tag:Name,Values=$InstanceName" --query "Reservations[].Instances[?State.Name=='running'].InstanceId" --output text
#         if ($instanceId) {
#             Write-Host "✅ Found instance '$InstanceName' with ID $instanceId in region $region" -ForegroundColor Green
#             $confirmation = Read-Host "⚠️  This is a critical action. Type 'YES' to reboot the instance"
#             if ($confirmation -eq "YES") {
#                 aws ec2 reboot-instances --region $region --instance-ids $instanceId
#                 Write-Host "Reboot command sent." -ForegroundColor Cyan
#             } else { Write-Host "❌ Reboot cancelled by user." -ForegroundColor Red }
#             $found = $true
#             break
#         }
#     }
#     if (-not $found) {
#         Write-Host "❌ Instance '$InstanceName' not found or not in 'running' state in the allowed regions." -ForegroundColor Red
#     }
# }
